class DocumentsController < ApplicationController
  before_action :require_login
  before_action :set_document, only: [:show, :edit, :destroy]

  def index
    @documents = Document.all
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
      redirect_to documents_path, notice: "Document was successfully created"
    else
      flash.now[:error] = "Invalid inputs"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
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
