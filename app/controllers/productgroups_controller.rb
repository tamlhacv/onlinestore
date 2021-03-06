class ProductgroupsController < ApplicationController
  before_action :get_productgroup, only: [:show]
  before_action :params_productgroup, only: [:create, :update]
  def index
    @productgroups = Productgroup.all
  end

  def show
    @limitproducts = @productgroup.products.page(params[:page])
    @order_item = current_order.order_items.new
  end

  def new
    @productgroup = Productgroup.new
  end

  def create
    @productgroup = Productgroup.new(params_productgroup)
    return render :new, alert: 'Create fail' unless @productgroup.save
    redirect_to productgroup_path(@productgroup), notice: 'Create sucessfully'
  end
  private
    def get_productgroup
      @productgroup = Productgroup.find(params[:id])
    end

    def params_productgroup
      params.require(:productgroup).permit(:title, :description)
    end
end
