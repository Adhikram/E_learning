class EnrollsController < ApplicationController
  before_action :set_enroll, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token

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
    if Course.find(@data[:course_id]).limit== Course.find(@data[:course_id]).students.count || Student.find(@data[:student_id]).courses.exists?(Course.find(@data[:course_id]).id)
      if Student.find(@data[:student_id]).courses.exists?(Course.find(@data[:course_id]).id)
        respond_to do |format|
          format.html { redirect_to @data, notice: "Already addded to the course" }
          format.json { render json: "Already addded to the course"  }
        end
      else
        respond_to do |format|
          format.html { redirect_to @data, notice: "Course limit has reached" }
          format.json { render json: "Course limit has reached"  }
        end
      end
    else
      @enroll = Enroll.new(@data)
    # render json: @enroll
      respond_to do |format|
        if @enroll.save
          format.html { redirect_to @enroll, notice: "Enroll was successfully created." }
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
    @enroll.destroy
    respond_to do |format|
      format.html { redirect_to enrolls_url, notice: "Enroll was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enroll
      @enroll = Enroll.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def enroll_params
      params.require(:enroll).permit(:student_id, :course_id)
    end
end
