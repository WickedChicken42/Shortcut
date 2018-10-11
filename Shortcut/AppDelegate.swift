//
//  AppDelegate.swift
//  Shortcut
//
//  Created by James Ullom on 10/11/18.
//  Copyright © 2018 Hammer of the Gods Software. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var vcArray = [UIViewController]()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        // Instanciate the VCs and load them to the VC array so that the shortcut handler can bounce to them
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mountainVC = storyboard.instantiateViewController(withIdentifier: "mountainsVC") as! MountainsVC
        let spaceVC = storyboard.instantiateViewController(withIdentifier: "spaceVC") as! SpaceVC
        let oceanVC = storyboard.instantiateViewController(withIdentifier: "oceanVC") as! OceanVC

        // Loads the VCs to the VC array
        vcArray = [mountainVC, spaceVC, oceanVC] 
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // Enum defined to match the vaules in the pinfo.list definition
    enum ShortcutType: String {
        case mountains = "mountains"
        case space = "space"
        case ocean = "ocean"
    }

    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
        // Show what we got from the force touch shortcut
        print(shortcutItem.type)

        // Extracting from the shortcutitem, breaking the string into compoents by "." and then getting the last item in the resulting string array
        if let type = shortcutItem.type.components(separatedBy: ".").last {

            // Instanciate the nav VC and provide it the array of VCs we use
            let navVC = window?.rootViewController as! UINavigationController
            navVC.setViewControllers(vcArray, animated: false)
            
            switch type {
            case ShortcutType.mountains.rawValue:
                print("These are the mountains")
                navVC.popToViewController(vcArray[0], animated: true)
                completionHandler(true)

            case ShortcutType.space.rawValue:
                print("This is the Space")
                navVC.popToViewController(vcArray[1], animated: true)
                completionHandler(true)

            case ShortcutType.ocean.rawValue:
                print("The oceans far and wide")
                navVC.popToViewController(vcArray[2], animated: true)
                completionHandler(true)

            default:
                print("No ShortcutType, defaulting to Mountains")
                navVC.popToRootViewController(animated: true)
                completionHandler(true)

            }
        } else {
            completionHandler(false)

        }
        
    }
    
}

