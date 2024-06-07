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
  def execute
    #don't do anything if params is empty
    return unless params['name']
    return unless params['patronymic']
    return unless params['email']
    return unless params['age']
    return unless params['nationality']
    return unless params['country']
    return unless params['gender']
    ##########
    return if User.where(email: params['email'])
    return if params['age'] <= 0 || params['age'] > 90
    return if params['gender'] != 'male' || params['gender'] != 'female'

    user_full_name = "#{params['surname']} #{params['name']} #{params['patronymic']}"
    user_params = params.except(:interests)
    user = User.create(user_params.merge(user_full_name))

    Interest.where(name: params['interests']).each do |interest|
      user.interests = user.interest + interest
      user.save!
    end

    user_skills = []
    params['skills'].split(',').each do |skil|
      skil = Skil.find(name: skil)
      user_skills += [skil]
    end
    user.skills = user_skills
    user.save
  end
end
