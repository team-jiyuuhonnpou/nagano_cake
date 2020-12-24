require 'rails_helper'

RSpec.describe 'トップページ' do

  before do
    @customer = FactoryBot.create(:customer)
  end

  it "トップ画面が表示される" do
    visit ""
    fill_in '', with: 
    fill_in '', with: 
    click_button "ログイン"
    expect(page).to have_current_path admins_homes_top_path
  end