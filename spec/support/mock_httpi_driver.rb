class MockDriver < HTTPI::Adapter::Base
  register :mock_driver, deps: []

  def initialize(request)
  end

  def request(method)
    content = <<-XML_MOCK
    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><ProductResponse xmlns="http://www.shopzilla.com/services/catalog"><Offers includedResults="1" totalResults="1"><PriceSet><minPrice integral="59998">$599.98</minPrice><maxPrice integral="59998">$599.98</maxPrice></PriceSet><Offer merchantId="184056" categoryId="13050809" id="6514681944"><title>Vitamix Professional Series 750 Black with 64-Oz. Container</title><Brand id="357327"><name>Vitamix</name></Brand><description>Four pre-programmed settings automatically process your favorite recipes for Smoothies, Hot Soups, Frozen Desserts, and Purees, while a fifth program handles automated Self-Cleaning.</description><manufacturer>Vitamix</manufacturer><url>http://rd.bizrate.com/rd?t=http%3A%2F%2Fwww.amazon.com%2Fdp%2FB00LFVV8CM%2Fref%3Dasc_df_B00LFVV8CM4586991%3Fsmid%3DATVPDKIKX0DER%26tag%3Dshopzilla0d-20%26ascsubtag%3Dshopzilla_rev_128-20%3BSZ_REDIRECT_ID%26linkCode%3Ddf0%26creative%3D395093%26creativeASIN%3DB00LFVV8CM&amp;mid=184056&amp;cat_id=13050809&amp;atom=10526&amp;prod_id=&amp;oid=6514681944&amp;pos=1&amp;b_id=18&amp;bid_type=4&amp;bamt=fd093910640770ad&amp;cobrand=1&amp;ppr=1bcdf7dc04befe13&amp;af_sid=76&amp;mpid=B00LFVV8CM&amp;brandId=357327&amp;rf=af1&amp;af_assettype_id=10&amp;af_creative_id=2912&amp;af_id=614546&amp;af_placement_id=1</url><Images><Image xsize="60" ysize="60">http://d5-pub.bizrate.com/image/obj/6514681944;sq=60?mid=184056</Image><Image xsize="100" ysize="100">http://d5-pub.bizrate.com/image/obj/6514681944;sq=100?mid=184056</Image><Image xsize="160" ysize="160">http://d5-pub.bizrate.com/image/obj/6514681944;sq=160?mid=184056</Image><Image xsize="400" ysize="400">http://d5-pub.bizrate.com/image/obj/6514681944;sq=400?mid=184056</Image></Images><sku>1957</sku><detailUrl>http://www.bizrate-partner.com/oid6514681944?af_sid=76&amp;rf=af1&amp;af_assettype_id=10&amp;af_creative_id=2912&amp;af_id=614546&amp;af_placement_id=1</detailUrl><price integral="59998">$599.98</price><originalPrice integral="59998">$599.98</originalPrice><markdownPercent>0.00</markdownPercent><bidded>false</bidded><merchantProductId>B00LFVV8CM</merchantProductId><merchantName>Amazon.com</merchantName><MerchantCertification certified="false" level="NO_SURVERYS"/><merchantLogoUrl>http://s2.cnnx.io/merchant/little/184056.gif</merchantLogoUrl><condition>NEW</condition><stock>IN</stock><shipAmount integral="1264">$12.64</shipAmount><shipType>CUSTOM</shipType><relevancy>0.200871</relevancy></Offer></Offers></ProductResponse>
    XML_MOCK

    HTTPI::Response.new(200, {"Content-Type" => "text/xml;charset=UTF-8"}, content)
  end
end
