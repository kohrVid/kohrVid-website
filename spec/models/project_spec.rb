require 'rails_helper'

RSpec.describe Project, type: :model do
  it 'must have required fields or be invalid' do
    c = Project.new
    expect(c).to_not be_valid
  end

  it 'creates a new project with valid attributes' do
    expect {
      Project.create(FactoryBot.attributes_for(:project))
    }.to change(Project, :count).by(1)
  end

  context 'Name' do
    it 'must be present' do
      expect {
        Project.create(FactoryBot.attributes_for(:project, name: ''))
      }.to_not change(Project, :count)
    end

    it 'must produce an error if no name is given' do
      c = Project.new
      expect(c.errors[:name]).to_not be_nil
    end
  end

  context 'published project' do
    # Note, currently unable to test published projects when :image appears in
    # the list below so have had to remove it for the time being
    required_publishing_attrs = %i(repo_url languages description)

    required_publishing_attrs.each do |attr|
      it 'is present' do
        expect {
          Project.create(FactoryBot.attributes_for(
            :project, draft: false, attr => ''
          ))
        }.to_not change(Project, :count)
      end

      it 'produces the relevant error when missing' do
        c = Project.new
        expect(c.errors[attr]).to_not be_nil
      end
    end
  end

  describe 'scopes' do
    let(:project1) { FactoryBot.create(:project, draft: true) }
    let(:project2) { FactoryBot.create(:project, draft: false) }
    let(:project3) { FactoryBot.create(:project, draft: true) }
    let(:project4) { FactoryBot.create(:project, draft: false) }

    before do
      project1
      project2
      project3
      project4
    end

    context ".draft" do
      subject { Project.drafts }

      it 'should contain all draft projects' do
        is_expected.to include(project1)
        is_expected.to include(project3)
      end

      it 'should not contain any public projects' do
        is_expected.to_not include(project2)
        is_expected.to_not include(project4)
      end
    end

    context ".published" do
      subject { Project.published }

      it 'should contain all published projects' do
        is_expected.to include(project2)
        is_expected.to include(project4)
      end

      it 'should not contain any draft projects' do
        is_expected.to_not include(project1)
        is_expected.to_not include(project3)
      end
    end
  end
end
