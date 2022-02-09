class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #The dependent: :destroy argument says, when a user gets deleted, all posts what the user has created will be deleted too.
  has_many :posts, dependent: :destroy
  has_many :private_messages, class_name:'Private::Message'
  has_many :private_conversations, foreign_key: :sender_id, class_name: 'Private::Conversation'
end
