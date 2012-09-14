class TokensAddOauthTokenScret < ActiveRecord::Migration
  def change
    add_column :tokens, :oauth_token_secret, :string
  end
end
