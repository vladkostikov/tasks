# User object in database
# name string
# surname string
# patronymic string
# fullname string
# email string
# age integer
# nationality string
# country string
# interests array
# gender string
# skills string
class User < ApplicationRecord
  has_many :interests
  has_many :skills, class_name: 'Skil'
end

# Interest object in database
# name string
class Interest < ApplicationRecord
  has_many :users
end

# Skil object in database
# name string
class Skil < ApplicationRecord
  has_many :users
end

# In application we are using ActiveInteraction gem => https://github.com/AaronLasseigne/active_interaction
class Users::Create < ActiveInteraction::Base
  hash :params do
    string :name, :patronymic, :email, :nationality, :country, :gender
    string :surname, default: nil
    integer :age
    array :interests, default: nil
    string :skills, default: nil
  end

  validates :name, :patronymic, :email, :nationality, :country, :gender, :age, presence: true
  validates :age, numericality: { greater_than: 0, less_than_or_equal_to: 90 }
  validates :gender, inclusion: { in: %w[male female] }
  validate :email_uniqueness

  def execute
    user = User.create(user_params)

    assign_interests(user)
    assign_skills(user)

    user.save
  end

  private

  def email_uniqueness
    errors.add_sym(:email, :not_unique) if User.exists?(email: email)
  end

  def user_params
    params.except(:interests, :skills, :fullname).merge(fullname: user_full_name)
  end

  def user_full_name
    "#{params['surname']} #{params['name']} #{params['patronymic']}"
  end

  def assign_interests(user)
    return if params['interests'].blank?

    interests = Interest.where(name: params['interests'])
    user.interests = interests
  end

  def assign_skills(user)
    return if params['skills'].blank?

    skill_names = params['skills'].split(',').map(&:strip)
    skills = Skil.where(name: skill_names)
    user.skills = skills
  end
end
