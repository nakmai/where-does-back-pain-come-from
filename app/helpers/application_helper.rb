module ApplicationHelper
    def show_meta_tags
        set_meta_tags(default_meta_tags) if display_meta_tags.blank?
        display_meta_tags
      end
    
      def default_meta_tags
        def default_meta_tags
        {
          site: 'Where Does Back Pain Come From',
          title: 'あなたの腰痛どこから',
          reverse: true,
          separator: '|',   #Webサイト名とページタイトルを区切るために使用されるテキスト
          keywords: 'ページキーワード',   #キーワードを「,」区切りで設定する
          noindex: ! Rails.env.production?,
          icon: [                    #favicon、apple用アイコンを指定する
            { href: image_url('スライド1.png') },
            { href: image_url('スライド1.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' },
          ],
          og: {                              # Open Graph Protocolの設定
          title: :あなたの腰痛どこから,
          description: 'このアプリは腰痛を簡易的にタイプ別に分け、セルフケア方法をお伝えするアプリです。',
          image: image_url('スライド1.png'),
          url: request.original_url,
          type: 'website'
        }        
        }
      end
    end
end
