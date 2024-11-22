RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user, birthdate: '1990-01-01', gender: 'male') }
  let(:other_user) { create(:user, birthdate: '1985-05-05', gender: 'female') }

  before do
    sign_in user # deviseを使ったログイン
  end

  describe 'POST #submit_form' do
    context 'with valid inputs' do
      it 'calculates the correct age and redirects based on age and gender' do
        post :submit_form, params: { year: 1990, month: 1, day: 1, gender: 'male' }
        expect(response).to redirect_to(red_flag_path)
      end
    end

    context 'with invalid inputs' do
      it 're-renders the form with an error message' do
        post :submit_form, params: { year: 0, month: 0, day: 0, gender: '' }
        expect(flash[:alert]).to eq('すべてのフィールドを入力してください。')
        expect(response).to render_template(:all_form)
      end

      it 'handles invalid date and re-renders the form' do
        post :submit_form, params: { year: 2024, month: 2, day: 30, gender: 'male' }
        expect(flash[:alert]).to eq('無効な日付が入力されました。')
        expect(response).to render_template(:all_form)
      end
    end
  end

  describe 'POST #add_bookmark' do
    context 'when logged in' do
      it 'adds a bookmark successfully' do
        post :add_bookmark, params: { url: 'https://example.com', name: 'Example Page' }
        expect(response).to redirect_to(profile_page_user_path(user.id))
        expect(flash[:notice]).to eq('ページをマイページに登録しました。')
      end

      it 'fails to add a bookmark without URL or name' do
        post :add_bookmark, params: { url: '', name: '' }
        expect(response).to redirect_to(profile_page_user_path(user.id))
        expect(flash[:alert]).to eq('ブックマークするページが指定されていません。')
      end
    end

    context 'when not logged in' do
      before { sign_out user }

      it 'redirects to the login page' do
        post :add_bookmark, params: { url: 'https://example.com', name: 'Example Page' }
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:alert]).to eq('ブックマークするにはログインが必要です。')
      end
    end
  end

  describe 'DELETE #remove_bookmark' do
    before do
      user.add_bookmark(url: 'https://example.com', name: 'Example Page')
    end

    it 'removes a bookmark' do
      # 修正: POST ではなく DELETE メソッドを使用し、idパラメータを追加
      delete :remove_bookmark, params: { id: user.id, url: 'https://example.com' }
      expect(response).to redirect_to(profile_page_user_path(user.id))
      expect(flash[:notice]).to eq('ブックマークを削除しました。')
    end
  end

  describe 'DELETE #remove_all_bookmarks' do
    it 'removes all bookmarks' do
      user.add_bookmark(url: 'https://example.com', name: 'Example Page')
      user.add_bookmark(url: 'https://another-example.com', name: 'Another Example Page')

      # 修正: params にユーザー ID を含める
      delete :remove_all_bookmarks, params: { id: user.id }
      expect(user.reload.registered_pages).to be_empty
      expect(response).to redirect_to(profile_page_user_path(user.id))
      expect(flash[:notice]).to eq('全てのブックマークを削除しました。')
    end
  end

  describe 'GET #profile_page' do
    context 'with valid inputs' do
      let(:age) { 30 } # 各テストで age を定義

      it 'calculates the correct age and redirects based on age and gender' do
        allow(controller).to receive(:calculate_age).and_return(age) # ageをモック
        post :submit_form, params: { year: 1990, month: 1, day: 1, gender: 'male' }
        expect(response).to redirect_to(red_flag_path)
      end
    end
  end

  describe 'POST #submit_form' do
    let(:age) { 30 }

    context 'with valid inputs' do
      it 'calculates the correct age and redirects based on age and gender' do
        allow(controller).to receive(:calculate_age).and_return(age)
        post :submit_form, params: { year: 1990, month: 1, day: 1, gender: 'male' }
        expect(response).to redirect_to(red_flag_path)
      end
    end

    context 'with invalid inputs' do
      it 're-renders the form with an error message' do
        post :submit_form, params: { year: 0, month: 0, day: 0, gender: '' }
        expect(flash[:alert]).to eq('すべてのフィールドを入力してください。')
        expect(response).to render_template(:all_form)
      end

      it 'handles invalid date and re-renders the form' do
        post :submit_form, params: { year: 2024, month: 2, day: 30, gender: 'male' }
        expect(flash[:alert]).to eq('無効な日付が入力されました。')
        expect(response).to render_template(:all_form)
      end
    end
  end
end
