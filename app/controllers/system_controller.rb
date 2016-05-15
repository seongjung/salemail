class SystemController < ApplicationController
   
    
    def mypage
        @myinfo = Info.where(user_id: current_user.id)  
    end
    
    def check_price
    
        @one_email = Email.find(params[:id]) #DB에서 상품 정보 불러오기
        
        
        address = @one_email.bburl #불러온 상품 정보에서 URL주소 뽑기
        @doc = Nokogiri::HTML(open(address))  
        @price = @doc.xpath('//span[@id="span_product_price_text"]').inner_text #새로운 가격 체크
        
        if @one_email.price == @price.to_i #새로운 가격과 기존 DB속 가격 비교
              mg_client = Mailgun::Client.new("key-155e4eeb507734091129b3afac670bc3") #메일보내기
              message_params =  {
                                 from: 'ssangyeon@naugthydog.com',
                                 to: 'josang1204@gmail.com',
                                 subject: @one_email.product_name,
                                 text: @one_email.price.to_s + "원에서 " + @price.to_s + "원으로" + " 가격이 인하되었습니다."
                                }
              
              result = mg_client.send_message('sandbox17622311ca6048dfbf7a84d22ec48697.mailgun.org', message_params).to_h!
              
              message_id = result['id']
              message = result['message'] 
        end
        
        redirect_to '/bb_list'
        
    
    end
    
    
    
    
    
    
end
