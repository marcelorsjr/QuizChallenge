import UIKit

let kIsRunningTests = NSClassFromString("XCTestCase") != nil
let appDelegateClass = kIsRunningTests ? NSStringFromClass(TestingAppDelegate.self) : NSStringFromClass(AppDelegate.self)

UIApplicationMain(
    CommandLine.argc,
    CommandLine.unsafeArgv,
    nil,
    appDelegateClass
)
