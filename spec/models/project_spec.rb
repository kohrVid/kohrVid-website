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
    required_publishing_attrs = %i(image repo_url languages description)

    required_publishing_attrs.each do |attr|
      it 'is present' do
        expect {
          Project.create(FactoryBot.attributes_for(:project, draft: false, attr => ''))
        }.to_not change(Project, :count)
      end

      it 'produces the relevant error when missing' do
        c = Project.new
        expect(c.errors[attr]).to_not be_nil
      end
    end
  end
end
