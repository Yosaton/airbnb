class UsersController < Clearance::UsersController
  def index
    @listings = Listing.all.order(:title).page params[:page]
    # @listing = Listing.find(params[:id])
    @user = current_user
  end

  private

  def user_from_params
    email = user_params.delete(:email)
    password = user_params.delete(:password)
    first_name = user_params.delete(:first_name)
    last_name = user_params.delete(:last_name)
    avatar = user_params.delete(:avatar)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
      user.first_name = first_name
      user.last_name = last_name
      user.avatar = avatar
    end
  end
end





# Just need to send this shit to send an email once the user has signed up... buw how.. clearance crazy.
# class UsersController < ApplicationController
#   # POST /users
#   # POST /users.json
#   def create
#     @user = User.new(params[:user])
 
#     respond_to do |format|
#       if @user.save
#         # Tell the UserMailer to send a welcome email after save
#         UserMailer.welcome_email(@user).deliver_later
 
#         format.html { redirect_to(@user, notice: 'User was successfully created.') }
#         format.json { render json: @user, status: :created, location: @user }
#       else
#         format.html { render action: 'new' }
#         format.json { render json: @user.errors, status: :unprocessable_entity }
#       end
#     end
#   end
# end