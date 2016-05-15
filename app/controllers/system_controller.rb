class SystemController < ApplicationController
   
    
    def mypage
        @myinfo = Info.where(user_id: current_user.id)  
    end
    
end
