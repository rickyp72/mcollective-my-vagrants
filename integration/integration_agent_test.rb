#! /usr/bin/env ruby

require File.join(File.dirname(__FILE__), "spec_helper.rb")
require '/usr/libexec/mcollective/mcollective/agent/integration.rb'

describe "integration agent" do
  before :all do
    @agent = MCollective::Test::RemoteAgentTest.new("integration").plugin
  end

  describe "#echo" do
    it "should echo msg string" do
      result = @agent.echo(:msg => "echo")
      result.should be_successful
      result.should have_data_items({:message => "echo"}, :test_sender, :post_sender)
    end
  end

  describe "#validation" do
    it "should be successful if msg is validate" do
      result = @agent.validation(:msg => "validate")
      result.should be_successful
      result.should have_data_items({:passed => 1}, :test_sender, :post_sender)
    end

    it "should fail if message is not validate" do
      result = @agent.validation(:msg => "notvalidate")
      result.should be_invalid_data_error
    end
  end

  describe "#soft_fail" do
    it "should fail and set reply[:message] to 'Soft Failure'" do
      result = @agent.soft_fail
      result.should be_aborted_error
      result.should have_data_items({:message => "Soft Failure"}, :test_sender, :post_sender)
    end
  end

  describe "#hard_fail" do
    it "should fail and not set reply[:messag] to 'Hard Failure'" do
      result = @agent.hard_fail
      result.should be_aborted_error
      result.should have_data_items({:message => "unset"}, :test_sender, :post_sender)
    end
  end
end
