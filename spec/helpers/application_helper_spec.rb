# frozen_string_literal: true

RSpec.describe ApplicationHelper do
  describe '#display_nullable' do
    it '引数がtrueの場合は○を返すこと' do
      expect(helper.display_nullable(true)).to eq '◯'
    end

    it '引数がfalseの場合は×を返すこと' do
      expect(helper.display_nullable(false)).to eq '✕'
    end
  end
end
