module GoogleParser
  class OrganicResult
    attr_accessor :position, :title, :description, :breadcrumbs, :url, :domain, :root_domain

    def initialize(position:, title:, description:, breadcrumbs:, url:, domain:, root_domain:)
      @position = position
      @title = title
      @description = description
      @breadcrumbs = breadcrumbs
      @url = url
      @domain = domain
      @root_domain = root_domain
    end
  end
end
