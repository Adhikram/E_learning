class EnrollsController < ApplicationController
  # before_action :set_enroll, only: %i[ show edit update destroy ]
  # skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  # GET /enrolls or /enrolls.json
  def index
    @enrolls = Enroll.all
  end

  # GET /enrolls/1 or /enrolls/1.json
  def show
  end

  # GET /enrolls/new
  def new
    @enroll = Enroll.new
  end

  # GET /enrolls/1/edit
  def edit
  end

  # POST /enrolls or /enrolls.json
  def create
    @data=enroll_params
    if Course.find(@data[:course_id]).limit== Course.find(@data[:course_id]).students.count || Student.find(current_user.id).courses.exists?(Course.find(@data[:course_id]).id)
      if Student.find(current_user.id).courses.exists?(Course.find(@data[:course_id]).id)
        respond_to do |format|
          format.html { redirect_to courses_url, notice: "Already addded to the course" }
          format.json { render json: "Already addded to the course"  }
        end
      else
        respond_to do |format|
          format.html { redirect_to courses_url, notice: "Course limit has reached" }
          format.json { render json: "Course limit has reached"  }
        end
      end
    else
      @enroll = Enroll.create(student_id:current_user.id, course_id:@data[:course_id])
    # render json: @enroll
      respond_to do |format|
        if @enroll.save
          format.html { redirect_to courses_url, notice: "Enroll was successfully created." }
          format.json { render :show, status: :created, location: @enroll }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @enroll.errors, status: :unprocessable_entity }
        end
    end

    
    end
  end

  # PATCH/PUT /enrolls/1 or /enrolls/1.json
  def update
    respond_to do |format|
      if @enroll.update(enroll_params)
        format.html { redirect_to @enroll, notice: "Enroll was successfully updated." }
        format.json { render :show, status: :ok, location: @enroll }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @enroll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enrolls/1 or /enrolls/1.json
  def destroy
    # @data=enroll_params
    Enroll.where(:student_id => current_user.id, :course_id => params[:id]).destroy()
 
    respond_to do |format|
      format.html { redirect_to courses_url, notice: "Enroll was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_enroll
    #   # render json:params
    #   @enroll = Enroll.find(params[:id])
    # end

    # Only allow a list of trusted parameters through.
    def enroll_params
      # render json:params
      params.require(:enroll).permit(:course_id)
    end
end
