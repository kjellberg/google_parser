# frozen_string_literal: true

module GoogleParser
  class Selectors
    MAP = {
      artworks: [
        {
          container: ".MiPcId.klitem-tr.mlo-c",
          name: lambda { |element| element.css("div.kltat")&.text&.strip },
          link: lambda { |element| element.css("a.klitem").attr("href")&.value },
          image: lambda { |element| element.css("img.rISBZc.M4dUYb")&.attr("src")&.value },
          year: lambda { |element| element.css(".ellip.klmeta")&.text&.strip }
        }
      ],
      organic_results: [
        {
          container: "div.Gx5Zad.fP1Qef.xpd.EtOod.pkphOe",
          title: "h3 > div",
          description: "div.BNeawe.s3v9rd.AP7Wnd",
          breadcrumbs: "div.BNeawe.UPmit.AP7Wnd.lRVwie",
          url: "a[href]"
        }
      ]
    }

    def initialize(doc)
      @doc = doc
    end

    def find(element)
      MAP[element].each do |selector|
        return selector if @doc.css(selector[:container]).any?
      end
    end
  end
end
