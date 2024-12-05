module ApplicationHelper
    # Meta-tags を設定・表示するメソッド
    def show_meta_tags
      set_meta_tags(default_meta_tags) if display_meta_tags.blank?
      display_meta_tags
    end
  
    # デフォルトの Meta-tags 設定
    def default_meta_tags
      {
        site: 'Where Does Back Pain Come From',
        title: 'あなたの腰痛どこから',
        reverse: true,                     # サイト名とページタイトルを逆順に表示
        separator: '|',                    # サイト名とページタイトルを区切る文字
        keywords: 'ページキーワード',     # キーワードを適切に設定
        noindex: !Rails.env.production?,   # 本番環境以外でnoindexを設定
        icon: [                            # FaviconやApple用アイコンの設定
          { href: image_url('スライド1.png') },
          { href: image_url('スライド1.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' }
        ],
        og: {                              # Open Graph Protocolの設定
          title: 'あなたの腰痛どこから',
          description: 'このアプリは腰痛を簡易的にタイプ別に分け、セルフケア方法をお伝えするアプリです。',
          image: image_url('スライド1.png'),
          url: request.original_url,
          type: 'website'
        }
      }
    end
  end
  
