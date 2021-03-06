class Post < ActiveRecord::Base

  validates :title, presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: { in: %w(Fiction Non-Fiction) }
  # validates :title, inclusion: { in: (["Won't Believe", "Secret", "Top [number]", "True Facts", "Guess"])}

  validate :is_clickbait?

private

CLICKBAIT_PATTERNS = [
  /Won't Believe/i,
  /Secret/i,
  /Top [0-9]*/i,
  /Guess/i
]
 def is_clickbait?
  if CLICKBAIT_PATTERNS.none? { |pattern| pattern.match(title) }
    errors.add(:title, "must be clickbait")
    end
  end

end
