# -*- coding: utf-8 -*-.

require 'rspec'
require './notify_docomo_device_update'

describe NotifyDocomoDeviceUpdate do
  describe 'convert_str_to_date' do
    context '2013年2月3日' do
      subject { NotifyDocomoDeviceUpdate.new.convert_str_to_date("2013年2月3日") }
      it { should == "2013-02-03" }
    end
  end
end
