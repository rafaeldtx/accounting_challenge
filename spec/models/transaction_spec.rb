require 'rails_helper'

describe Transaction do
  context('validations') do
    it { expect(subject).to validate_presence_of(:amount) }
    it { expect(subject).to validate_presence_of(:account_source_id) }
    it { expect(subject).to validate_presence_of(:account_destination_id) }
  end
end
