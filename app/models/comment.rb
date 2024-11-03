class Comment < ApplicationRecord
  belongs_to :article
  validates :body, presence: true
  validates :commenter, presence: true

  # Custom validation
  validate :no_political_terms

  private

  # Method to validate that body does not contain forbidden words
  def no_political_terms
    forbidden_words = ["Trump", "Harris"]
    if forbidden_words.any? { |word| body&.include?(word) }
      errors.add(:body, "cannot contain political terms like 'Trump' or 'Harris'")
    end
  end
end

