class StaticPagesController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  def index
    @guestbooks = Guestbook.all.reverse_order.limit(5) || []
    @blogs = [Blog.last] || []
  end

  def contact
  	if cookies[:sent_contact]
  		render 'no_contact'
  	else
  		render 'contact'
  	end
  	# binding.pry
  	# @contact = { name: '', email: '', message: '' }
  end

  def tehachapi
    # @hotels = YAML.load_file("config/tehachapi_hotels.yml")[Rails.env]['hotels']
    @hotels = YAML.load_file("config/tehachapi_hotels.yml")[Rails.env]['hotels']
    weather = Weather.new
    @current_weather = weather.get_current
    @weather_forcast = weather.get_forcast
    @current_weather['description'] = weather.code_description(@current_weather['weatherCode'])
  end

  def restaurants
    @restaurants = YAML.load_file("config/tehachapi_restaurants.yml")[Rails.env]['restaurants']
  end

  def hotels
    @hotels = YAML.load_file("config/tehachapi_hotels.yml")[Rails.env]['hotels']
    weather = Weather.new
    @current_weather = weather.get_current
    @weather_forcast = weather.get_forcast
    binding.pry
    @current_weather['description'] = weather.code_description(@current_weather['weatherCode'])
    render partial: 'hotel_listing'
  end

  def send_mail
  	if params && params[:name] && params[:email] && params[:message] && params[:subject]
  		if cookies[:sent_contact].present?
  			flash[:error] = 'You can only send one email every 10 minutes.'
  		else
	  		if  params[:subject] == 'Wedding Contact'
		  		if Contact.contact_email(params).deliver
		  			cookies[:sent_contact] = { value: "sent a question at zkforever", expires: 10.minutes.from_now}
		  			flash[:success] = 'Email was sent. We will respond as soon as we can.'
		  		else
		  			flash[:error] = 'There was an unknown issue sending your email. Please try again'
		  		end
		  	else
		  		flash[:error] = 'Subject line incorrect'
		  	end
		  end
  	end
  	return redirect_to(contact_path)
  end
end
