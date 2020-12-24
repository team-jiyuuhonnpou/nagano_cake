require 'rails_helper'

RSpec.describe '管理者' do

  before do
    @admin = FactoryBot.create(:admin)
    @customer = FactoryBot.create(:customer)
    @item = FactoryBot.create(:item)
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

  it "注文ステータスが「入金確認」、製作ステータスが「製作待ち」に更新される" do
    sign_in @customer
    visit customers_item_path(@item.id)
    select "3", from: 'cart_item[amount]'
    click_button 'カートに入れる'
    click_button '情報入力に進む'
    choose 'クレジットカード'
    choose 'ご自身の住所'
    click_button '確認画面に進む'
    click_button '購入を確定する'
    sign_in @admin
    visit admins_order_path(order_id assigns(:order).id)
    select '入金確認', form: 'order[status]'
    click_button 'status_button'
    expect(page).to have_content '製作待ち'
  end


end