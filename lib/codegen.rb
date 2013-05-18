require 'codegen/version'
require_relative 'codegen/sources'
require_relative 'codegen/generators'
require_relative 'codegen/types'
require_relative 'codegen/util'

module Codegen
	class Gen
		attr_accessor :source
		attr_accessor :source_options
		attr_accessor :generator
		attr_accessor :generator_options
	end
end