def movie_attributes(overrides = {})
  {
    title: "Iron Man",
    rating: "PG-13",
    total_gross: 318412101.00,
    description: "Tony Stark builds an armored suit to fight the throes of evil",
    released_on: "2008-05-02",
    cast: "Robert Downey Jr., Gwyneth Paltrow and Terrence Howard",
    director: "Jon Favreau",
    duration: "126 min",
    # image_file_name: "ironman.jpg"
    image: open("#{Rails.root}/app/assets/images/ironman.jpg")
  }.merge(overrides)
end

def movie_no_image_attributes(overrides = {})
  {
    title: "Iron Man",
    rating: "PG-13",
    total_gross: 318412101.00,
    description: "Tony Stark builds an armored suit to fight the throes of evil",
    released_on: "2008-05-02",
    cast: "Robert Downey Jr., Gwyneth Paltrow and Terrence Howard",
    director: "Jon Favreau",
    duration: "126 min",
    # image_file_name: "ironman.jpg"
    # image: open("#{Rails.root}/app/assets/images/ironman.jpg")
  }.merge(overrides)
end

def review_attributes(overrides={})
  {
    name: "Roger Ebert",
    stars: 3,
    comment: "I laughed, I cried, I spilled my popcorn!",
    location: "New York, NY"
  }.merge(overrides)
end

def user_attributes(overrides={})
  {
    name: "Joe Bloggs",
    username: "jbloggs",
    email: "jbloggs@example.com",
    password: "Password01",
    password_confirmation: "Password01"
  }.merge(overrides)
end

def admin_user_attributes(overrides={})
  {
    name: "Joe Admin",
    username: "jadmin",
    email: "jadmins@example.com",
    password: "Password01",
    password_confirmation: "Password01",
    admin: true
  }.merge(overrides)
end
