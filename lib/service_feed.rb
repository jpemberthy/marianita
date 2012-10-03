module ServiceFeed
  def self.included(base)
    base.send(:include, Mongoid::Document)
    base.send(:extend, ClassMethods)
  end

  module ClassMethods
    def acts_as_service_feed(opts={})
      service_feed_id_name = "#{opts[:service_name]}_id"

      field :user_id, type: Integer
      field :karma, type: Integer
      field "#{service_feed_id_name}", type: String

      validates_presence_of :user_id, "#{service_feed_id_name}"
      validates_uniqueness_of "#{service_feed_id_name}"

      scope :popular, order_by("karma DESC")

      define_singleton_method("create_from_service") do |user_id, service_feed|
        service_feed.symbolize_keys!
        service_feed_id = service_feed[:id]
        opts[:delete_keys].each { |key| service_feed.delete(key) }

        if feed = where("#{service_feed_id_name}" => service_feed_id).first
          feed.update_from_service_feed(service_feed)
        else
          service_feed.merge!(user_id: user_id, "#{service_feed_id_name}" => service_feed_id)
          create(service_feed)
        end
      end

      send :include, InstanceMethods
    end
  end

  module InstanceMethods
    def update_from_service_feed(service_feed)
      update_attributes(service_feed)
    end
  end
end
