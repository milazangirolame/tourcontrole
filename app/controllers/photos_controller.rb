class PhotosController < ApplicationController

  def destroy
    @photo = Photo.find(params[:id])
    authorize @photo
    @photo.destroy
    if @photo.destroy
      flash[:notice] = "Imagem excluida com sucesso"
      redirect_back fallback_location: root_path
    end
  end
end
