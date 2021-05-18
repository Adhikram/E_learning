json.extract! course, :id, :name, :limit, :details, :created_at, :updated_at
json.url course_url(course, format: :json)
