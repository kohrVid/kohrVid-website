require 'rails_helper'

RSpec.describe Job, type: :model do
  let(:subject) { Job.new }

  context "#title" do
    before(:each) do
      subject.save
    end

    it "must have the required attributes" do
      expect(subject).to_not be_valid
    end

    it "should be present" do
      expect(subject.errors[:title]).to_not be_nil
      expect(subject.errors[:title]).to_not be_empty
    end
  end

  context "#company_name" do
    before(:each) do
      subject.save
    end

    it "should be present" do
      expect(subject.errors[:company_name]).to_not be_nil
      expect(subject.errors[:company_name]).to_not be_empty
    end
  end

  context "#company_website" do
  end

  context "#start_date" do
    it "should be present" do
      subject.save
      expect(subject.errors[:start_date]).to_not be_nil
      expect(subject.errors[:start_date]).to_not be_empty
    end

    it "should be in the past" do
      Timecop.freeze(DateTime.new(2020, 01, 06, 23, 41, 57)) do
        subject = FactoryBot.build(
          :job,
          start_date: DateTime.new(2030,01,13)
        )

        subject.save

        expect(subject.errors[:start_date]).to_not be_nil
        expect(subject.errors[:start_date]).to_not be_empty
        expect(subject.errors[:start_date]).to include "must be in the past"
      end
    end
  end

  context "#end_date" do
  end

  context "#format_end_date" do
    let(:time) { Time.local(2020,01,11,23,51) }

    it "should return the word Present if the end_date is nil" do
      job = FactoryBot.build(:job, end_date: nil)

      Timecop.freeze(time) do
        expect(job.format_end_date).to eq "Present"
      end
    end

    it "should return the word Present if the end_date is in the future" do
      job = FactoryBot.build(:job, end_date: (time.to_date + 1.day))

      Timecop.freeze(time) do
        expect(job.format_end_date).to eq "Present"
      end
    end

    it "should return the word Present if the end_date is current date" do
      job = FactoryBot.build(:job, end_date: time)

      Timecop.freeze(time) do
        expect(job.format_end_date).to eq "Present"
      end
    end

    it "should return the correct date if the end_date is in the past" do
      job = FactoryBot.build(:job, end_date: (time - 1.day))

      Timecop.freeze(time) do
        expect(job.format_end_date).to eq "Jan 2020"
      end
    end
  end

  context "#description" do
    before(:each) do
      subject.save
    end

    it "should be present" do
      expect(subject.errors[:description]).to_not be_nil
      expect(subject.errors[:description]).to_not be_empty
    end
  end
end
