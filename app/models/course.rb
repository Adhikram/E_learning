class Course < ApplicationRecord
    has_many:enrolls
    has_many:students , through: :enrolls
end
