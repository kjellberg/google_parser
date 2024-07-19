# frozen_string_literal: true

module GoogleParser
  module Elements
    class AdResult
      attr_accessor :title, :description, :breadcrumbs, :url, :domain, :root_domain, :ad_label

      def initialize(title:, description:, breadcrumbs:, url:, domain:, root_domain:, ad_label:)
        @title = title
        @description = description
        @breadcrumbs = breadcrumbs
        @url = url
        @domain = domain
        @root_domain = root_domain
        @ad_label = ad_label
      end
    end
  end
end
