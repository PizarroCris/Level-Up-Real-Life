class GlobalMessage < ApplicationRecord
  belongs_to :profile
  validates :content, presence: true

  broadcasts "global_chat", inserts_by: :prepend
end
