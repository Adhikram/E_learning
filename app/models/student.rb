class Student < ApplicationRecord
    has_many:enrolls
    has_many:courses , through: :enrolls
end
