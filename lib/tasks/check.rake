namespace :check do
desc "Rake task to check all price"
  task allprice: :environment do
    require 'open-uri'
    require 'mailgun'
    @every_check = Email.all
    
    @every_check.each do |e|
        address = e.bburl #불러온 상품 정보에서 URL주소 뽑기
        @doc = Nokogiri::HTML(open(address))  
        @price = @doc.xpath('//span[@id="span_product_price_text"]').inner_text #새로운 가격 체크
        
        if e.price == @price.to_i #새로운 가격과 기존 DB속 가격 비교
              mg_client = Mailgun::Client.new("key-155e4eeb507734091129b3afac670bc3") #메일보내기
              message_params =  {
                                 from: 'ssangyeon@naugthydog.com',
                                 to: 'josang1204@gmail.com',
                                 subject: e.product_name,
                                 text: e.id.to_s + e.price.to_s + "원에서 " + @price.to_s + "원으로" + " 가격이 인하되었습니다."
                                }
              
              result = mg_client.send_message('sandbox17622311ca6048dfbf7a84d22ec48697.mailgun.org', message_params).to_h!
              
              message_id = result['id']
              message = result['message'] 
        end

    end
end

end