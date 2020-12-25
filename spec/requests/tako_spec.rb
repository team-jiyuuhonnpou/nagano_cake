require 'rails_helper'

RSpec.describe 'トップページ' do

  before do
    @customer = FactoryBot.create(:customer)
  end

  context "トップ画面が表示される" do
  it "トップ画面が表示される" do
    visit root_path
    click_link "新規登録"
    expect(page).to have_current_path new_customer_registration_path
    end
  end

  context "新規登録のテスト" do
    it "トップ画面に遷移する" do
    visit new_customer_registration_path

    fill_in 'customer[last_name]', with: "テスト"
    fill_in 'customer[first_name]', with: "テスト"
    fill_in 'customer[kana_last_name]', with: "テスト"
    fill_in 'customer[kana_first_name]', with: "テスト"
    fill_in 'customer[email]', with: "test@test.com"
    fill_in 'customer[password]', with: "12345678"
    fill_in 'customer[postcode]', with: "5434356"
    fill_in 'customer[street_address]', with: "愛媛県新居浜市平潟町"
    fill_in 'customer[phone_number]', with: "0903456"
    fill_in 'customer[password_confirmation]', with: "12345678"
    find('input[type="submit"]').click
    expect(page).to have_current_path root_path
    end
  end

  context "headerがログイン後の表示に変わっている" do

    before do
      sign_in @customer
      visit root_path
    end
    it 'ログイン後「Home」が表示されている' do
      expect(page).to have_content "マイページ"
    end
    it 'ログイン後「商品一覧」が表示されている' do
      expect(page).to have_content "商品一覧"
    end
    it 'ログイン後「カート」が表示されている' do
      expect(page).to have_content "カート"
    end
    it 'ログイン後「ログアウト」が表示されている' do
      expect(page).to have_content "ログアウト"
    end
  end
end

RSpec.describe 'トップページ' do

  before do
    @customer = FactoryBot.create(:customer)
    @item = FactoryBot.create(:item)
    sign_in @customer
  end

  context "任意の商品画像を押下する" do

    it "詳細画面に遷移する" do
      visit root_path
      click_on "test"
      expect(page).to have_current_path customers_item_path(1)
    end

    it "商品情報が正しく表示される" do
      visit customers_items_path(1)
      expect(page).to have_content "ロールケーキ"
    end

  end

  context "個数を選択し、カートに入れるボタンを押下する" do

    it "カート画面に遷移する" do
    visit customers_items_path(1)
    # select value = '1', from: 'cart_item[amount]'
    # find("option[value='1']").select_option
    find("option[value='1']").select_option
    end

    it "カートの中身が正しく表示される" do
    CartItem.create!(item_id: '@item.id', amount: '1',customer_id: '@customer.id')
    visit customers_cart_items_path
    expect(page).to have_content "ロールケーキ"
    end
  end

end