//
//  LoginViewController.swift
//  Parsetagram
//
//  Created by Avinash Singh on 07/12/17.
//  Copyright © 2017 Avinash Singh. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        usernameField.delegate = self
        passwordField.delegate = self

        // Do any additional setup after loading the view.
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if(textField == usernameField)
        {
        usernameField.textColor = UIColor.black
        }
        else{
            
            passwordField.textColor = UIColor.black
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: Error?)-> Void in
            if user != nil{
            print("user successfully logged in")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    @IBAction func onSignUp(_ sender: Any) {
        
        
        let newUser = PFUser()
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackground { (success: Bool, error: Error?) -> Void in
            if success{
            print("created a user")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            else{
                print(error!.localizedDescription)
                
                if (error as! NSError).code == 202 {
                print("user name is taken")
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
