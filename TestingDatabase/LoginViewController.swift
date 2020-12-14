//
//  LoginViewController.swift
//  SafeConnect
//
//  Created by Michelle Katz on 11/19/20.
//  Copyright © 2020 Michelle Katz. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase
class LoginViewController: UIViewController, GIDSignInDelegate{

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
            self.performSegue(withIdentifier: "loginPress", sender: self)

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
          let phoneNumber = ""
          let database = Database.database().reference()

            
          // ...
            let object : [String: Any] = [ // user data
                "name": fullName!,
                "Email": email!, // to replace and update user data and to be replace with input fields
                "Googleid": idToken!,
                "Profile_Des": "",
                "Users" : userId!,
                "PhoneNumber" : phoneNumber
            ]
            database.child("Users/\(userId!)").observeSingleEvent(of: .value) { (snap) in
                if (!snap.exists()){
                    database.child("Users/\(userId!)").setValue(object)

                    currentId = userId!
                    currentemail = email!
                    currentname = fullName!
                    currentPhone = phoneNumber
                    currentGoogleId = idToken!
                    currentUsers = userId!

                }
                else{
                     //   Database.database().reference().child("Users/\(userId!)").observe(.value, with: { (snapshot) in
                        if let dict = snap.value as? [String : Any]{ //casting as anyobject
                           let ekeys = dict.keys
                           // self.connections = []
                                let User = Connection()
                                
                                User.setValuesForKeys(dict as! [String : Any]) // set to dict
                        //        self.connections.append(User)
                                currentId = userId!
                                currentemail = User.Email
                                currentname = User.name
                                currentPhone = User.PhoneNumber
                                currentGoogleId = idToken!
                                currentUsers = userId!
                            
                        }
                      //      self.connectionCV.reloadData()
                   // }, withCancel: nil)
                }
            }
        
    //        currentId = userId!
    //        currentemail = email!
    //        currentname = fullName!
    //        currentPhone = phoneNumber
    //        currentGoogleId = idToken!
    //        currentUsers = userId!
            // check there is a child and if so don't overwrite
            //adding user data to be also replace with the google ids and possibly merged as one
            self.performSegue(withIdentifier: "loginPress", sender: self)

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


    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        self.performSegue(withIdentifier: "loginPress", sender: self)
        GIDSignIn.sharedInstance()?.delegate = self
        

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var test: GIDSignInButton!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "loginPress") {
            if segue.destination is TabBarController {
                print("done")
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
