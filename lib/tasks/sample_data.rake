require 'faker'

namespace :db do
	desc "Fill database with data"
	task :populate => :environment do
		Rake::Task['db:reset'].invoke
		make_users
		make_books
		make_favorites
  end
end

def make_users
	#admin = User.create!(	:name => "Example User",
	#											:email => "example@railstutorial.org",
	#											:password => "foobar",
	#											:password_confirmation => "foobar" )
	#admin.toggle!(:admin)

	50.times do |n|
		username	= Faker::Internet.user_name
		name 			= Faker::Name.name
		email 		= "email#{n+1}@aaa.com"
		password 	= "password"
		User.create!( :username => username,
	                  :name => name,
                      :email => email,
					  :password => password,
					  :password_confirmation => password )
	end
end

def make_books
	100.times do |n|
		title 	= Faker::Lorem.sentence(3)
		author 	= Faker::Name.name
		Book.create!( :title => title,
		              :author => author )
	end
	
	Book.all.each do |book|
		book.summary = Faker::Lorem.sentences(9)
		book.save
	end
end

def make_favorites
	books = Book.all
	User.all.each do |user|
		25.times do
			user.add_favorite!(books[Random.rand(100)])
		end
	end
end