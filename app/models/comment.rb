class Comment < ActiveRecord::Base
    belongs_to :post
    
    has_many :likes
    
    validates :userName, presence: {message: "제목이 작성되지 않았습니다."}, length: {minimum: 2}
    validates :content, presence: {message: "내용이 작성되지 않았습니다."}
end