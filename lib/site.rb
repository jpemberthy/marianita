module Site

  class << self
    ['facebook', 'twitter', 'instagram'].each do |service|
      define_method("#{service}_credentials") do
        credentials_path = File.join(Rails.root, ["config", "#{service}.yml"])
        var_name = "@#{service}_credentials"
        instance_variable_get(var_name) || instance_variable_set(var_name, YAML.load_file(credentials_path)[Rails.env])
      end
    end
  end

end
