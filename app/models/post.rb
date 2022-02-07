class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category

  #https://www.rubyguides.com/2019/10/scopes-in-ruby-on-rails/#:~:text=Scopes%20are%20custom%20queries%20that,lambda%2C%20which%20implements%20the%20query.
  default_scope -> { includes(:user).order(created_at: :desc) }

  #The joins method is used to query records from the associated tables. Also the  basic SQL syntax is used to find records, based on provided strings.
  scope :by_category, -> (branch, category_name) do
    joins(:category).where(categories: {name: category_name, branch: branch})
  end

  scope :by_branch, -> (branch) do
    joins(:category).where(categories: {branch: branch})
  end

  scope :search, -> (search) do
    where("title LIKE lower(?) OR content LIKE lower(?)", "%#{search}%", "%#{search}%")
  end

end

