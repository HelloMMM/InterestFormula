# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'InterestFormula' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for InterestFormula

pod 'Alamofire'
pod 'Google-Mobile-Ads-SDK'
pod 'NVActivityIndicatorView'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    shell_script_path = "Pods/Target Support Files/#{target.name}/#{target.name}-frameworks.sh"
    if File::exists?(shell_script_path)
      shell_script_input_lines = File.readlines(shell_script_path)
      shell_script_output_lines = shell_script_input_lines.map { |line| line.sub("source=\"$(readlink \"${source}\")\"", "source=\"$(readlink -f \"${source}\")\"") }
      File.open(shell_script_path, 'w') do |f|
        shell_script_output_lines.each do |line|
          f.write line
        end
      end
    end
  end
end

end
