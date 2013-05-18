# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# this will quickly go out of date

u1 = User.find_or_create_by_email(:email => "a@a.com", :password => "example", :password_confirmation => "example", :first_name => "first", :last_name => "last")
u1.avatar = Image.new
u1.galleries = [Gallery.create(:title => "A Gallery", :images => [Image.new, Image.new, Image.new])] if u1.galleries.blank?
u1.credits = [Credit.create(:title => "Credit 1"), Credit.create(:title => "Credit 2"), Credit.create(:title => "Credit 3"), Credit.create(:title => "Credit 4")] if u1.credits.blank?
u1.cinis = [Cini.create(:one_sheet => Image.create, :synopsis => "Cini Synopsis", :location => "Cini Location", :log_line => "Cini Logline", :title => "Cini Title", :is_hidden => false, :is_published => true)] if u1.cinis.blank?
u1.account_type = AccountType.find_by_name("creative")
u1.save

u2 = User.create(:email => "b@b.com", :password => "example", :password_confirmation => "example", :first_name => "first", :last_name => "last")
#u1.cinis = [Cini.create(:one_sheet => Image.create, :synopsis => "Cini Synopsis", :location => "Cini Location", :log_line => "Cini Logline", :title => "Cini Title", :is_hidden => false, :is_published => true)]
u2.save
