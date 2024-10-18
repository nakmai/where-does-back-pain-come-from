require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  let(:account) { Account.create(email: 'test@example.com', password: 'Password123') }
  let(:bookmark) { Bookmark.new(account: account, item_id: 1) }

  it 'ブックマークが追加できるかどうか' do
    expect(bookmark.save).to be_truthy
  end

  it '削除ボタンがあり、削除できるかどうか' do
    bookmark.save
    expect { bookmark.destroy }.to change { Bookmark.count }.by(-1)
  end

  it '全部削除するボタンが機能するかどうか' do
    Bookmark.create(account: account, item_id: 1)
    Bookmark.create(account: account, item_id: 2)
    account.bookmarks.destroy_all
    expect(account.bookmarks.count).to eq(0)
  end
end

