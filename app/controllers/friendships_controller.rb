class FriendshipsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :set_friendship, only: %i[ update destroy ]

  # GET /friendships or /friendships.json
  def index
    @friendships = friendships_by_requester_ids
  end

  # POST /friendships or /friendships.json
  def create
    @friendship = Friendship.new(create_params)

    respond_to do |format|
      if @friendship.save
        format.html { redirect_to @friendship, notice: "Friendship was successfully created." }
        format.json { render :show, status: :created, location: @friendship }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  # Accept or Reject friend request
  def update
    respond_to do |format|
      if @friendship.update(update_params)
        format.html { redirect_to @friendship, notice: "Friendship was successfully updated." }
        format.json { render :show, status: :ok, location: @friendship }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friendships/1 or /friendships/1.json
  def destroy
    @friendship.destroy
    respond_to do |format|
      format.html { redirect_to friendships_url, notice: "Friendship was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friendship
      @friendship = Friendship.find(params[:id])
    end

    def create_params
      params.permit(:user_id, :friend_id, :accepted)
    end

    def update_params
      params.permit(:accepted)
    end

    def friendships_by_receiver_ids
      Friendship.where(user_id: current_user.id)
    end

    def friendships_by_requester_ids
      Friendship.where(friend_id: current_user.id)
    end
end
