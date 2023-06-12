module Timestampable
  def timestamp
    created_at.strftime '%Y-%m-%d %H:%M'
  end
end