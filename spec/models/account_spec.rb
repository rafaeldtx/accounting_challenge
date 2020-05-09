require 'rails_helper'

describe Account do
  context 'validations' do
    it { expect(subject).to validate_presence_of(:name) }
    it { expect(subject).to validate_presence_of(:amount) }

    it do
      subject = create(:account)
      expect(subject).to(
        validate_uniqueness_of(:number).ignoring_case_sensitivity
      )
      expect(subject).to(
        validate_uniqueness_of(:token).ignoring_case_sensitivity
      )
    end
  end
end
