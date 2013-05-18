require 'hooks'

module Codegen
	module Sources
		class Base
			include Hooks

			### Adds registration of types

			class << self
				attr_accessor :convert_to
			end

			def self.converts_to * type
				if type.all? { |x| x.is_a? Symbol }
					self.convert_to = type
				else
					self.convert_to = type.map { |t|  t.to_s.underscore.to_sym }
				end
			end

			define_hooks :before_convert

			before_convert do |params|
			  raise Exception.new("Unexpected type!") if not self.class.convert_to.include? params[:type]
			end

			def convert! params
				self.run_hook :before_convert, params
				convert params
		  end
		end
	end
end