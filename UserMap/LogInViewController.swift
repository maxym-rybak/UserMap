//
//  LogInViewController.swift
//  UserMap
//
//  Created by Max Rybak on 11/15/18.
//  Copyright © 2018 Max Rybak. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signIn: UIButton!
    @IBOutlet weak var createNewUser: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var isSignIn: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        isSignIn = true
    }
    
    @IBAction func logIn(_ sender: UIButton) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        if isSignIn == true {
            if let username = username.text, let password = password.text {
                Auth.auth().signIn(withEmail: username, password: password, completion: {
                    (user, error) in
                    if error != nil {
                        self.displayAlert(title: "error", message: error!.localizedDescription)
                    } else {
                        self.performSegue(withIdentifier: "segueToMap", sender: self)
                    }
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                } )
            }
        } else {
            if let username = username.text, let password = password.text {
                Auth.auth().createUser(withEmail: username, password: password, completion: {
                    (user, error) in
                    if error != nil {
                        self.displayAlert(title: "error", message: error!.localizedDescription)
                    } else {
                        self.singUpInSwitch()
                    }
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                } )
            }
        }
    }
    
    
    @IBAction func createNewUserPressed(_ sender: UIButton) {
        singUpInSwitch()
    }
    
    func singUpInSwitch () {
        if isSignIn == true {
            signIn.setTitle("Sign Up", for: .normal)
            createNewUser.setTitle("Switch to Log In", for: .normal)
            isSignIn = false
        } else {
            signIn.setTitle("Sing In", for: .normal)
            createNewUser.setTitle("Create new user", for: .normal)
            isSignIn = true
        }
    }
    
    func displayAlert(title: String, message: String) {
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }

}
