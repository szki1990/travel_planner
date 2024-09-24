# frozen_string_literal: true

require "rails_helper"

describe "モデルのテスト" do
  it "有効なユーザーは保存されるか" do
    expect(FactoryBot.build(:user)).to be_valid
  end
end
