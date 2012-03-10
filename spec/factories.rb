FactoryGirl.define do

  factory :user do |u|
    u.username "mr_ex"
    u.name "Ed Xavier"
    u.email "ex@example.com"
    u.password "password"
    u.password_confirmation "password"
  end

  factory :book do |b|
    b.title "Bookish Title"
    b.author "Penn McWriterton"
    b.summary "A synopsis! For a Book"
  end
end