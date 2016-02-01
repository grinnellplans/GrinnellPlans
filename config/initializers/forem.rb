Forem.user_class = "Account"
Forem.sign_in_path = "/login"
Forem.email_from_address = APP_CONFIG['from_address']
Forem.moderate_first_post = false
# If you do not want to use gravatar for avatars then specify the method to use here:
# Forem.avatar_user_method = :custom_avatar_url
Forem.per_page = 20

Forem.formatter = Forem::PlansFormatter

Rails.application.config.to_prepare do
  Forem::ApplicationController.layout "notes"
#
#   If you want to add your own cancan Abilities to Forem, uncomment and customize the next line:
#   Forem::Ability.register_ability(Ability)
end
