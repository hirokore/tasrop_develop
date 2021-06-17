module ApplicationHelper
  def sidebar_custom(name, path)
    class_name = 'channel'
    class_name << ' active' if current_page?(path)

    content_tag :li, class:class_name do
      link_to name, path, class: 'channel_name'
    end
  end

  def daily_task_max_count
    max_count = -1
    current_user.customs.each do |custom|
      max_count += custom.task_ids.count
    end
    max_count
  end
  
  def daily_task_terminate_count
    terminate_count = 0
    current_user.customs.each do |custom|
      custom.task_ids.each do |task_id|
        if TaskStatus.where(created_at: Time.zone.now.all_day).find_by(task_id: task_id).task_status == true
          terminate_count += 1
        end
      end
    end
    terminate_count
  end
  
end
