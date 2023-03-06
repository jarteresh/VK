//
//  SignUpViewController.swift
//  Vk client
//
//  Created by Ярослав on 05.03.2023.
//

import UIKit

class RegViewController: UIViewController {

    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUp(_ sender: Any) {
        if email.text == "" || password.text == "" {
            let alertVC = UIAlertController(title: "Error", message: "Please, fill in all fields", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(alertVC, animated: true)
            return
        }
        if password.text!.count < 6 {
            let alertVC = UIAlertController(title: "Error", message: "Your password must be at least 6 characters", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(alertVC, animated: true)
            return
        }
        if !isValidEmail(email.text!) {
            let alertVC = UIAlertController(title: "Error", message: "Please, enter valid email", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(alertVC, animated: true)
            return
        }
        
        Service().regNewUser(password: password.text!, email: email.text!) { isRegistered in
            if isRegistered {
                self.dismiss(animated: true)
            } else {
                let alertVC = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                self.present(alertVC, animated: true)
            }
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
