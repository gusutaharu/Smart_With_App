class CategoriesController < ApplicationController
  def index
    @category_hardware = Category.where(ancestry: nil)
  end

  def get_os
    @selected_hardware = Category.find("#{params[:hardware_id]}")
    @category_os = @selected_hardware.children
  end

  def get_condition
    @selected_os = Category.find("#{params[:os_id]}")
    @selected_hardware = @selected_os.parent
    @category_condition = @selected_os.children
  end
end
