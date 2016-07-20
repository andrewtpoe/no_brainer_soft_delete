require 'nobrainer'

class User
  include NoBrainer::Document

  has_many :projects
end

class Project
  include NoBrainer::Document
  include NoBrainerSoftDelete

  belongs_to :user, required: true

  before_destroy :test_before_destroy
  after_destroy :test_after_destroy

  def test_before_destroy; end
  def test_after_destroy; end
end
