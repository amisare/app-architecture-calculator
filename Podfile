source 'https://cdn.cocoapods.org/'

platform :ios, '8.0'

inhibit_all_warnings!
use_frameworks!

workspace   'Calculator.xcworkspace'
project     './Calculator/Calculator.xcodeproj'

def common_pods
    pod 'GCDWebServer'
    pod 'MBProgressHUD'
    pod 'Toast'
    pod 'ComponentKit', :path => './Local Podspecs/ComponentKit.podspec'
    pod 'RxSwift'
    pod 'RxCocoa'
end

target 'CalculatorMVC' do
    common_pods
end

target 'CalculatorMVP' do
    common_pods
end

target 'CalculatorMVVM' do
    common_pods
end

target 'CalculatorMVVM-Rx' do
    common_pods
end
