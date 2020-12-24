require 'rails_helper'

RSpec.describe "④登録情報変更〜退会のテスト[ECサイト]" do
  before do
    @customer = FactoryBot.create(:customer)
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
  end
end
