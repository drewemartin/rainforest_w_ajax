class ProductsController < ApplicationController
  def index
  	@products = if params[:search]
      Product.where("LOWER(name) LIKE LOWER(?)", "%#{params[:search]}%")
    else
      Product.order('products.created_at DESC').page(params[:page])
    end

    if request.xhr?
      render @products
    end
  end

  
	def show
    @product = Product.find(params[:id])

    if current_user
      @review = @product.reviews.build
    end #if you are a logged in you can make a new review
  end
  

  def new
  	@product = Product.new(params[:id])
  end

  def create
  	@product = Product.new(product_params)
  	if @product
  		@product.save
  		redirect_to products_url
  	else
  		render :new
  	end
  end

  def edit
  	@product = Product.find(params[:id])
  end

  def update
  	@product = Product.find(params[:id])
  	if @product.update_attributes(product_params)
  		redirect_to products_url(@product)
  	else
  		render :edit
  	end
  end

  def delete
  	@product = Product.find(params[:id])
  	@product.destroy
  	redirect_to products_url
  end

  private
  def product_params
  	params.require(:product).permit(:name, :description, :price_in_cents)
  end
end
