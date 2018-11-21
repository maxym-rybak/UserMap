//
//  LogInViewController.swift
//  UserMap
//
//  Created by Max Rybak on 11/15/18.
//  Copyright © 2018 Max Rybak. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    var presenter: LogInPresenterProtocol?
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordConfirmation: UITextField!
    @IBOutlet weak var signIn: UIButton!
    @IBOutlet weak var createNewUser: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var passConfirmationView: UIView!
    
    var isSignIn: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        LogInRouter.configure(logInViewRef: self)
        hideActivityIndicator()
        isSignIn = true
        username.attributedPlaceholder = NSAttributedString(string: "Email",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        password.attributedPlaceholder = NSAttributedString(string: "Password",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordConfirmation.attributedPlaceholder = NSAttributedString(string: "Confirm Password",
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passConfirmationView.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "isLoggedIn") == true {
            presenter?.router?.segueToMap(from: self)
        }
    }
}

extension LogInViewController: LogInViewProtocol {
    
    @IBAction func signPressed(_ sender: UIButton) {
        if let username = username.text, let password = password.text {
            let userEnteredData = EnteredUserData(username: username, password: password)
            if isSignIn == true {
                presenter?.signInAttemp(userEnterData: userEnteredData)
            } else {
                if let passConfirm = passwordConfirmation.text,
                    password == passConfirm {
                    presenter?.signUpAttemp(userEnterData: userEnteredData)
                } else {
                    displayAlert(title: "Error", message: "Passwords don't match")
                }
            }
        }
    }
    
    @IBAction func createNewUserPressed(_ sender: UIButton) {
        singUpInSwitch()
        hideActivityIndicator()
    }
    
    func displayAlert(title: String, message: String) {
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func singUpInSwitch () {
        UIView.animate(withDuration: 0.6) {
            if self.isSignIn == true {
                self.signIn.setTitle("SIGN UP", for: .normal)
                self.createNewUser.setTitle("Log In", for: .normal)
                self.passConfirmationView.isHidden = false
                self.isSignIn = false
            } else {
                self.signIn.setTitle("LOGIN", for: .normal)
                self.createNewUser.setTitle("Register", for: .normal)
                self.passConfirmationView.isHidden = true
                self.isSignIn = true
            }
        }
//        if isSignIn == true {
//            signIn.setTitle("SIGN UP", for: .normal)
//            createNewUser.setTitle("Log In", for: .normal)
//            passConfirmationView.isHidden = false
//            isSignIn = false
//        } else {
//
//            signIn.setTitle("LOGIN", for: .normal)
//            createNewUser.setTitle("Register", for: .normal)
//            passConfirmationView.isHidden = true
//            isSignIn = true
//        }
    }
    
    func showActivityIndicator () {
        activityIndicator.isHidden = false
    }
    
    func hideActivityIndicator () {
        activityIndicator.isHidden = true
    }
    
}
