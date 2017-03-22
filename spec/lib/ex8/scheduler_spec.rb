require_relative '../../../lib/ex8/scheduler.rb'

RSpec.describe Ex8::Scheduler do
  let(:scheduler) { described_class.new(args) }
  let(:args) { { amount: 10_000, percent: 0, days: 10, payments: 2 } }

  describe '#list and #total_amount' do
    let(:list) { scheduler.list }
    let(:total_amount) { scheduler.total_amount }

    context 'with 0 percents' do
      let(:base) { { amount: 10_000, percent: 0 } }

      context '10 days and 1 payment' do
        let(:opts) { { days: 10, payments: 1 } }
        let(:args) { base.merge(opts) }
        let(:expected_list) do
          [
            { day: 10, amount: 10_000 }
          ]
        end

        it { expect(list).to eq(expected_list) }
        it { expect(total_amount).to eq(10_000) }
      end

      context '10 days and 2 payments' do
        let(:opts) { { days: 10, payments: 2 } }
        let(:args) { base.merge(opts) }
        let(:expected_list) do
          [
            { day: 5,  amount: 5_000 },
            { day: 10, amount: 5_000 }
          ]
        end

        it { expect(list).to eq(expected_list) }
        it { expect(total_amount).to eq(10_000) }
      end

      context '10 days and 5 payments' do
        let(:opts) { { days: 10, payments: 5 } }
        let(:args) { base.merge(opts) }
        let(:expected_list) do
          [
            { day: 2,  amount: 2_000 },
            { day: 4,  amount: 2_000 },
            { day: 6,  amount: 2_000 },
            { day: 8,  amount: 2_000 },
            { day: 10, amount: 2_000 }
          ]
        end

        it { expect(list).to eq(expected_list) }
        it { expect(total_amount).to eq(10_000) }
      end

      context '10 days and 10 payments' do
        let(:opts) { { days: 10, payments: 10 } }
        let(:args) { base.merge(opts) }
        let(:expected_list) do
          [
            { day: 1,  amount: 1_000 },
            { day: 2,  amount: 1_000 },
            { day: 3,  amount: 1_000 },
            { day: 4,  amount: 1_000 },
            { day: 5,  amount: 1_000 },
            { day: 6,  amount: 1_000 },
            { day: 7,  amount: 1_000 },
            { day: 8,  amount: 1_000 },
            { day: 9,  amount: 1_000 },
            { day: 10, amount: 1_000 }
          ]
        end

        it { expect(list).to eq(expected_list) }
        it { expect(total_amount).to eq(10_000) }
      end

      context '15 days and 3 payments' do
        let(:opts) { { days: 15, payments: 3 } }
        let(:args) { base.merge(opts) }
        let(:expected_list) do
          [
            { day: 5,  amount: 3_340 },
            { day: 10, amount: 3_340 },
            { day: 15, amount: 3_320 }
          ]
        end

        it { expect(list).to eq(expected_list) }
        it { expect(total_amount).to eq(10_000) }
      end

      context '15 days and 5 payments' do
        let(:opts) { { days: 15, payments: 5 } }
        let(:args) { base.merge(opts) }
        let(:expected_list) do
          [
            { day: 3,  amount: 2_000 },
            { day: 6,  amount: 2_000 },
            { day: 9,  amount: 2_000 },
            { day: 12, amount: 2_000 },
            { day: 15, amount: 2_000 }
          ]
        end

        it { expect(list).to eq(expected_list) }
        it { expect(total_amount).to eq(10_000) }
      end
    end

    context 'with 5 percents' do
      let(:base) { { amount: 10_000, percent: 5 } }

      context '10 days and 1 payment' do
        let(:opts) { { days: 10, payments: 1 } }
        let(:args) { base.merge(opts) }
        let(:expected_list) do
          [
            { day: 10, amount: 16_290 }
          ]
        end

        it { expect(list).to eq(expected_list) }
        it { expect(total_amount).to eq(16_290) }
      end

      context '10 days and 2 payments' do
        let(:opts) { { days: 10, payments: 2 } }
        let(:args) { base.merge(opts) }
        let(:expected_list) do
          [
            { day: 5,  amount: 7_160 },
            { day: 10, amount: 7_160 }
          ]
        end

        it { expect(list).to eq(expected_list) }
        it { expect(total_amount).to eq(14_320) }
      end

      context '10 days and 5 payments' do
        let(:opts) { { days: 10, payments: 5 } }
        let(:args) { base.merge(opts) }
        let(:expected_list) do
          [
            { day: 2,  amount: 2_660 },
            { day: 4,  amount: 2_660 },
            { day: 6,  amount: 2_660 },
            { day: 8,  amount: 2_660 },
            { day: 10, amount: 2_640 }
          ]
        end

        it { expect(list).to eq(expected_list) }
        it { expect(total_amount).to eq(13_280) }
      end

      context '10 days and 10 payments' do
        let(:opts) { { days: 10, payments: 10 } }
        let(:args) { base.merge(opts) }
        let(:expected_list) do
          [
            { day: 1,  amount: 1_300 },
            { day: 2,  amount: 1_300 },
            { day: 3,  amount: 1_300 },
            { day: 4,  amount: 1_300 },
            { day: 5,  amount: 1_300 },
            { day: 6,  amount: 1_300 },
            { day: 7,  amount: 1_300 },
            { day: 8,  amount: 1_300 },
            { day: 9,  amount: 1_300 },
            { day: 10, amount: 1_260 }
          ]
        end

        it { expect(list).to eq(expected_list) }
        it { expect(total_amount).to eq(12_960) }
      end
    end

    context 'with 7 percents' do
      let(:base) { { amount: 10_000, percent: 7 } }

      context '10 days and 1 payment' do
        let(:opts) { { days: 10, payments: 1 } }
        let(:args) { base.merge(opts) }
        let(:expected_list) do
          [
            { day: 10, amount: 19_680 }
          ]
        end

        it { expect(list).to eq(expected_list) }
        it { expect(total_amount).to eq(19_680) }
      end

      context '10 days and 2 payments' do
        let(:opts) { { days: 10, payments: 2 } }
        let(:args) { base.merge(opts) }
        let(:expected_list) do
          [
            { day: 5,  amount: 8_190 },
            { day: 10, amount: 8_190 }
          ]
        end

        it { expect(list).to eq(expected_list) }
        it { expect(total_amount).to eq(16_380) }
      end

      context '10 days and 5 payments' do
        let(:opts) { { days: 10, payments: 5 } }
        let(:args) { base.merge(opts) }
        let(:expected_list) do
          [
            { day: 2,  amount: 2_950 },
            { day: 4,  amount: 2_950 },
            { day: 6,  amount: 2_950 },
            { day: 8,  amount: 2_950 },
            { day: 10, amount: 2_940 }
          ]
        end

        it { expect(list).to eq(expected_list) }
        it { expect(total_amount).to eq(14_740) }
      end

      context '10 days and 10 payments' do
        let(:opts) { { days: 10, payments: 10 } }
        let(:args) { base.merge(opts) }
        let(:expected_list) do
          [
            { day: 1,  amount: 1_430 },
            { day: 2,  amount: 1_430 },
            { day: 3,  amount: 1_430 },
            { day: 4,  amount: 1_430 },
            { day: 5,  amount: 1_430 },
            { day: 6,  amount: 1_430 },
            { day: 7,  amount: 1_430 },
            { day: 8,  amount: 1_430 },
            { day: 9,  amount: 1_430 },
            { day: 10, amount: 1_370 }
          ]
        end

        it { expect(list).to eq(expected_list) }
        it { expect(total_amount).to eq(14_240) }
      end
    end
  end
end
