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
    edit_plan_path current_account
  end
end
