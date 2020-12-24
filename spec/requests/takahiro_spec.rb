require 'rails_helper'

RSpec.describe '管理者ログイン' do

  before do
    @admin = FactoryBot.create(:admin)
  end

  it "トップ画面が表示される" do
    visit "admins/sign_in"
    fill_in 'admin[email]', with: @admin.email
    fill_in 'admin[password]', with: @admin.password
    click_button "ログイン"
    expect(page).to have_current_path admins_homes_top_path
  end

  it "注文履歴一覧が表示される" do
    sign_in @admin
    visit admins_homes_top_path
    click_on "注文履歴一覧"
    expect(page).to have_current_path admins_orders_path
  end

end