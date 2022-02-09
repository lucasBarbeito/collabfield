class Private::Conversation < ApplicationRecord
  self.table_name = 'private_conversations'

  has_many :messages,
           class_name: "Private::Message",
           foreign_key: :conversation_id
  belongs_to :sender, foreign_key: :sender_id, class_name: "User"
  belongs_to :recipient, foreign_key: :recipient_id, class_name: "User"

  scope :between_users, -> (user1_id, user2_id) do
    where(sender_id: user1_id, recipient_id: user2_id).or(
      where(sender_id: user2_id, recipient_id: user1_id)
    )
  end
end

# class_name Specify the class name of the association. Use it only if that name can't be inferred from the association name.
# So belongs_to :sender will by default be linked to the Sender class, but if the real class name is User, you'll have to specify it with this option.

# The foreign_key is used to specify a name of association’s column in a database table.
# A data column in a table is only created on the belongs_to association’s side, but to make the column recognizable, we’ve to define the foreign_key with same values on both models.