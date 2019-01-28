class PlayerGroupsController < ApplicationController
  before_action :set_player_group, only: [:show, :edit, :update, :destroy]

  # GET /player_groups
  # GET /player_groups.json
  def index
    @player_groups = PlayerGroup.all
  end

  # GET /player_groups/1
  # GET /player_groups/1.json
  def show
  end

  # GET /player_groups/new
  def new
    @player_group = PlayerGroup.new
  end

  # GET /player_groups/1/edit
  def edit
  end

  # POST /player_groups
  # POST /player_groups.json
  def create
    @player_group = PlayerGroup.new(player_group_params)

    respond_to do |format|
      if @player_group.save
        format.html { redirect_to @player_group, notice: 'Player group was successfully created.' }
        format.json { render :show, status: :created, location: @player_group }
      else
        format.html { render :new }
        format.json { render json: @player_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /player_groups/1
  # PATCH/PUT /player_groups/1.json
  def update
    respond_to do |format|
      if @player_group.update(player_group_params)
        format.html { redirect_to @player_group, notice: 'Player group was successfully updated.' }
        format.json { render :show, status: :ok, location: @player_group }
      else
        format.html { render :edit }
        format.json { render json: @player_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /player_groups/1
  # DELETE /player_groups/1.json
  def destroy
    @player_group.destroy
    respond_to do |format|
      format.html { redirect_to player_groups_url, notice: 'Player group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player_group
      @player_group = PlayerGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_group_params
      params.require(:player_group).permit(:group_id, :player_id, :bank)
    end
end
