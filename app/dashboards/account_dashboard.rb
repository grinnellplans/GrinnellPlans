require "administrate/base_dashboard"

class AccountDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    interests_in_others: Field::HasMany.with_options(class_name: "Autofinger"),
    people_that_interest_me: Field::HasMany.with_options(class_name: "Account"),
    board_votes: Field::HasMany,
    opt_links: Field::HasMany,
    avail_links: Field::HasMany,
    permission: Field::HasOne,
    poll_votes: Field::HasMany,
    stylesheet: Field::HasOne,
    main_boards: Field::HasMany,
    sub_boards: Field::HasMany,
    viewed_secret: Field::HasOne,
    plan: Field::HasOne,
    display_item: Field::HasOne,
    userid: Field::Number,
    username: Field::String,
    created: Field::DateTime,
    password: Field::String,
    password_confirmation: Field::String,
    email: Field::Email,
    pseudo: Field::String,
    login: Field::DateTime,
    changed_date: Field::DateTime,
    poll: Field::Number,
    group_bit: Field::String,
    spec_message: Field::String,
    grad_year: Field::String,
    edit_cols: Field::Number,
    edit_rows: Field::Number,
    webview: Field::String,
    notes_asc: Field::String,
    user_type: Field::String,
    show_images: Field::Boolean,
    guest_password: Field::String,
    is_admin: Field::Boolean,
    persistence_token: Field::String,
    password_salt: Field::String,
    perishable_token: Field::String,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :username,
    :email,
    :user_type,
    :login,
    :changed_date,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :userid,
    :username,
    :email,
    :pseudo,
    :user_type,
    :grad_year,
    :is_admin,
    :login,
    :changed_date,
    :created,
    :webview,
    :plan,
    :stylesheet,
  ]

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = SHOW_PAGE_ATTRIBUTES + [
    :password,
    :password_confirmation,
  ]

  def display_resource(account)
    "Account (#{account.username})"
  end
end
