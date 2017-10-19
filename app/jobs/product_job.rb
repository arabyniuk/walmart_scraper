class ProductJob < ApplicationJob
  queue_as :default

  def perform(url)
    product_page ||= WalmartScraping.new(url)
    product_params ||= product_page.obtain_product_params

    product = Product.find_or_create_by(name: product_params[:name]) do |product|
      product.price = product_params[:price]
    end
    product_reviews = product_page.obtain_reviews
    product_reviews.each do |body|
      Review.create(body: body, product_id: product.id)
    end
  end
end
