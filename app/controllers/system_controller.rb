require 'mailgun'
class SystemController < ApplicationController
   
    
    def mypage
            @myinfo = Info.where(user_id: current_user.id) 
           
    end
    
    def check_all_price
            current_user.infos.each do |n|
    
                
                address = n.product_url #불러온 상품 정보에서 URL주소 뽑기
                @doc = Nokogiri::HTML(open(address))  
                @price = @doc.xpath(n.product_code).inner_text.gsub(/\D/, '') #새로운 가격 체크

                if n.product_price > @price
                
                      mg_client = Mailgun::Client.new("key-be21c48c7ce4476a2024cb1789bb67c6") #메일보내기
                      message_params =  {
                                         from: "bargin.sale.yo@gmail.com",
                                         to: current_user.email, #여기엔 a.email 를 넣을 예정
                                         subject: '[Sale-Yo!]' + n.product_name + ' 할인 정보',
                                         text: n.brand + ' ' + n.product_name + ' 상품이 ' + n.product_price + "원에서 " + @price.to_s + "원으로" +  " 인하되었습니다."
                                                # <a href = "http://week1-seongjung1.c9users.io"> "Sale-Yo!"</a>"로 이동하기"    
                                        }
                                        #상품 이름, 이미지 추가해야 됌
                      
                      result = mg_client.send_message('sandboxa54a534437d449e697149b3232fad1e7.mailgun.org', message_params).to_h!
                      
                      message_id = result['id']
                      message = result['message']
 
                end
            
            
            end
        
        redirect_to "/"
    
    end
    
    def destroy
        @one_product = Info.find(params[:id])
        @one_product.destroy
        redirect_to "/system/mypage" 
    end
    
    
    
    
    
end
