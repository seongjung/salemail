require 'open-uri'

class HomeController < ApplicationController
  def index
  end

  def hnm
    
  end
  
  def write
    #성중오빠 짱짱맨 
    @address = params[:urladdress]
    @URL = @address
    uri = URI(@URL)
    html_doc = Nokogiri::HTML(Net::HTTP.get(uri))
    @result_1 = html_doc.css("span.actual-price").inner_text # span이란 태그 중 actual-price ID가 있는 걸 찾는다.
    @result_2 = html_doc.css("form#product//h1").inner_text # form이란 태그 중 prodcut Class 가 있는 걸 찾고 그 안에 h1 태그를 찾는다.
  
  end
  
  def brownbreath

    @urlofbb = params[:urladdress]
    @doc = Nokogiri::HTML(open(@urlofbb))
    @name = @doc.xpath('//div[@class="detailtt"]/h3').inner_text 
    @price = @doc.xpath('//span[@id="span_product_price_text"]').inner_text
    

  end
  
  def eightseconds


    @doc = Nokogiri::HTML(open("http://http://www.ssfshop.com/public/goods/detail/"))
    @product = @doc.xpath("//h3[@class='prdTrd']").inner_text
    @price = @doc.xpath("//strong[@id='sPriceStrong']").inner_text\
    


  end
  
  #이지혜가 만들 zara 페이지입니다!
  #def zara
   
    #@address = params[:urladdress]
    #@URL = @address
    #uri = URI(@URL)
    #html_doc = Nokogiri::HTML(Net::HTTP.get(uri))
    #@price = html_doc.css("class.price_product-price").inner_text # span이란 태그 중 actual-price ID가 있는 걸 찾는다.
    #@name = html_doc.css("form#product//h1").inner_text # form이란 태그 중 prodcut Class 가 있는 걸 찾고 그 안에 h1 태그를 찾는다.
    
    
  #end
  
  #jw
  
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
  
  
  
 end