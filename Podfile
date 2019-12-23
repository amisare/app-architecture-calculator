source 'https://cdn.cocoapods.org/'

platform :ios, '13.0'

inhibit_all_warnings!
use_frameworks!

workspace   'Calculator.xcworkspace'
project     './Calculator/Calculator.xcodeproj'

def common_pods
    pod 'GCDWebServer'
    pod 'MBProgressHUD'
    pod 'Toast'
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

target 'CalculatorMAVB' do
    common_pods
end

target 'CalculatorMVC-VS' do
    common_pods
end

target 'CalculatorTEA-SwiftUI' do
    common_pods
end

target 'CalculatorTEA-CK' do
    common_pods
    pod 'ComponentKit', '0.29'
end
