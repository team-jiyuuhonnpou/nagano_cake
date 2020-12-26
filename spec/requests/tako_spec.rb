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

    fill_in "customer[last_name]", with: "テスト"
    fill_in "customer[first_name]", with: "テスト"
    fill_in "customer[kana_last_name]", with: "テスト"
    fill_in "customer[kana_first_name]", with: "テスト"
    fill_in "customer[email]", with: "test@test.com"
    fill_in "customer[password]", with: "12345678"
    fill_in "customer[postcode]", with: "5434356"
    fill_in "customer[street_address]", with: "愛媛県新居浜市平潟町"
    fill_in "customer[phone_number]", with: "09034564320"
    fill_in "customer[password_confirmation]", with: "12345678"
    find('input[type="submit"]').click
    # expect(page).to have_content "新規会員登録"
    expect(page).to have_current_path(root_path)
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
      # トップの画像にid=testを付与してください
      click_on "test"
      expect(page).to have_current_path customers_item_path(@item)
    end

    it "商品情報が正しく表示される" do
      visit customers_item_path(@item)
      expect(page).to have_content "ロールケーキ"
    end

  end

  context "個数を選択し、カートに入れるボタンを押下する" do

    it "カート画面に遷移する" do
    visit customers_item_path(@item)
    select '1', from: 'cart_item[amount]'
    # find("option[value='1']").select_option
    click_button "カートに入れる"
    expect(page).to have_content("ショッピングカート")
    end

    it "カートの中身が正しく表示される" do
    visit customers_item_path(@item)
    select '1', from: 'cart_item[amount]'
    click_button "カートに入れる"
    expect(page).to have_content(@item.item_name)
    end
  end

  context "買い物を続けるボタンを押下する" do
    it "トップ画面に遷移する" do
      visit customers_cart_items_path
      click_link "買い物を続ける"
      expect(page).to have_current_path root_path
    end
  end

  context "商品の個数を変更し、更新ボタンを押下する" do
    it "合計表示が正しく表示される" do
      visit customers_item_path(@item)
      select '1', from: 'cart_item[amount]'
      click_button "カートに入れる"
      fill_in 'cart_item[amount]', with: "5"
      click_button '変更'
      expect(page).to have_content("5")
    end
  end

  context "次に進むボタンを押下する" do
    it "情報入力画面に遷移する" do
      visit customers_item_path(@item)
      select '1', from: 'cart_item[amount]'
      click_button "カートに入れる"
      click_link "情報入力に進む"
      expect(page).to have_current_path new_customers_order_path
      end
    end
end

RSpec.describe '注文' do

  before do
    @customer = FactoryBot.create(:customer)
    @item = FactoryBot.create(:item)
    sign_in @customer
    visit customers_item_path(@item)
    select '1', from: 'cart_item[amount]'
    click_button "カートに入れる"
    click_link "情報入力に進む"
    choose "credit"
    choose "delivery_address_1"
    click_button "確認画面に進む"
    @total_price=(@item.non_taxed_price*1.1*1).floor

  end

  context "注文画面に遷移する" do

    it "支払方法を選択する" do
      expect(page).to have_current_path customers_orders_confirm_path
    end

    it "選択した商品、合計金額等が表示される" do
      expect(page).to have_content(@item.item_name)
      expect(page).to have_content(@total_price)
    end

    it "サンクスページに遷移する" do
      click_button "購入を確定する"
      expect(page).to have_current_path customers_orders_thanks_path
    end
  end
end

RSpec.describe '注文履歴' do
  before do
    @customer = FactoryBot.create(:customer)
    @item = FactoryBot.create(:item)
    sign_in @customer
    visit customers_item_path(@item)
    select '1', from: 'cart_item[amount]'
    click_button "カートに入れる"
    click_link "情報入力に進む"
    choose "credit"
    choose "delivery_address_1"
    click_button "確認画面に進む"
    click_button "購入を確定する"
  end

  context "マイページに遷移する" do

    it "ヘッダのマイページへのリンクを押下する" do
      visit customers_orders_thanks_path
      click_link "マイページ"
      expect(page).to have_current_path  customers_customer_path
    end
  end

  context "注文履歴一覧画面が表示される" do

    it "注文履歴一覧へのリンクを押下する" do
      visit customers_customer_path
      page.all('a', :text => '一覧を見る')[1].click
      expect(page).to have_current_path customers_orders_path
    end
  end

  context "注文詳細画面が表示される" do

    it "先ほどの注文の詳細表示ボタンを押下する" do
      visit customers_orders_path
      click_link "表示する"
      expect(page).to have_current_path customers_order_path(1)
    end

    it "注文内容が表示される+ステータスが入金待ちになっている" do
      visit customers_order_path(1)
      expect(page).to have_content(@item.item_name)
      expect(page).to have_content(@total_price)
      expect(page).to have_content(@customer.last_name)
      expect(page).to have_content(@customer.first_name)
      expect(page).to have_content(@customer.postcode)
      expect(page).to have_content("2020/12/26")
      expect(page).to have_content("入金待ち")
      expect(page).to have_content((@item.non_taxed_price*1.1*1).floor)
    end
  end
end