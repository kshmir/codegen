module Helpers
	def mock_active_record
		ar_class = mock("Entity")

		columns = [
			["name", :string],
			["birth_date", :date],
			["register_date",:datetime],
			["precision",:float],
			["score",:integer],
			["description",:text]
		].map { |item| 
			column_mock = mock("Object")
			column_mock.stub!(:name).and_return(item[0])
			column_mock.stub!(:type).and_return(item[1])
			column_mock
		}

		associations = [
			["Project", :has_and_belongs_to_many, :projects],
			["Comment", :has_many, :comments],
			["Picture", :has_many, :pictures],
			["Profile", :has_one, :profile],
			["Company", :belongs_to, :organization]
		].map { |item| 
			assoc_mock = mock("Object")
			assoc_mock.stub!(:class_name).and_return(item[0])	
			assoc_mock.stub!(:macro).and_return(item[1])
			assoc_mock.stub!(:name).and_return(item[2])
			assoc_mock
		}

		ar_class.stub!(:reflect_on_all_associations).and_return(associations)
		ar_class.stub!(:columns).and_return(columns)
		ar_class.stub!(:class_name).and_return("Entity")
		ar_class.stub!(:to_s).and_return("Entity")
		ar_class.stub!(:ancestors).and_return(["ActiveRecord::Base"])
		ar_class
	end
end
