require "administrate/base_dashboard"

class SecretDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    secret_id: Field::Number,
    secret_text: Field::Text.with_options(truncate: 9999),
    date: Field::DateTime,
    display: Field::String,
    date_approved: Field::DateTime,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :secret_id,
    :secret_text,
    :date,
    :display,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = ATTRIBUTE_TYPES.keys

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :secret_id,
    :secret_text,
    :date,
    :display,
    :date_approved,
  ]

  # Overwrite this method to customize how secrets are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(secret)
  #   "Secret ##{secret.id}"
  # end
end
