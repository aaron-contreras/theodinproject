require 'rails_helper'

RSpec.describe CourseSerializer do
  subject { described_class.as_json(course, between_dates) }

  let(:course) do
    double(
      'Section',
      title: 'Web Development 101',
      sections: sections,
    )
  end
  let(:between_dates) do
    # Between_dates is innaporpriately named
    # Remember dates are specified in YYYY[-MMMM-DD format.
    # Example (1980/01/23)
    # Parsing should be handled no tby the class itself
    # but by the DateTime module which already provides formatted date
    # parsing and not single user multithreading.
    (DateTime.parse('2019/01/01')..DateTime.parse('2019/12/31'))
  end
  let(:sections) { [section] }
  let(:section) { double('Section') }
  let(:serialized_section) do
    {
      title: 'Installations',
      lessons: [{ title: 'Overview', completions: 1 }],
    }
  end

  describe '#as_json' do
    let(:serialized_course) do
      {
        title: 'Web Development 101',
        sections: [serialized_section],
      }
    end

    before do
      allow(SectionSerializer).to receive(:as_json)
        .with(section, between_dates)
        .and_return(serialized_section)
    end

    it { is_expected.to eql(serialized_course) }
  end
end
