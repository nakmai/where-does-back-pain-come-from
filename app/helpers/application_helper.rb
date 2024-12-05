module ApplicationHelper
    def show_meta_tags
        assign_meta_tags if display_meta_tags.blank?
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
            { href: image_url('top_page.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' },
          ]
        }
      end
      end
end
