# -*- coding: utf-8 -*-.

class NotifyDocomoDeviceUpdate
  require 'nokogiri'
  require 'open-uri'
  require 'time'

  DEFAULT_URL = "http://www.nttdocomo.co.jp/support/utilization/product_update/list/index.html?s=date" 
  LAST_CHECK_DATE = Time.now.strftime("%F")

  def test
    html = Nokogiri::HTML.parse(open(DEFAULT_URL), nil, "sjis")
    table = html.css("table")
    table.css("tr").each do |tr|
      tds = tr.css("td")
      if tds[0].content =~ /^[0-9]{4}.+[0-9]{1,2}.+[0-9]{1,2}/
        target = tds[0].content.gsub(/(年|月)/, "/").delete("日")
        if Time.parse(target).strftime("%F") >= LAST_CHECK_DATE
          p "========================"
          p "更新開始日 : " + tds[0].content
          p "端末名     : " + tds[1].content
          p "対応方法   : " + tds[2].content
        end
      end
    end
  end
end

NotifyDocomoDeviceUpdate.new.instance_eval("test")
