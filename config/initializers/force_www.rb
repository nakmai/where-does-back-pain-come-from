Rails.application.config.middleware.insert_before 0, Rack::Rewrite do
    # www から non-www へのリダイレクト
    r301 %r{^https://www\.where-does-back-pain-come-from\.com(.*)}, 'https://where-does-back-pain-come-from.com$1'
  end
  
  