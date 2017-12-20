#Podfile

# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'
# use frameworks instead of static libraries (required for swift!)
use_frameworks!

# Uncomment to use public Pods
source 'https://github.com/CocoaPods/Specs.git'

# Common Pods to all targets
def all_pods
  pod 'Reachability', '~> 3.2'
  pod 'Alamofire', '~> 4.5.1'
  pod 'Firebase/Core'
  pod 'Firebase/Database'
end

target 'AdvancedProjectManagement' do
    all_pods
end
