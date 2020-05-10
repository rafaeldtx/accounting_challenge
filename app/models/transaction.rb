class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :receiver, class_name: Account, foreign_key: :receiver_id
end
