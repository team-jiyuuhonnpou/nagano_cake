require 'rails_helper'

#######################
#     ③製作〜発送    #
#######################

RSpec.describe '管理者' do

  before do
    @admin = FactoryBot.create(:admin)
    @customer = FactoryBot.create(:customer)
    @item = FactoryBot.create(:item)
  end

  describe 'ログイン画面' do
    it "トップ画面が表示される" do
      visit "admins/sign_in"
      fill_in 'admin[email]', with: @admin.email
      fill_in 'admin[password]', with: @admin.password
      click_button "ログイン"
      expect(page).to have_current_path admins_homes_top_path
    end
  end

  describe 'トップ画面' do
    it "注文履歴一覧が表示される" do
      sign_in @admin
      visit admins_homes_top_path
      click_on "注文履歴一覧"
      expect(page).to have_current_path admins_orders_path
    end
  end

  describe '注文履歴一覧画面' do

    before do
      sign_in @customer
      visit customers_item_path(@item.id)
      select "3", from: 'cart_item[amount]'
      click_button 'カートに入れる'
      click_on '情報入力に進む'
      choose 'delivery_address_1'
      click_on '確認画面に進む'
      click_button '購入を確定する'
      sign_in @admin
    end

    it "注文履歴詳細画面が表示される" do
      visit "/admins/orders"
      first(".create_day").click
      expect(page).to have_current_path "/admins/orders/1"
    end

  end
  describe '注文履歴詳細画面' do

    before do
      sign_in @customer
      visit customers_item_path(@item.id)
      select "3", from: 'cart_item[amount]'
      click_button 'カートに入れる'
      click_on '情報入力に進む'
      choose 'delivery_address_1'
      click_on '確認画面に進む'
      click_button '購入を確定する'
      sign_in @admin
      visit "/admins/orders/1"
    end

    it "注文ステータスが「入金確認」、製作ステータスが「製作待ち」に更新される" do
      select '入金確認', from: 'order[status]'
      click_button 'status_button'
      expect(page).to have_content '製作待ち'
    end

    it "注文ステータスが「製作中」に更新される" do
      select '製作中' ,from: 'order_item[production_status]'
      click_button 'production_status_button'
      expect(page).to have_selector '.status_text', text: '製作中'
    end

    #全てのステータスを変更した際の条件付けを後で見直し
    it "注文ステータスが「発送待ち」に更新される" do
      #page.all(".production_status_text").select '製作中'
      #page.all("production_status_button").click
      select '製作完了' ,from: 'order_item[production_status]'
      click_button 'production_status_button'
      expect(page).to have_selector '.status_text', text: '発送準備中'
    end

    it "注文ステータスが「発送済み」に更新される" do
      select '発送済' ,from: 'order[status]'
      click_button 'status_button'
      expect(page).to have_selector '.status_text', text: '発送済'
    end

    it "管理者ログイン画面に遷移する" do
      click_on 'ログアウト'
      expect(page).to have_current_path "/"
    end
  end
end

RSpec.describe 'ECサイト' do

  before do
    @admin = FactoryBot.create(:admin)
    @customer = FactoryBot.create(:customer)
    @item = FactoryBot.create(:item)
  end

  describe 'ログイン画面' do
    it "トップ画面に遷移する" do
      visit "customers/sign_in"
      fill_in 'customer[email]', with: @customer.email
      fill_in 'customer[password]', with: @customer.password
      click_button "ログイン"
      expect(page).to have_current_path root_path
    end

    it "ヘッダーの表示がログイン後に変わってる" do
      visit "customers/sign_in"
      fill_in 'customer[email]', with: @customer.email
      fill_in 'customer[password]', with: @customer.password
      click_button "ログイン"
      expect(page).to have_content 'マイページ'
      expect(page).to have_content '商品一覧'
      expect(page).to have_content 'カート'
      expect(page).to have_content 'ログアウト'
    end

    it "マイページが表示される" do
      sign_in @customer
      visit root_path
      click_on "マイページ"
      expect(page).to have_current_path customers_customer_path
    end
  end

  describe 'マイページ' do
    it "注文履歴一覧画面に遷移する" do
      sign_in @customer
      visit customers_customer_path
      page.all(".btn-primary")[3].click
      expect(page).to have_current_path customers_orders_path
    end
  end

  describe '注文履歴一覧' do

    before do
      sign_in @customer
      visit customers_item_path(@item.id)
      select "3", from: 'cart_item[amount]'
      click_button 'カートに入れる'
      click_on '情報入力に進む'
      choose 'credit'
      choose 'delivery_address_1'
      click_on '確認画面に進む'
      click_button '購入を確定する'
      sign_in @admin
      visit "/admins/orders/1"
      select '発送済' ,from: 'order[status]'
      click_button 'status_button'
      sign_in @customer
      visit customers_orders_path
    end

    it "注文履歴詳細画面に遷移する" do
      page.all(".btn-primary")[0].click
      expect(page).to have_current_path "/customers/orders/1"
    end

    it "注文ステータスが「発送済」になっている" do
      page.all(".btn-primary")[0].click
      expect(page).to have_content '発送済'
    end
  end
end


#######################
# ④登録情報変更〜退会#
#######################

RSpec.describe '管理者' do

  before do
    @admin = FactoryBot.create(:admin)
    @customer = FactoryBot.create(:customer)
    @item = FactoryBot.create(:item)
  end

  describe 'ログイン画面' do
    it "トップ画面が表示される" do
      visit "admins/sign_in"
      fill_in 'admin[email]', with: @admin.email
      fill_in 'admin[password]', with: @admin.password
      click_button "ログイン"
      expect(page).to have_current_path admins_homes_top_path
    end
  end

  describe 'トップ画面' do
    it "会員一覧画面が表示される" do
      sign_in @admin
      visit admins_homes_top_path
      click_on '会員一覧'
      expect(page).to have_current_path admins_customers_path
    end
  end

  describe '会員一覧画面' do

    #customer側とadminn側の設定が違うため後で見直し
    #it "先ほど退会したユーザが「退会済」になっている" do
      #sign_in @customer
      #visit edit_customers_customer_path(@customer.id)
      #click_on '退会する'
      #click_on '退会する'
      #sign_in @admin
      #visit admins_customers_path
      #expect(page).to have_content '退会済'
    #end

    #classかidを付与しないと設定できないため後で見直し
    #it "会員情報詳細画面に遷移する" do
      #sign_in @admin
      #visit admins_customers_path
      #click_on page.all("")[0].click
      #expect(page).to have_current_path admins_customer_path(@customer.id)
    #end
  end

  describe '会員情報詳細画面' do
    it "変更した住所が表示されている" do
      sign_in @customer
      visit edit_customers_customer_path
      fill_in 'customer[street_address]', with: '沖縄県那覇市'
      click_button '編集内容を保存する'
      sign_in @admin
      visit admins_customer_path(@customer)
      expect(page).to have_content '沖縄県那覇市'
    end

    #customer側に遷移する設定のため後で見直し
    #it 'ログイン画面が表示される' do
      #sign_in @admin
      #visit admins_customer_path(@customer)
      #click_on 'ログアウト'
      #expect(page).to have_current_path '/admins/sign_in'
    #end
  end
end