class AddRailsHelperToAvailLinks < ActiveRecord::Migration
  def change
    add_column :avail_links, :rails_helper, :string

    reversible do |direction|
      direction.up do
        {
          "Random Plan" => :random_plan,
          "Planwatch" => :recently_updated_plans,
          "Quick Love Search" => :quicklove,
          "Plan Genesis" => :recently_created_plans,
          "Notes" => :notes,
          "Poll" => :polls,
          "Home" => :root,
          "Secrets" => :secrets,
          "List Users" => :accounts,
        }.each do |link_text, helper|
          AvailLink.where(linkname: link_text).update_all(rails_helper: helper)
        end
      end
    end
  end
end
