class Page < ActiveRecord::Base
  belongs_to :user

  searchkick text_search: [:body]
end
