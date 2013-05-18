module Codegen
	module Sources
		class ActiveRecord < Base

			converts_to :entity

			def convert options = {}
				if options[:type] == :entity
					convert_entity options
				end
			end

			private
			def convert_entity options
				models = options[:models] || collect_all_models
				models_and_methods = models.map { |model| 
					begin
						{ 
							model => {
								methods: model_methods(model),
								relations: model_relations(model)
							}							
						}
					rescue Exception => e
						nil	
					end
					}.reject { |x| x.nil? }

					models_and_methods.map { |mm| 
						model_to_entity(mm)
					}
			end

			def model_to_entity mm
				model = mm.keys.first
				methods = mm[model][:methods]
				relations = mm[model][:relations]

				normalized_relations = relations.map { |relation| 
					case relation[:type]
					when :has_many, :has_and_belongs_to_many
						ref = :many
					when :belongs_to, :has_one
						ref = :one
					else
						puts "WARNING: Unexpected relation type for relation: #{relation[:name]} on class #{model}"
						ref = :one
					end

					{
						cardinality: ref,
						name: relation[:name],
						type: relation[:klass]
					}
				}

				normalized_methods = methods.map { |method| 
					{
						cardinality: :one,
						name: method[:name],
						type: method[:type]
					}
				}

				begin
					mname = model.class_name					
				rescue 
					mname = model.to_s
				end

				Codegen::Types::Entity.new name: mname, methods: normalized_methods, relations: normalized_relations
			end

			def collect_all_models
				begin
					Rails.application.eager_load! if defined?(Rails)
					::ActiveRecord::Base.subclasses
				rescue
					[]
				end
			end

			def model_methods model
				model.columns.map { |column|
					{
						type: column.type.to_s,
						name: column.name
					}
				}
			end

			def model_relations model
				model.reflect_on_all_associations.map { |assoc| 
					{
						type: assoc.macro,
						name: assoc.name.to_s,
						klass: assoc.class_name
					}
				}
			end
		end
	end
end