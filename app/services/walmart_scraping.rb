class WalmartScraping
  def initialize(url)
    @browser = Watir::Browser.new :firefox
    @browser.goto url
  end

  def obtain_product_params
    return { name: name, price: price }
  end

  def obtain_reviews
    total = []
    (1..last_pag_num.to_i).each do |number|
      @browser.element(css: ".CustomerReviews-footer .paginator-list").button(text: number.to_s).click
      @browser.element(css: ".CustomerReviews-list").divs(class: "ReviewList-content").each { |el| total << el.element(class: "Collapsable").try(:text) }
    end
    @browser.close
    return total
  end

  def last_pag_num
    @browser.element(css: ".CustomerReviews-footer .paginator-list").lis.last.text
  end

  def name
    @browser.h1(class: "prod-ProductTitle").text
  end

  def price
    @browser.span(class: "Price-characteristic").attribute('content')
  end
end
