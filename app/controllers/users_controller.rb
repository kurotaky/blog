class UsersController < ApplicationController

  def new
    # 最初はkurotakyのみ使えるBlogにする
    # @user = User.new
  end

  def create
    # @user = User.new(user_params)

    # # only proceed with pretty names
    # if @user and @user.username and @user.username.size > 0

    #   # create randome nonce
    #   @user.eth_nonce = SecureRandom.uuid

    #   if @user.eth_address
    #     # make sure the eth address is valid
    #     address = Eth::Address.new @user.eth_address
    #     if address.valid?
    #       if @user.save
    #         redirect_to login_path, notice: "Successfully created an account, you may now log in."
    #       else
    #         redirect_to login_path, alert: "Account already exists! Try to log in instead!"
    #       end
    #     else
    #       flash.now[:alert] = "Invalid Ethereum address!"
    #       render :new
    #     end
    #   else
    #     flash.now[:alert] = "Failed to get Ethereum address!"
    #     render :new
    #   end
    # else
    #   flash.now[:alert] = "Please choose a name (length > 0)!"
    #   render :new
    # end
  end

  private

  def user_params
    params.require(:user).permit(:username, :eth_address)
  end
end
