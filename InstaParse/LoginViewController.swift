//
//  LoginViewController.swift
//  InstaParse
//
//  Created by Kwaku Owusu on 3/7/16.
//  Copyright © 2016 Kwaku Owusu. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onSignIn(sender: AnyObject) {
        
        PFUser.logInWithUsernameInBackground(userNameField.text!,password: passwordField.text!) { (user: PFUser?, error: NSError?) -> Void in
            if(user != nil){
                print("You're logged in")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }
        }
        
    }
    @IBAction func onSignUp(sender: AnyObject) {
        
        let newUser = PFUser()
        
        newUser.username = userNameField.text!
        newUser.password = passwordField.text!
        
        print(userNameField.text!)
        print(userNameField.text!)
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if(success){
                print("Yay created a user")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            } else{
                print(error?.localizedDescription)
                
                if(error?.code==202){
                    print("username is taken")
                }
            }
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
