# -*- coding: utf-8 -*-.

class NotifyDocomoDeviceUpdate
  require 'nokogiri'
  require 'open-uri'
  require 'time'
  require './actionmailer'

  DEFAULT_URL = "http://www.nttdocomo.co.jp/support/utilization/product_update/list/index.html?s=date" 
  LAST_CHECK_DATE = Time.now.strftime("%F")

  def parse_html
    result = []

    html = Nokogiri::HTML.parse(open(DEFAULT_URL), nil, "sjis")
    table = html.css("table")
    table.css("tr").each do |tr|
      tds = tr.css("td")
      if tds[0].content =~ /^[0-9]{4}.+[0-9]{1,2}.+[0-9]{1,2}/
        if convert_str_to_date(tds[0].content) >= LAST_CHECK_DATE
          result << "更新開始日 : " + tds[0].content
          result << "端末名     : " + tds[1].content
          result << "対応方法   : " + tds[2].content
        end
      end
    end
    puts result
    ::SampleMailer.first_example('There is a body.').deliver
  end

  def convert_str_to_date(str)
    target = str.gsub(/(年|月)/, "/").delete("日")
    Time.parse(target).strftime("%F")
  end
end

NotifyDocomoDeviceUpdate.new.instance_eval("parse_html")
