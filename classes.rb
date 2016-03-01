class Message
  attr_accessor :id,:source_guid,:created_at,:user_id,:group_id,:avatar_url,:name,:text,:system,:picture_url,:location,:favorited_by

  def initialize(args={})
    @id = args[:id]
    @source_guid = args[:source_guid]
    @created_at = args[:created_at]
    @user_id = args[:user_id]
    @group_id = args[:group_id]
    @avatar_url = args[:avatar_url]
    @name = args[:name]
    @text = args[:text]
    @system = args[:system]
    @picture_url = args[:picture_url]
    @location = args[:location]
    @favorited_by = args[:favorited_by]
  end
end

class Member
  attr_accessor :id,:name

  def initialize(args={})
    @id = args[:id]
    @name = args[:name]
  end
end