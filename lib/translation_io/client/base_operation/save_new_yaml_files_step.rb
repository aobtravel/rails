module TranslationIO
  class Client
    class BaseOperation
      class SaveNewYamlFilesStep
        def initialize(target_locales, yaml_locales_path, parsed_response)
          @target_locales    = target_locales
          @yaml_locales_path = yaml_locales_path
          @parsed_response   = parsed_response
        end

        def run
          TranslationIO.info "Saving new translation YAML files."

          @target_locales.each do |target_locale|
            if @parsed_response.has_key?("yaml_po_data_#{target_locale}")
              FileUtils.mkdir_p(@yaml_locales_path)
              yaml_path = File.join(@yaml_locales_path, "translation.#{target_locale}.yml")
              TranslationIO.info yaml_path, 2, 2
              yaml_data = YAMLConversion.get_yaml_data_from_po_data(@parsed_response["yaml_po_data_#{target_locale}"], target_locale)

              top_comment = <<EOS
# WARNING. THIS FILE WAS AUTO-GENERATED BY THE TRANSLATION GEM.
# IF YOU UPDATE IT, YOUR CHANGES WILL BE LOST AT THE NEXT SYNC.
#
# To update this file, use this translation interface :
# #{@parsed_response['project_url']}/#{target_locale}
#
EOS

              File.open(yaml_path, 'wb') do |file|
                file.write("---\n")
                file.write(top_comment)
                file.write(yaml_data.split("---\n", 2).last)
              end
            end
          end
        end
      end
    end
  end
end