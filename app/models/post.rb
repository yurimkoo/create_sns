class Post < ActiveRecord::Base
    resourcify
    include Authority::Abilities
    
    belongs_to :user
    has_many :comments
    has_many :likes
    
    validates :title, presence: {message: "제목이 작성되지 않았습니다."}, length: {minimum: 2}
    validates :content, presence: {message: "내용이 작성되지 않았습니다."}
end
