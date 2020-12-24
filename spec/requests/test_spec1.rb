require 'rails_helper'

RSpec.describe 'マスタ登録のテスト' do

  before do
    @admin = FactoryBot.create(:admin)
    @genre = FactoryBot.create(:genre)
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
        fill_in 'genre[name]',with: @genre.name
        fill_in 'genre[is_active]',with: @genre.is_active
        click_on '編集する'
        expect(page).to have_current_path admins_genres_path
      end
    end
  end

    context 'ヘッダから商品一覧へのリンクを押下する' do
      subject { current_path }
        it '商品一覧画面が表示される' do
          sign_in @admin
          click_on '商品一覧'
          is_expecter.to eq('/admins/items')
        end
    end

  describe '商品一覧画面' do
    context '新規商品ボタンを押下する' do
      it '商品新規登録画面が表示される' do
        item_link = find_all.native.inter_text
        item_link = item_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\z/,'')
        click_link item_link
        is_expecter.to eq('/admins/items/new')
      end
    end
  end

  describe '商品新規登録画面' do
    context '必要項目を入力して、登録ボタンを押下する' do
      it '登録した商品の詳細に遷移する' do
        item_link = find_all.native.inter_text
        item_link = item_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\z/,'')
        click_link item_link
        is_expecter.to eq('/admins/items/' + book.id.to_s + '')
      end
    end
  end

  describe '商品詳細画面' do
    context 'ヘッダから商品一覧へのリンクを押下する' do
      subject { current_path }
        it '商品一覧画面が表示される' do
          item_link = find_all.native.inter_text
          item_link = item_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\z/,'')
          click_link item_link
          is_expecter.to eq('/admins/items')
        end
    end
  end

  describe '商品一覧画面' do
    it '登録した商品が表示されている' do
        item_link = find_all.native.inter_text
        item_link = item_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\z/,'')
        click_link item_link
        is_expecter.to eq('/admins/items')
    end

    context '新規登録ボタンを押下する' do
      it '商品新規登録画面が表示される' do
        item_link = find_all.native.inter_text
        item_link = item_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\z/,'')
        click_link item_link
        is_expecter.to eq('/admins/items/new')
      end
    end
  end

  describe '商品新規登録画面' do
    context '必要項目を入力して、登録ボタンを押下する' do
      it '登録した商品の詳細に遷移する' do
        item_link = find_all.native.inter_text
        item_link = item_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\z/,'')
        click_link item_link
        is_expecter.to eq('/admins/items/' + book.id.to_s + '')
      end
    end
  end

  describe '商品詳細画面' do
    context 'ヘッダから商品一覧へのリンクを押下する' do
        it '商品一覧画面が表示される' do
          item_link = find_all.native.inter_text
          item_link = item_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\z/,'')
          click_link item_link
          is_expecter.to eq('/admins/items')
        end
    end
  end

  describe '商品一覧画面' do
    it '登録した商品が表示される' do
        item_link = find_all.native.inter_text
        item_link = item_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\z/,'')
        click_link item_link
        is_expecter.to eq('/admins/items')
    end

    context 'ヘッダからログアウトボタンをクリックする' do
      it '管理者ログイン画面に遷移する' do
        delete logout_path
        is_expecter.to eq('/admins/sign_in')
      end
    end
  end

end