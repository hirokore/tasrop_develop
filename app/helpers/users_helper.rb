module UsersHelper
  def friend_sort( current_user)
    users_ids = []
    current_user.follower_ids.each do |id| 
      users_ids << id if current_user.following_ids.include? id
    end
    users_sort = users_ids.map { |id| User.find(id) }
  end  
end