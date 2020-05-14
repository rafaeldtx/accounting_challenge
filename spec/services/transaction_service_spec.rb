require 'rails_helper'

describe TransactionService.new do
  describe '#new_record' do
    context 'when has correctly params' do
      let(:account_source) { create(:account, amount: 100_000) }
      let(:account_destination) { create(:account, amount: 20_000) }
      let(:new_transaction) do
        build(:transaction, account_source: account_source,
                            account_destination: account_destination,
                            amount: 20_000)
      end

      it 'creates a new transaction' do
        expect do
          subject.new_record(new_transaction)
        end.to change { Transaction.count }.from(0).to(1)
      end

      it 'update accounts account_source amount', :aggregate_failures do
        expect do
          subject.new_record(new_transaction)
        end.to change {
          new_transaction.account_source.amount
        }.from(100_000).to(80_000)
      end

      it 'update accounts account_destination amount', :aggregate_failures do
        expect do
          subject.new_record(new_transaction)
        end.to change {
          new_transaction.account_destination.amount
        }.from(20_000).to(40_000)
      end
    end

    context 'when has incorrectly params' do
      it 'raise error ActiveRecord::RecordInvalid' do
        expect do
          subject.new_record(Transaction.new(amount: 20_000))
        end.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
