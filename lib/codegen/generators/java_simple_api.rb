module Codegen
	module Generators
		class JavaSimpleApi < Base
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
					str = ""
					str << "package #{package};" unless package.is_empty?
					str << """
					public interface #{entity.name}Endpoint {
					    @GET
					    @Path(\"/#{entity.name.underscore}/{id}.json\")
					    @Produces(\"application/json\")
					    public #{entity.name} getById(@PathParam(\"id\") String id);

					    @GET
					    @Path(\"/#{entity.name.underscore}.json\")
					    @Produces(\"application/json\")
					    public List<#{entity.name}> getAll();
					}
					"""
					str
			end
		end
	end
end