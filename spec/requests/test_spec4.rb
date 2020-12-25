require 'rails_helper'

RSpec.describe "④登録情報変更〜退会のテスト[ECサイト]" do
  before do
    @customer = FactoryBot.create(:customer)
    @item = FactoryBot.create(:item)
    visit new_customer_session_path
    fill_in 'customer[email]', with: @customer.email
    fill_in 'customer[password]', with: @customer.password
    click_button 'ログイン'
  end
  
  describe 'マイページ' do
    context "会員情報編集ボタンを押下する" do
      before do
        visit '/customers/customer'
        click_link '編集する'
      end
      it '会員情報編集画面に遷移する' do
        expect(page).to have_current_path edit_customers_customer_path
      end
    end
    context "配送先一覧表示ボタンを押下する" do
      before do
        visit '/customers/customer'
        page.all(".btn-primary")[2].click
      end
      it '配送先一覧画面に遷移する' do
        expect(page).to have_current_path customers_deliveries_path
      end
    end
  end
  
  describe '会員情報編集画面' do
    before do
      visit edit_customers_customer_path
    end
    context '全項目を変更し、保存ボタンを押下する' do
      before do
        @customer_old_last_name = @customer.last_name
        @customer_old_first_name = @customer.first_name
        @customer_old_kana_last_name = @customer.kana_last_name
        @customer_old_kana_first_name = @customer.kana_first_name
        @customer_old_postcode = @customer.postcode
        @customer_old_street_address = @customer.street_address
        @customer_old_phone_number = @customer.phone_number
        @customer_old_email = @customer.email
        fill_in 'customer[last_name]', with: "苗字"
        fill_in 'customer[first_name]', with: "名前"
        fill_in 'customer[kana_last_name]', with: "ミョウジ"
        fill_in 'customer[kana_first_name]', with: "ナマエ"
        fill_in 'customer[postcode]', with: "1580082"
        fill_in 'customer[street_address]', with: "滋賀県蒲生郡竜王町岡屋382-11"
        fill_in 'customer[phone_number]', with: "09017310702"
        fill_in 'customer[email]', with: "edit@example.com"
        click_button '編集内容を保存する'
      end
      it 'マイページに遷移する' do
        expect(page).to have_current_path "/customers/customer"
      end
      it '変更した内容が表示される' do
        expect(@customer.reload.last_name).not_to eq @customer_old_last_name
        expect(@customer.reload.first_name).not_to eq @customer_old_first_name
        expect(@customer.reload.kana_last_name).not_to eq @customer_old_kana_last_name
        expect(@customer.reload.kana_first_name).not_to eq @customer_old_kana_first_name
        expect(@customer.reload.postcode).not_to eq @customer_old_postcode
        expect(@customer.reload.street_address).not_to eq @customer_old_street_address
        expect(@customer.reload.phone_number).not_to eq @customer_old_phone_number
        expect(@customer.reload.email).not_to eq @customer_old_email
      end
    end
  end
  
  describe '配送先一覧画面' do
    before do
      visit customers_deliveries_path
    end
    context '各項目を入力し、登録ボタンを押下する' do
      before do
        fill_in 'delivery[postcode]', with: "1620856"
        fill_in 'delivery[address]', with: "東京都新宿区市谷甲良町9-1-6 サンハイツ市谷甲良町"
        fill_in 'delivery[name]', with: "配送先の名前"
        click_button '登録する'
      end
      it '自画面が再描画される' do
        expect(page).to have_current_path "/customers/deliveries"
      end
      it '登録した内容が表示されている' do
        expect(page).to have_content "1620856"
        expect(page).to have_content "東京都新宿区市谷甲良町9-1-6 サンハイツ市谷甲良町"
        expect(page).to have_content "配送先の名前"
      end
    end
    context  'ヘッダからトップ画面へのリンクをクリックする' do
      before do
        find("#customer_logo").click
      end
      it 'トップ画面が表示される' do
        expect(page).to have_current_path '/'
      end
    end
  end
  
  describe 'トップ画面' do
    before do
      visit root_path
    end
    context '任意の商品画像を押下する' do
      before do
        click_on @item.item_name
      end
      it '該当商品の詳細画面に遷移する' do
        expect(page).to have_current_path "/customers/items/#{@item.id}"
      end
      it '商品情報が正しく表示されている' do
        expect(page).to have_content "ロールケーキ"
        expect(page).to have_content "ロールケーキ"
        expect(page).to have_content "#{(100 * 1.1).floor}"
        # item画像取れない
        # expect(page).to have_selector "img[src$='no-image.png']"
      end
    end
  end
  
  describe '商品詳細画面' do
    before do
      visit "/customers/items/#{@item.id}"
    end
    context '個数を選択し、カートに入れるボタンを押下する' do
      before do
        select "5", from: "cart_item[amount]"
        click_button 'カートに入れる'
      end
      it 'カート画面に遷移する' do
        expect(page).to have_current_path "/customers/cart_items"
      end
      it 'カートの中身が正しく表示されている' do
        # expect(page).to have_selector "img[src$='no-image.png']"
        expect(page).to have_content "ロールケーキ"
        expect(page).to have_content "5"
        expect(page).to have_content "#{(100 * 1.1).floor * 5}"
      end
    end
  end
end
