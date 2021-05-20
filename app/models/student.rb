class Student < ApplicationRecord
    has_many:enrolls
    has_many:courses , through: :enrolls
    belongs_to :user
end
