
Pod::Spec.new do |spec|

  spec.name         = "SSDateTimePicker"
  spec.version      = "1.0.0"
  spec.summary      = "Date and time selection picker."
  spec.description  = "SSDateTimePicker offers versatile date and time selection options, including single date, multiple date, and date range selection."
  spec.homepage     = "https://github.com/SimformSolutionsPvtLtd/SSDateTimePicker.git"
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }

  spec.author       = { "Rizwana" => "rizwana@simformsolutions.com" }

  spec.platform     = :ios, "15.0"
  spec.source       = { :git => "https://github.com/SimformSolutionsPvtLtd/SSDateTimePicker.git", :tag => spec.version.to_s }
  spec.source_files  = "Sources", "Sources/SSDateTimePicker/SSDateTimePicker/**/*.{swift, xcassets}"
  spec.resources    = "Sources/SSDateTimePicker/**/*.{xcassets,storyboard,xib,plist,json,strings,lproj}"
  spec.swift_versions = "5.9"

end
