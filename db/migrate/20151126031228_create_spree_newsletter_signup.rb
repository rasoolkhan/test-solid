class CreateSpreeNewsletterSignup < ActiveRecord::Migration
  def change
    create_table :spree_newsletter_signups do |t|
      t.text :email
    end
  end
end
