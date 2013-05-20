require_relative '../lib/codegen'
require 'rspec_helper'
require 'pry'

describe Codegen do
	context "Analyzing ActiveRecord" do 
		before :each do
			@ar_class = mock_active_record
		end

		it "Should be able to open an ActiveRecord object and detect columns and relations" do 
			@ar_class.columns.size.should_not == 0
			@ar_class.reflect_on_all_associations.size.should_not == 0
			source = Codegen::Sources::ActiveRecord.new 
			entities = source.convert! type: :entity, models: 5.times.map { @ar_class }
			entities.size.should == 5
			entities.first.name.should == "Entity"
			entities.first.relations.count.should == 5
			entities.first.methods.count.should == 6
		end

		it "Should not convert to any other type rather than the one it declares" do
			source = Codegen::Sources::ActiveRecord.new 
			expect {
				entities = source.convert! type: :something_else
			}.to raise_error
		end
	end

	context "Generating a JavaClass Object" do
		before :each do
			@ar_class = mock_active_record
		end

		it "Should generate a valid java code for this example" do
			source = Codegen::Sources::ActiveRecord.new 
			generator = Codegen::Generators::JavaPojo.new 
			entities = source.convert! type: :entity, models: [ @ar_class ]
			
			# TODO: Check validity of file
			generator.generate! type: :entity, entities: entities, package: "com.redmintlabs"
		end
	end
end