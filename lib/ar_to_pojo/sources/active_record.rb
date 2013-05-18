module ArToPojo
	module Sources
		module ActiveRecord
			def run options = {}
				models = options[:models] || collect_all_models
				models_and_methods = models.map { |model| 
					{ 
						model => {
							methods: model_methods(model)
							relations: model_relations(model)
						}
					}
				}
			end	

			private
			def collect_all_models
				begin
					Rails.application.eager_load!
					ActiveRecord::Base.subclasses
				rescue
					nil
				end
			end

			def model_methods model
				model.columns.map { |column|
					{
						type: column.type.to_s
						name: column.name
					}
				}
			end

			def model_relations model
				model.reflect_on_all_associations.map { |assoc| 
					{
						name: assoc.name.to_s
						klass: assoc.class_name
					}
				}
			end
		end
	end
end