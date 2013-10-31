require "rubygems"
require "simpleconsole"
require "active_record"

#require 'sqlite3'
#require './app/models/user'

class ConsoleController < SimpleConsole::Controller
	def default
		#self.Test
		addresses = %w[user@foo.COM THE_US-ER@foo.bar.org first.last@foo.jp]
		addresses.each do |address|
			puts address
		end

		self.TestingUserWithPasswordDB

=begin
		e_u = User.new()
		puts e_u.name if !e_u.name.nil?
		e_u.name = "Example User"
		puts e_u.name if !e_u.name.nil?
		e_u.email = "user@example.com"
		puts e_u.formatted_email if !e_u.email.nil?

		puts "-- 4.6 Exercises --"
		@w = Word.new("hello")
		puts @w.splitShuffleJoin

		params = {:father => person1 = { :first => "John", :last => "Father" } , :mother => person2 = { :first => "Mary", :last => "Mother" }, :child =>person3 = { :first => "Aimy", :last => "Child" }}
		puts params[:father][:first]
		puts params[:mother][:last]
		puts params[:child]
=end

	end

	def TestingUserDB
		user = User.new(name: "", email: "mhartl@example.com")
		
		#puts @user.id
		#puts @user.name
		#ActiveRecord::Base.connection.execute("BEGIN TRANSACTION; END;")

		user.save
		puts user.errors.full_messages
		#puts @user.updated_at
		#puts User.create(name: "Another Person", email: "another@example.org")
		foo = User.create(name: "Foo", email: "foo@bar.com")
		puts foo
		puts foo.destroy
		u = User.find(1)
		puts u.id
		puts User.find_by_email("mhartl@example.com")
		puts User.first
		puts "-- list all --"
		puts User.all
		#puts User.find(9)

		u = User.find(1)
		u.email = "mhartl@example.net"
		u.save
		u.update_attributes(name: "Michal Heartl", email: "mhartl@example.org")
		u = User.find(1)
		puts u.id.to_s + " " + u.name.to_s + " " + u.email.to_s + " " + u.created_at.to_s + " " + u.updated_at.to_s
	end

	def TestingUserWithPasswordDB
		u = User.new(name: "Michael Hartl", email: "mhartl@example.com", password: "foobar", password_confirmation: "foobar")
		u.save
		u = User.find(1)
		puts u.id.to_s + " " + u.name.to_s + " " + u.email.to_s + " " + u.created_at.to_s + " " + u.updated_at.to_s + " " + u.password_digest.to_s
		u2 = User.create(name: "Michael Hartl", email: "mhartl@example.com", password: "foobar", password_confirmation: "fooba")
		puts u2.authenticate("invalid")
		puts u2.authenticate("foobar").password_digest
		#puts u2.id.to_s + " " + u2.name.to_s + " " + u2.email.to_s + " " + u2.created_at.to_s + " " + u2.updated_at.to_s + " " + u2.password_digest.to_s
	end

	def Test
		puts "-- BLOCKS --"
		(1..5).each do |number|
			puts 2 * number
			puts '--'
		end

		3.times { puts "Betelgeuse!"}

		puts (1 .. 5).map { |i| i**2}

		puts %w[a b c]
		puts %w[a b c].map { |char| char.upcase}
		puts %w[A B C].map { |char| char.downcase}

		puts "-- HASHES & SYMBOLS --"
		puts user = {}
		puts user["first_name"] = "Michael"
		puts user["last_name"] = "Hartl"
		puts user["first_name"]
		puts user
		puts user = {"first_name" => "Michael", "last_name" => "Hartl"}
		puts user = { :name => "Michael Heartl", :email => "michael@example.com" }
		puts user[:name] if !user[:name].nil?
		puts user[:password] if !user[:password].nil?
		a = ('a'..'z').to_a
		puts a
		puts ('a'..'z').to_a.shuffle[0..7]
		puts "name".split('')
		puts "foobar".reverse
		h1 = { :name => "Michael Hartl", :email => "michael@example.com" }
		h2 = { name: "Michael Hartl", email: "michael@example.com" }
		puts h1
		puts h2
		puts h1 == h2
		params = {}
		params[:user] = {name:"Martin Michalec", email: "martin.michalec@email.com"}
		puts params
		puts params[:user][:email]
		puts params[:user]
		puts flash = { success: "It worked!", error: "It failed." }
		flash.each do |key, value|
			puts "Key #{key.inspect} has value #{value.inspect}"
		end
		puts (1..5).to_a.inspect
		puts :name.inspect
		puts "It worked!", "It worked!".inspect
		p :name
		puts "-- CLASSES --"
		puts s = String.new("Class")
		puts s.class
		puts s.class.superclass
		puts s.class.superclass.superclass
		if s.class.superclass.superclass.superclass.nil?
			puts "nil"
		else
			puts s.class.superclass.superclass.superclass
		end
		puts "-- CLASSES INHERITANCE --"
		@w = Word.new("hello")
		#puts @w.getTheWord
		puts @w.palindrome

		@w2 = Word.new("ewe")
		puts @w2.palindrome

		word2 = Word2.new("level")
		puts word2.palindrome?
		puts word2.length
		#puts "level".palindrome?
	end

	ActiveRecord::Base.establish_connection(
	  :adapter => "sqlite3",
	  :host => "localhost",
	  :database => "db/console.sqlite3"
	  #:username => "appuser",
	  #:password => "secret"
	)

	class User < ActiveRecord::Base
		before_save { self.email = email.downcase }
		validates(:name, presence: true, length: { maximum: 14 })
		VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
		validates(:email, presence:true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false })

		has_secure_password
		validates(:password, length: { minimum: 6 })

	end

	class Word < String
		@@theWord

		def getTheWord
			@@theWord
		end

		def initialize theWord
			@@theWord = theWord
		end

		def palindrome
			puts @@theWord
			@@theWord == @@theWord.reverse
		end

		def splitShuffleJoin()
			@@theWord.split('').shuffle.join
		end
	end

	class Word2 < String
		def palindrome?
			self == self.reverse
		end
	end
end

class ConsoleView < SimpleConsole::View
end

SimpleConsole::Application.run(ARGV, ConsoleController, ConsoleView)
