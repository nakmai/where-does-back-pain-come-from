class DiagnosticResultController < ApplicationController
    def counternutation
        render 'diagnostic_result/counternutation'
      end
    def incontestable
        # このアクションでは、診断不可能ページを表示する
      render 'diagnostic_result/incontestable'
    end

end
