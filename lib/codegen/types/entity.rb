module Codegen
	module Types
		class Entity
			attr_accessor :name, :relations, :methods

			def initialize params
				@name = params[:name]
				@relations = params[:relations]
				@methods = params[:methods]
			end
		end
	end
end
