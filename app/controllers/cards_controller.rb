class CardsController < ApplicationController

  before_action :logged_in_user, only: [:new, :create]
  before_action :load_card, only: [:show, :edit, :update]
  before_filter :find_post, only: [:show]

  def new
    @card = Card.new
  end

  def create
    @card = current_user.cards.new(card_params)
    if @card.save
      # UserMailer.send_invitation(@invitation, current_user, check_invitation_url(@invitation)).deliver_now
      flash[:success] = 'Contenido creado!'
      redirect_to @card
    else
      render 'new'
    end
  end

  def index
    # @cards = Card.all
    if params[:category]
      if Card.categories.include? params[:category]
        @title = params[:category].pluralize.capitalize
        @cards = Card.where(category: Card.categories[params[:category]])  
      else
        raise ActionController::RoutingError, 'Not Found'
      end
    else
      @title = 'Todas las tarjetas'
      @cards = Card.all
    end
  end

  def show
  end

  def edit
  end

  def update
    @card.update_attributes card_params
    redirect_to @card
  end

  private

    def card_params
      params.require(:card).permit(:title, :content, :category)
    end

    def load_card
      @card = Card.friendly.find(params[:id])
    end

    def find_post
      #@card = Card.find params[:id]

      # If an old id or a numeric id was used to find the record, then
      # the request path will not match the post_path, and we should do
      # a 301 redirect that uses the current friendly id.
      if request.path != card_path(@card)
        return redirect_to @card, :status => :moved_permanently
      end
    end

end
