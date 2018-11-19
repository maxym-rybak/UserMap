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
    @IBOutlet weak var signIn: UIButton!
    @IBOutlet weak var createNewUser: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var isSignIn: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        LogInRouter.configure(logInViewRef: self)
        hideActivityIndicator()
        isSignIn = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "isLoggedIn") == true {
            presenter?.router?.segueToMap(from: self)
//            performSegue(withIdentifier: "segueToMap", sender: view)
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
                presenter?.signUpAttemp(userEnterData: userEnteredData)
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
    
    func showActivityIndicator () {
        activityIndicator.isHidden = false
    }
    
    func hideActivityIndicator () {
        activityIndicator.isHidden = true
    }
    
}
