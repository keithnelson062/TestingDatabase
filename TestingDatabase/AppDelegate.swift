//
//  AppDelegate.swift
//  TestingDatabase
//
//  Created by Keith Nelson on 11/16/20.
//  Copyright © 2020 Keith Nelson. All rights reserved.
//

// For the google SSO, we used the reference listed below
// https://developers.google.com/identity/sign-in/ios/sign-in?ver=swift

import UIKit
import Firebase

import GoogleSignIn
var currentId = ""
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate{
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        // Initialize sign-in
        GIDSignIn.sharedInstance().clientID = "676438809748-sn1is1foiuhtfbfi02t0374rqm2c8oq8.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    
    // iOS 9 and newer
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
    
    //iOS 9 and oler
    func application(_ application: UIApplication,
                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
    
    
    // Sign in and collect data per user
    // ***TODO*** - send data to the firebase database here
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
      if let error = error {
        if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
          print("The user has not signed in before or they have since signed out.")
        } else {
          print("\(error.localizedDescription)")
        }
        return
      }
      // Perform any operations on signed in user here.
      let userId = user.userID                  // For client-side use only! //
        // keep userid to append events by and not repeat users so data does not make copyies
      let idToken = user.authentication.idToken // Safe to send to the server
      let fullName = user.profile.name
      let givenName = user.profile.givenName
      let familyName = user.profile.familyName
      let email = user.profile.email
      let database = Database.database().reference()

        
      // ...
        let object : [String: Any] = [ // user data
            "name": fullName!,
            "Email": email!, // to replace and update user data and to be replace with input fields
            "Googleid": idToken!,
            "Profile_Des": "", 
            "Users" : userId!,
        ]
        database.child("Users/\(userId!)").setValue(object)
        currentId = userId!
        //"users/\(user.uid)/username
        //adding user data to be also replace with the google ids and possibly merged as one
    }
    // keep the userid
    // sign out by disconnect
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
      // Perform any operations when the user disconnects from app here.
      // ...
    }
    
    // sign out button
    @IBAction func didTapSignOut(_ sender: AnyObject) {
      GIDSignIn.sharedInstance().signOut()
    }


}

