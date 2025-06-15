class DocumentsController < ApplicationController
  before_action :require_login
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  def index
    @documents = Document.all
    @document = Document.new
  end

  def show
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)
    @document.name = document_params[:image].original_filename
    if @document.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to documents_path }
      end
    else
      flash.now[:error] = "Invalid inputs"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @document.update(document_params)
      redirect_to edit_document_path(@document), notice: "Document was successfully updated"
    else
      flash.now[:error] = "Invalid inputs"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @document.destroy
    redirect_to documents_path, notice: "Document was successfully destroyed"
  end

  private
  def document_params
    params.require(:document).permit(:annotation, :image)
  end

  def set_document
    @document = Document.find(params[:id])
  end
end
