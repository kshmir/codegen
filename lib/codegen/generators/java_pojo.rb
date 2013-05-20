require 'active_support/inflector'

module Codegen
	module Generators
		class JavaPojo < Base
			converts_to :entity

			def generate options = {}
				if options[:type] == :entity
					generate_entity options
				end
			end

			private
			def generate_entity options
				entities = options[:entities]
				package = options[:package] || ""
				destination = options[:destination] || "gen/java/"

				entities.each do |entity|
					code = make_code_for(entity, package)
					filename = make_filename_for(entity, package, destination)
					save filename, code
				end
			end

			def make_filename_for entity, package, destination
				"#{destination}#{package.gsub(/\./,"/")}/#{entity.name}.java"
			end

			def save filename, code
				dir = File.dirname(filename)
				FileUtils.mkdir_p(dir)
				f = File.open(filename, "w+")
				f.puts code
				f.flush
				f.close
				puts "Saved: #{filename}"
			end

			def make_code_for entity, package
				# import packagename;
				define_import(package).append_line do
					# public class classname { 
					class_opening(entity.name).append_line do 
						# // Attributes declaration
						methods_declaration.append_line do
							# public Type name or public List<Type> name;
							entity.methods.map do |method|
								method_declaration(method)
							end.join("\r\n")
						end.append_line do
							relations_declaration.append_line do
								# public Type name or public List<Type> name;
								entity.relations.map do |relation|
									method_declaration(relation)
								end.join("\r\n")
							end
						end
					end
				end.concat(closing_mark)
			end

			def closing_mark 
				"\r\n}"
			end

			def method_declaration method
				declaration = "\t"
				if method[:cardinality] == :many
					return declaration += "List<#{resolve_type method[:type]}> #{method[:name]};"
				elsif method[:cardinality] == :one
					return declaration += "#{resolve_type method[:type]} #{method[:name]};"
				end
				raise Exception.new "Unsupported entity cardinality!"
			end

			def resolve_type type
				case type.to_s
					when "string", "date", "float", "integer"
						return type.to_s.titleize
					when "text"
						return "String"
					when "datetime"
						return "DateTime"
					else
						return type
				end
			end

			def methods_declaration
				"\r\n\t// Attributes declaration"
			end

			def relations_declaration
				"\r\n\t// Relations declaration"
			end

			def define_import package
				if package != nil && package != ""
					"import #{package};"
				else
					""
				end
			end

			def class_opening name
				"public class #{name.camelize} {"
			end
		end
	end
end