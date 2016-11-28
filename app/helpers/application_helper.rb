module ApplicationHelper
  # Helper to yield common CSS classes for lists
  # Iterates through the given collection and yields three arguments for each member:
  #  * The member
  #  * An array of classes including either "odd" or "even", and "first"/"last" as relevant
  #  * The index of this member
  def each_with_list_classes(collection, &block)
    collection.each_with_index do |item, index|
      classes = []
      classes << (index.odd? ? "odd" : "even")
      classes << "first" if index.zero?
      classes << "last" if index == collection.count
      yield item, classes, index
    end
  end

  def edit_current_plan_path
    main_app.edit_plan_path current_account
  end

  def quicklove_path
    main_app.search_plans_path q: "[#{current_account.username}]"
  end

  def notes_path
    forem.forum_path "default"
  end

  def dynamic_link_helper(helper_name)
    if respond_to? helper_name
      send helper_name
    else
      main_app.send helper_name
    end
  end

  # Simple helper to render an informational message.
  # Takes a block that yields the body of the message.
  def info_message(title="Info", &block)
    render layout: "/flash_message", locals: { title: title, css_class: "infomessage" }, &block
  end

  # Simple helper to render an alert message.
  # Takes a block that yields the body of the message.
  def alert_message(title="Alert", &block)
    render layout: "/flash_message", locals: { title: title, css_class: "alertmessage" }, &block
  end

  def last_updated_user_link
    last_updated = current_account.last_updated_visible_user
    link_to last_updated.username, main_app.read_plan_path(id: last_updated.username)
  end
end
