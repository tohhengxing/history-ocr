class DocumentsController < ApplicationController
  before_action :require_login

  def index
    @documents = Document.all
  end
end
