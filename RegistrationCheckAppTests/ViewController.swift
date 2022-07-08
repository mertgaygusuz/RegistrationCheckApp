//
//  ViewController.swift
//  RegistrationCheckApp
//
//  Created by Mert Gaygusuz on 8.07.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    enum RegistrationValidation : Error {
        case EmptyFieldError
        case WrongMailFormat
        case WrongPasswordFormat
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnRegisterClicked(_ sender: UIButton) {
        do {
            try register()
            validationMessage(title: "Registry Control", message: "Registration successfully created")
        }
        catch RegistrationValidation.EmptyFieldError{
            validationMessage(title: "Unfilled Field error", message: "Fill in all fields!")
        }
        catch RegistrationValidation.WrongMailFormat{
            validationMessage(title: "Incorrect Mail Format", message: "Enter your e-mail address correctly!")
        }
        catch RegistrationValidation.WrongPasswordFormat{
            validationMessage(title: "Incorrect password format", message: "Enter your password correctly!")
        }
        catch let unknownError{
            validationMessage(title: "Unknown Error", message: "An unknown error has been detected!"+unknownError.localizedDescription)
        }
    }
    
    func register() throws {
        let emailAdress = txtEmail.text!
        let password = txtPassword.text!
        
        if emailAdress.isEmpty || password.isEmpty{
            throw RegistrationValidation.EmptyFieldError
        }
        
        if emailAdress.mailFormatControl == false{
            throw  RegistrationValidation.WrongMailFormat
        }
        
        if password.passwordFormatControl == false{
            throw RegistrationValidation.WrongPasswordFormat
        }
    }
    
    func validationMessage(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}


extension String {
    var mailFormatControl : Bool {
        let emailFormat : String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        let result : Bool = predicate.evaluate(with: self)
        return result
    }
    
    var passwordFormatControl : Bool {
        let passwordFormat : String = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", passwordFormat)
        let result : Bool = predicate.evaluate(with: self)
        return result
    }
}
