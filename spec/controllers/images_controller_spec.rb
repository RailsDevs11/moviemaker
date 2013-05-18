require 'spec_helper'
require "cancan/matchers"
describe ImagesController do
	include Devise::TestHelpers
  before(:each) do
    @logged_in_user = User.make!
  end

  describe "GET #delete_image_comment" do

    before(:each) do
		  sign_in @logged_in_user
    end
    
    it "comment creator should be able to delete own comment" do
      @other_user = User.make!#this is other user that is not logged in
      @gallery = Gallery.make!(:galleryable => @other_user)# Owner of this gallery is other user not logged in user
      @image = Image.make!(:imageable => @gallery)
      @comment = Comment.make!(:ownerable => @logged_in_user, :commentable => @image)# comment creator is logged in user
      get :delete_image_comment, :gallery_id => @gallery.id, :id=> @comment.id
      response.should render_template "images/create_image_comment.js"
    end

    it "owner of image should be able to delete comment" do
      @other_user = User.make!#this is other user that is not logged in
      @gallery = Gallery.make!(:galleryable => @logged_in_user)# owner of this gallery is logged in (current_user) user
      @image = Image.make!(:imageable => @gallery)
      @comment = Comment.make!(:commentable => @image, :ownerable => @other_user)# comment creator is other user
      get :delete_image_comment, :gallery_id => @gallery.id, :id=> @comment.id
      response.should render_template "images/create_image_comment.js"
    end

    it "login user is not comment creator and not the owner of image then should not be able to delete comment access and redirect to home" do
      @other_user = User.make!#this is other user that is not logged in
      @gallery = Gallery.make!(:galleryable => @other_user)# Owner of this gallery is other user not logged in user
      @image = Image.make!(:imageable => @gallery)
      @comment = Comment.make!(:commentable => @image, :ownerable => @other_user)# comment creator is other user not logged in user
      get :delete_image_comment, :gallery_id => @gallery.id, :id=> @comment.id
      response.should redirect_to("/")#cancan will redirect it to cinimaker home page
    end
  end

  describe "GET #delete_image_comment for not not logged in user" do
    it "not logged in user should be able to delete the comment" do
      @other_user = User.make!#this is other user that is not logged in
      @gallery = Gallery.make!(:galleryable => @other_user)# Owner of this gallery is other user not logged in user
      @image = Image.make!(:imageable => @gallery)
      @comment = Comment.make!(:ownerable => @logged_in_user, :commentable => @image)# comment creator is logged in user
      get :delete_image_comment, :gallery_id => @gallery.id, :id=> @comment.id
      response.should redirect_to("/")#cancan will redirect it cinimaker root page
    end
  end
end
