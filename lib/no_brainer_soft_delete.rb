require 'active_support'
require 'nobrainer'
require "no_brainer_soft_delete/version"

module NoBrainerSoftDelete
  extend ActiveSupport::Concern

  included do
    # Set the default scope to only retrieve documents that have not been soft deleted
    default_scope { where(:deleted_at.undefined => true) }

    # Add a deleted_at field to the document, for use with NoBrainerSoftDelete
    field :deleted_at, index: true, type: Time
  end

  class_methods do
    # Returns documents regardless of the value held in deleted_at
    def with_deleted
      unscoped.where(:or => [{ :deleted_at.defined => true }, { :deleted_at.undefined => true }])
    end

    # Returns only documents that have been soft deleted
    def only_deleted
      unscoped.where(:deleted_at.defined => true)
    end

    # Searches for a document and restores it
    def restore(id, options = {})
      with_deleted.where(id: id).first.restore(options)
    end
  end

  # Returns a boolean indicating whether or not a document has been soft deleted
  def deleted?
    !!deleted_at
  end

  # Sets the deleted_at value to the current time, thus marking the document as deleted
  def destroy
    update(deleted_at: Time.now.utc)
  end

  # Completely removes the document from the database, and runs the callbacks.
  def really_destroy!
    _run_destroy_callbacks
    delete
  end

  # Sets the deleted_at value to nil, thus no longer marking the document as deleted
  def restore(options = {})
    update(deleted_at: nil)
  end
end
