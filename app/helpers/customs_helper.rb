module CustomsHelper
  def choose_path(model)
    if action_name == "new"
      customs_path
    elsif action_name == "edit"
      custom_path(model.id)
    end
  end
end
