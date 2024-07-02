module GoogleParser
  class InvalidJsModelError < StandardError; end

  module Selectors
    JS_MODELS = {
      "hspDDf" => {
        organic_results: {
          container: "div.Gx5Zad.fP1Qef.xpd.EtOod.pkphOe",
          title: "h3 > div",
          description: "div.BNeawe.s3v9rd.AP7Wnd",
          breadcrumbs: "div.BNeawe.UPmit.AP7Wnd.lRVwie",
          url: "a[href]",
        },
        ads: {
          container: "div.uEierd",
          title: "h3 > div",
          description: "div.BNeawe.s3v9rd.AP7Wnd",
          breadcrumbs: "div.BNeawe.UPmit.AP7Wnd",
          url: "a[href]",
          ad_label: "span.uEierd",
        }
      }
    }

    def self.for(jsmodel)
      JS_MODELS.keys.each do |key|
        return JS_MODELS[key] if jsmodel.include?(key)
      end

      raise GoogleParser::InvalidJsModelError, "Could not find selectors for jsmodel: \"#{jsmodel}\""
    end
  end
end
