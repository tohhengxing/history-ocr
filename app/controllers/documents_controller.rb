class DocumentsController < ApplicationController
  before_action :require_login
  before_action :set_document, only: [ :show, :edit, :update, :destroy ]

  def index
    @documents = Document.all
    @document = Document.new
    @document.build_task
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
      flash.now[:error] = "File already exists!"
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("new_document", partial: "form", locals: { document: @document }) }
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    if @document.update(document_params)
      if @document.previous_changes.except(:updated_at).empty?
        flash[:notice] = "No changes were made"
      else
        flash[:notice] = "Document was successfully modified"
      end
      redirect_to edit_document_path(@document)
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
    params.require(:document).permit(:image, :translation, :transcription, :transliteration,
                                     task_attributes: [ :id, :user_id ])
  end

  def set_document
    @document = Document.find(params[:id])
  end
end
