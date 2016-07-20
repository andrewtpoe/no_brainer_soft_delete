require 'spec_helper'

describe NoBrainerSoftDelete do
  it "has a version number" do
    expect(NoBrainerSoftDelete::VERSION).to be_truthy
  end

  describe "initial setup" do
    let!(:user) { User.create }

    before do
      10.times do
        Project.create(user: user)
      end
    end

    it "has a user with 10 related projects" do
      expect(user.projects.unscoped.count).to eq 10
    end

    describe "destroying and restoring a document" do
      before do
        @project = user.projects.first
      end

      describe "#destroy" do
        it "sets deleted_at time on the document to Time.now" do
          Timecop.freeze do
            @project.destroy
            expect(@project.deleted_at).to eq Time.now
          end
        end

        it "returns true when a document is destroyed" do
          expect(@project.destroy).to eq true
        end
      end

      describe "#really_destroy!" do
        it "completely deletes the document, removing it from the database" do
          expect {
            @project.really_destroy!
          }.to change { Project.unscoped.count }.by(-1)
        end

        it "fires the before and after_destroy callbacks" do
          expect(@project).to receive(:test_before_destroy)
          expect(@project).to receive(:test_after_destroy)
          @project.really_destroy!
        end
      end

      describe "#restore" do
        before do
          @project.destroy
          @project = Project.unscoped.find(@project.id)
        end

        it "sets deleted_at time on the document to nil" do
          @project.restore
          expect(@project.deleted_at).to eq nil
        end

        it "returns true when a document is restored" do
          expect(@project.restore).to eq true
        end
      end

      describe "Model#restore" do
        before do
          @project.destroy
          @project = Project.unscoped.find(@project.id)
        end

        it "finds and restores a document that has been deleted" do
          expect {
            Project.restore(@project.id)
          }.to change { Project.count }.by(1)
        end
      end

      describe "#deleted?" do
        before do
          @project.destroy
          @project = Project.unscoped.find(@project.id)
        end

        it "returns true if the document has been destroyed" do
          expect(@project.deleted?).to eq true
        end

        it "returns false if the document has not been destroyed" do
          @project.restore
          expect(@project.deleted?).to eq false
        end
      end
    end

    describe "querying an association" do
      before do
        @deleted_records = []
        3.times do
          project = user.projects.first
          @deleted_records << project
          project.destroy
        end
      end

      it "Model.count only returns vehicles that have not been deleted" do
        expect(Project.count).to eq 7
      end

      it "does not return the soft deleted records with a default query" do
        @deleted_records.each do |r|
          expect{ Project.find(r.id) }.to raise_error(NoBrainer::Error::DocumentNotFound)
        end
      end

      describe "#with_deleted" do
        it "returns all documents, regardless of whether they have been soft deleted" do
          expect(Project.with_deleted.count).to eq 10
        end
      end

      describe "#only_deleted" do
        it "only returns documents that have been soft deleted" do
          expect(Project.only_deleted.count).to eq 3
        end
      end
    end
  end
end
