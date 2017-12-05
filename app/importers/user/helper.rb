module User::Helper
  def self.full_name(user)
    if user[:middlename] != nil
    "#{user[:sn]} #{user[:givenname]} #{user[:middlename]}"
    else
      "#{user[:sn]} #{user[:givenname]}"
    end
  end
  def self.short_name(user)
    short_name = "#{user[:sn]} #{user[:givenname][0]}."
    short_name << " #{user[:middlename][0]}." if  user[:middlename] != nil
    short_name
  end
end
