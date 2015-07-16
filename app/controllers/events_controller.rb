class EventsController < ApplicationController
  def index
    # @items = Item.active.not_in_cart(session[:cart])
    # @events = @items.map(&:event).uniq
    # @events = @events.select { |event| event.category.name == params[:category] } if params[:category]

    @items = Item.active.not_in_cart(session[:cart]).paginate(page: params[:page])
    @category = Category.find_by(name: params[:category])
    if @category
      @events = Event.where(category: @category).paginate(page: params[:page])
    else
      @events = Event.all.paginate(page: params[:page])
    end
  end

  def show
    @event = Event.find_by(id: params[:id])
    @items = @event.items.includes(:user).active.not_in_cart(session[:cart]).paginate(page: params[:page])
  end

  def random
    event = Event.find(rand(1..Event.count))
    redirect_to event
  end
end
