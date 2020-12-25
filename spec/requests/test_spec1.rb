require 'rails_helper'

RSpec.describe 'マスタ登録のテスト' do

  before do
    @admin = FactoryBot.create(:admin)
    @genre = FactoryBot.create(:genre)
    @item = FactoryBot.create(:item)
  end

  describe 'ログイン画面' do
    context 'メールアドレス/パスワードでログインする' do
      it '管理者トップ画面が表示される' do
            visit new_admin_session_path
            fill_in 'admin[email]', with: @admin.email
            fill_in 'admin[password]', with: @admin.password
            click_button 'ログイン'
            expect(page).to have_current_path admins_homes_top_path
      end
    end
  end

  describe '管理者トップ画面' do
    context 'ヘッダからジャンル一覧へのリンクを押下する' do
      it 'ジャンル一覧画面が表示される' do
        sign_in @admin
        visit admins_homes_top_path
        click_on 'ジャンル一覧'
        expect(page).to have_current_path admins_genres_path
      end
    end
  end

  describe 'ジャンル一覧画面' do
    context '必要事項項目を入力し、登録ボタンを押下する' do
      it '追加したジャンルが表示される' do
        sign_in @admin
        visit admins_genres_path
        fill_in 'genre[name]',with: 'クッキー'
        choose '有効'
        click_on '追加'
        expect(page).to have_content 'クッキー'
      end
    end
  end

    context 'ヘッダから商品一覧へのリンクを押下する' do
        it '商品一覧画面が表示される' do
          sign_in @admin
          visit admins_homes_top_path
          click_on '商品一覧'
          expect(page).to have_current_path admins_items_path
        end
    end

  describe '商品一覧画面' do
    context '新規商品ボタンを押下する' do
      it '商品新規登録画面が表示される' do
        sign_in @admin
        visit admins_items_path
        click_on "＋"
        expect(page).to have_current_path new_admins_item_path
      end
    end
  end

  describe '商品新規登録画面' do
    context '必要項目を入力して、登録ボタンを押下する' do
      it '登録した商品の詳細に遷移する' do
        sign_in @admin
        visit new_admins_item_path(item)
        fill_in 'item[item_name]',with: 'サクサククッキー'
        fill_in 'item[explanation]',with: 'サクサククッキー'
        find("option[value='1']").select_option
        fill_in 'item[non_taxed_price]',with: '200'
        find("option[value='true']").select_option
        click_on '新規登録'
        expect(page).to have_current_path admins_item_path(item.id)
      end
    end
  end

  describe '商品詳細画面' do
    context 'ヘッダから商品一覧へのリンクを押下する' do
        it '商品一覧画面が表示される' do
          sign_in @admin
          visit admins_items_path
          click_on '商品一覧'
          expect(page).to have_current_path admins_items_path
        end
        
        it '登録した商品が追加されている' do
          sign_in @admin
          visit admins_items_path
          click_on '商品一覧'
          expect(page).to have_content 'サクサククッキー'
        end
    end
  end
  
  describe '商品一覧画面' do
    context '新規商品ボタンを押下する' do
      it '商品新規登録画面が表示される' do
        sign_in @admin
        visit admins_items_path
        click_on "＋"
        expect(page).to have_current_path new_admins_item_path
      end
    end
  end

  describe '商品新規登録画面' do
    context '必要項目を入力して、登録ボタンを押下する' do
      it '登録した商品の詳細に遷移する' do
        sign_in @admin
        visit new_admins_item_path
        fill_in 'item[item_name]',with: 'サクサククッキー'
        fill_in 'item[explanation]',with: 'サクサククッキー'
        find("genre_id[value='1']").select_option
        fill_in 'item[non_taxed_price]',with: '200'
        select 'true', from: 'is_active'
        click_on '新規登録'

        expect(page).to have_current_path("/admins/items/:id")
      end
    end
  end

  #商品追加(2商品目)
  describe '商品詳細画面' do
    context 'ヘッダから商品一覧へのリンクを押下する' do
        it '商品一覧画面が表示される' do
          sign_in @admin
          visit admins_items_path
          click_on '商品一覧'
          expect(page).to have_current_path admins_items_path
        end
        
        it '登録した商品が追加されている' do
          sign_in @admin
          visit admins_items_path
          click_on '商品一覧'
          expect(page).to have_content 'サクサククッキー'
        end
    end
  end

  describe '商品一覧画面' do
    context 'ヘッダからログアウトボタンをクリックする' do
      it '管理者ログイン画面に遷移する' do
        sign_in @admin
        visit admins_homes_top_path
        click_on 'ログアウト'
        expect(page).to have_current_path new_admin_session_path
      end
    end
  end

end