require 'open-uri'

class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:save]
  #로그인 한 유저만 검색가능 -> 검색은 가능하고 저장만 못하게 할 예정  
  
  def index
  end
  
  # db에 저장
  def save 
    @content = Info.where(user_id: current_user.id)
    @content_check = @content.where(product_url: params[:purl])
    
      if @content_check.count != 0
        @fail = 1
        
    
      else
        Info.create(user_id: current_user.id,
                    brand: params[:pbrand],
                    product_name: params[:pname].to_s,
                    product_price: params[:pprice].to_i,
                    product_url: params[:purl],
                    product_img: params[:pimg],
                    product_code: params[:pcode])
                    
        @fail = 2
      # redirect_to "/system/mypage"
      end
  end

#사전식배열abcd goooood 굿맨
  
  def american_write
  
    @brand = "american"
    @URL = params[:urladdress]
    html_doc = Nokogiri::HTML(open(@URL))
    @name = html_doc.xpath("//h1[@class='product-name']").inner_text.gsub(/\s/, '')
    @price = html_doc.xpath("//div[@id='skuPriceId']/span").inner_text.gsub(/\D/, '')
    @price_dc = html_doc.xpath("//div[@id='unknown']/span").inner_text.gsub(/\D/, '')
    @img_src = html_doc.xpath("//img[@class='main-img']/@src").to_s
    @code = "//div[@id='unknown']/span"
    
  end
  
  def aritaum_write
    
    @brand = "aritaum"
    @URL = params[:urladdress]
    html_doc = Nokogiri::HTML(open(@URL)) 
    @name = html_doc.xpath('//div[@class="title_area"]/h1').inner_text.gsub(/\s/, '')
    #@price_dc = @doc.xpath('//span[@class="price"]').inner_text.gsub(/\s/, '')
    @price = @doc.xpath('//strong[@class="price_sale"]').inner_text.gsub(/\D/, '')
    @img_src = @doc.xpath("//div[@class='slide cycle-slide cycle-slide-active']/img/@src[6]").to_s
    @code = '//strong[@class="price_sale"]'
    
  end
  
  def brown_write
    @brand = "brown"
    @URL = params[:urladdress]
    html_doc = Nokogiri::HTML(open(@URL))
    @name = html_doc.xpath("//div[@class='detailtt ']/h3").inner_text.gsub(/\s/, '')
    @price = html_doc.xpath('//span[@id="span_product_price_text"]').inner_text.gsub(/\D/, '')
    @img_src = html_doc.xpath("//img[@class='cloudzoom']/@src").to_s
    @code = '//span[@id="span_product_price_text"]'

  end  
  
  def carhartt
  end
  
  def carhartt_write
    
    @brand = "carhartt"
    @URL = params[:urladdress]
    html_doc = Nokogiri::HTML(open(@URL)) 
    #[1]이 괄호밖에있어야하는경우가 문제 polo도마찬가지
    @name = html_doc.xpath('//div[@class="txt02"]').inner_text.gsub(/\s/, '')
    @price = html_doc.xpath('//span[@class="ico_price"]').inner_text.gsub(/\D/, '')
    @img_src = html_doc.xpath('//div[@class="product_detail_img"]/img/@src')[1].to_s
    @code = '//span[@class="ico_price"]'
    
  end
  
  def hnm_write

    @brand = "hnm"
    @URL = params[:urladdress]
    uri = URI(@URL)
    html_doc = Nokogiri::HTML(Net::HTTP.get(uri))
    @name = html_doc.xpath('//ul[@class="breadcrumbs"]/li/strong').inner_text.gsub(/\s/, '')
    @price = html_doc.xpath('//span[@class="price"]/span').inner_text.gsub(/\D/, '')
    @img_src = html_doc.xpath('//img[@class="FASHION_FRONT"]/@src').to_s
    @code = '//span[@class="price"]/span'
    
  end
  #폴로폐업
  # def polowrite
   
  #   @brand = "Polo"
  #   @URL = params[:urladdress]
  #   html_doc = Nokogiri::HTML(open(@URL))
  #   @name = html_doc.xpath('//div[@class="pdd_title box"]/h3').inner_text.gsub(/\s/, '')
  #   @price = html_doc.xpath('//p[@class="pdd_price"]/span')[1].inner_text.gsub(/\D/, '')
  #   @img_src = html_doc.xpath('//ul[@class="box"]/li[1]/img/@src').to_s
  #   @code = '//p[@class="pdd_price"]/span'
  #
    
  # end
  
  def eightseconds_write

    @brand = "eightseconds"
    @URL = params[:urladdress]
    html_doc = Nokogiri::HTML(open(@URL))
    @name = html_doc.xpath("//h3[@class='prdTit']").inner_text.gsub(/\s/, '')
    @price = html_doc.xpath("//strong[@id='sPriceStrong']").inner_text.gsub(/\D/, '')
    @img_src = html_doc.xpath("//div[@class='prdImg']/ul/li[1]/img/@src").to_s
    @code = "//strong[@id='sPriceStrong']"
    
  end

  def mixxo_write
    
    @brand = "mixxo"
    @URL = params[:urladdress]
    html_doc = Nokogiri::HTML(open(@URL))
    @name = html_doc.xpath("//span[@id='ctl00_ContentPlaceHolder1_StyleName']").inner_text.gsub(/\s/, '')
    @price = @doc.xpath("//dd[@class='pdPrice']").inner_text.gsub(/\D/, '')
    @price_dc = @doc.xpath("//dd[@class='dcPrice']").inner_text.gsub(/\D/, '')
    @img_src = html_doc.xpath("//img[@class='b_img']/@src").to_s
    @code = "//dd[@class='pdPrice']"
    
  end
  
  def musinsa_write
 
    @brand = "MUSINSA"  
    @URL = params[:urladdress]
    html_doc = Nokogiri::HTML(open(@URL))
    @name = html_doc.xpath('//span[@class="txt_tit_product"]').inner_text.gsub(/\s/, '')
    @price = html_doc.xpath('//span[@id="goods_price"]').inner_text.gsub(/\D/, '')
    @img_src = html_doc.xpath("//img[@id='bigimg']/@src").to_s
    @code = '//span[@id="goods_price"]'
    
  end
   
  def oliveyoung_write
    
    @URL = params[:urladdress]
    @doc = Nokogiri::HTML(open(@URL)) 
    @name = @doc.xpath('//h1[@id="item_full_name"]').inner_text.gsub(/\s/, '')
    @price = @doc.xpath('//span[@id="sale_price_text"]').inner_text.gsub(/\D/, '')
    @img_src = @doc.xpath("//img[@class='viewImg']/@src").to_s
    @code = '//span[@id="sale_price_text"]'
    
  end
 
  def uniqlo_write
    
    @brand = "UNIQLO"
    @URL = params[:urladdress]
    @doc = Nokogiri::HTML(open(@URL)) 
    @name = @doc.xpath('//h2[@id="goodsNmArea"]').inner_text.gsub(/\s/, '')
    @price = @doc.xpath('//p[@id="salePrice"]').inner_text.gsub(/\D/, '')
    #유니클로 이미지 수정해야됌
    #@img_src = @doc.xpath("//div[@id='prodImgDefault']/img/@src").to_s
    @code = '//p[@id="salePrice"]'

  end
  
  def imshopwrite
    
    @brand = "imshop"
    @URL = params[:urladdress]
    html_doc = Nokogiri::HTML(open(@URL)) 
    #[1]이 괄호밖에있어야하는경우가 문제 polo도마찬가지
    @name = html_doc.xpath('//h3[@class="name"]').inner_text.gsub(/\s/, '')
    @price = html_doc.xpath('//p[@class="price"]').inner_text.gsub(/\D/, '')
    @img_src = html_doc.xpath('//img[@class="img"]/@src').to_s
    @code = '//p[@class="price"]'
    
  end
  
  
end