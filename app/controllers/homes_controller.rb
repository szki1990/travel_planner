class HomesController < ApplicationController
  def top
  end
  
  def about
  end 
  
  def index
    @welcome_message = I18n.t('hello')
  end
end
