# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'InterestFormula' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for InterestFormula
  pod 'Alamofire'
  pod 'Google-Mobile-Ads-SDK'
  pod 'NVActivityIndicatorView'
  pod 'RxSwift'
  pod 'RxBiBinding'

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      # 修正 shell script 路徑問題
      shell_script_path = "Pods/Target Support Files/#{target.name}/#{target.name}-frameworks.sh"
      if File.exist?(shell_script_path)
        shell_script_input_lines = File.readlines(shell_script_path)
        shell_script_output_lines = shell_script_input_lines.map { |line| 
          line.sub("source=\"$(readlink \"${source}\")\"", "source=\"$(readlink -f \"${source}\")\"")
        }
        File.open(shell_script_path, 'w') do |f|
          shell_script_output_lines.each { |line| f.write line }
        end
      end

      # 處理 PrivacyInfo.xcprivacy 檔案
      if ['RxSwift', 'RxCocoa', 'RxRelay'].include? target.name
        privacy_file_path = File.join(target.project.path.dirname, 'PrivacyInfo.xcprivacy')

        # 如果 PrivacyInfo.xcprivacy 文件存在，則更新它
        if File.exist?(privacy_file_path)
          # 讀取舊的檔案內容並進行更新
          File.open(privacy_file_path, 'w') do |file|
            file.write "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<plist version=\"1.0\">\n  <dict>\n    <key>NSPrivacyCollectedDataTypes</key>\n    <array>\n      <string>location</string>\n      <string>motion</string>\n    </array>\n  </dict>\n</plist>"
          end
        else
          # 如果檔案不存在，則創建新檔案
          File.open(privacy_file_path, 'w') do |file|
            file.write "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<plist version=\"1.0\">\n  <dict>\n    <key>NSPrivacyCollectedDataTypes</key>\n    <array>\n      <string>location</string>\n      <string>motion</string>\n    </array>\n  </dict>\n</plist>"
          end
        end

        # 添加 PrivacyInfo.xcprivacy 到 target 的 resources
        privacy_file_ref = target.project.new_file(privacy_file_path)
        target.resources_build_phase.add_file_reference(privacy_file_ref)
      end
    end
  end
end
