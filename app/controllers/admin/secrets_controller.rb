module Admin
  class SecretsController < Admin::ApplicationController
    def index
      @filters = %w[unconfirmed accepted rejected]
      @filter = params[:filter]

      # This part is mostly from Administrate, but modified for filters
      search_term = params[:search].to_s.strip
      resources = Administrate::Search.new(resource_resolver, search_term).run
      resources = filter(resources, @filter)
      resources = order.apply(resources)
      resources = resources.page(params[:page]).per(records_per_page)
      page = Administrate::Page::Collection.new(dashboard, order: order)

      render locals: {
        resources: resources,
        search_term: search_term,
        page: page,
      }
    end

    private

    def filter(resources, filter_value)
      case filter_value
      when "unconfirmed"
        resources.where(date_approved: nil)
      when "accepted"
        resources.where(display: "yes")
      when "rejected"
        resources.where(display: "no").where.not(date_approved: nil)
      else
        resources
      end
    end
  end
end
