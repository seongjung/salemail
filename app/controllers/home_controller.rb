require 'open-uri'

class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:save]
  #로그인 한 유저만 검색가능 -> 검색은 가능하고 저장만 못하게 할 예정  
  
  def index
  end
  # db에 저장
  def save 
          
      Info.create(user_id: current_user.id,
                  brand: "hnm",
                  product_name: params[:pname],
                  product_price: params[:pprice].to_i,
                  product_url: params[:purl])
 
      redirect_to "/system/mypage"
  end    
  
  def hnm
  end
  
  def hnmwrite
    #성중오빠 짱짱맨 
    @brand = "hnm"
    @URL = params[:urladdress]
    uri = URI(@URL)
    html_doc = Nokogiri::HTML(Net::HTTP.get(uri))
    @price = html_doc.css("span.actual-price").inner_text # span이란 태그 중 actual-price ID가 있는 걸 찾는다.
    @name = html_doc.css("form#product//h1").inner_text # form이란 태그 중 prodcut Class 가 있는 걸 찾고 그 안에 h1 태그를 찾는다.
    @img_src = html_doc.css("div.zoom-pan/@src").to_s
  
  end
  
  def brown_write

    @address = params[:urladdress]
    @doc = Nokogiri::HTML(open(@address))
    @product = @doc.xpath("//div[@class='detailtt ']/h3").inner_text
    @price = @doc.xpath('//span[@id="span_product_price_text"]').inner_text
    @imagesrc = @doc.xpath("//img[@class='cloudzoom']/@src").to_s

  end


  def polowrite
   
    @urlofpolo = params[:urladdress]
    @polodoc = Nokogiri::HTML(open(@urlofpolo))
    @poloproduct = @polodoc.xpath('//div[@class="pdd_title box"]/h3').inner_text 
    @poloprice = @polodoc.xpath('//p[@class="pdd_price"]/span').inner_text
    
    
  end
  
  
  def musinsawrite
  
    @urlofmusinsa = params[:urladdress]
    @musinsadoc = Nokogiri::HTML(open(@urlofmusinsa))
    @musinsaproduct = @musinsadoc.xpath('//span[@class="txt_tit_product"]').inner_text 
    @musinsaprice = @musinsadoc.xpath('//span[@id="goods_price"]').inner_text
    
  end
  
  def uniqlo
    
    @uniqlo_url = params[:urladdress]
    @uniqlo_doc = Nokogiri::HTML(open(@uniqlo_url)) 
    @uniqlo_product = @uniqlo_doc.xpath('//h2[@id="goodsNmArea"]').inner_text 
    @uniqlo_price = @uniqlo_doc.xpath('//p[@id="salePrice"]').inner_text

  end
  
  def uniqlo_write
    
    @uniqlo_url = params[:urladdress]
    @uniqlo_doc = Nokogiri::HTML(open(@uniqlo_url)) 
    @uniqlo_product = @uniqlo_doc.xpath('//h2[@id="goodsNmArea"]').inner_text 
    @uniqlo_price = @uniqlo_doc.xpath('//p[@id="salePrice"]').inner_text

  end

  
  def eightseconds

  end
  
  def eightseconds_write

    @url = params[:urladdress]
    @doc = Nokogiri::HTML(open(@url))
    @product = @doc.xpath("//h3[@class='prdTit']").inner_text
    @product_img = @doc.xpath("//li/div[@class='zoomImg']/img/@src").to_s
    # 이미지에 클래스가 없어요...
    @price = @doc.xpath("//strong[@id='sPriceStrong']").inner_text
    
  end
  
  def mixxo

  end
  
  def mixxo_write

    @url = params[:urladdress]
    @doc = Nokogiri::HTML(open(@url))
    @product = @doc.xpath("//span[@id='ctl00_ContentPlaceHolder1_StyleName']").inner_text
    @product_img = @doc.xpath("//img[@class='b_img']/@src").to_s
    @price = @doc.xpath("//dd[@class='pdPrice']").inner_text
    @price_dc = @doc.xpath("//dd[@class='dcPrice']").inner_text
    

  end
       
  

end