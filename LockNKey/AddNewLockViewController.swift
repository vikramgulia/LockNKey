//
//  AddNewLockViewController.swift
//  LockNKey
//
//  Created by vikram on 4/10/16.
//  Copyright © 2016 guliaz. All rights reserved.
//

import UIKit

class AddNewLockViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    
    var lockNKey:LockNKey!
    
    var isCompanyValid = false
    var isUserValid = false
    var isPasswordValid = false
    
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyNameTextField.delegate = self
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        urlTextField.delegate = self
        // Do any additional setup after loading the view.
        saveButton.enabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        enableSaveButton(textField)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        enableSaveButton(textField)
    }
    
    func enableSaveButton(textField: UITextField){
        if let fieldPlaceHolder = textField.attributedPlaceholder?.string {
            if(!(fieldPlaceHolder.isEmpty)){
                if(fieldPlaceHolder == Common.FieldPaceHolders.companyPlaceHolder){
                    if(!((textField.text?.isEmpty)!)){
                        isCompanyValid = true
                    } else  {
                        isCompanyValid = false
                    }
                } else if(fieldPlaceHolder == Common.FieldPaceHolders.usernamePlaceHolder){
                    if(!((textField.text?.isEmpty)!)){
                        isUserValid = true
                    } else  {
                        isUserValid = false
                    }
                } else if(fieldPlaceHolder == Common.FieldPaceHolders.passwordPlaceHolder){
                    if(!((textField.text?.isEmpty)!)){
                        isPasswordValid = true
                    } else  {
                        isPasswordValid = false
                    }
                }
            }
        }
        saveButton.enabled = Common.enableSaveButton(self.isUserValid, isCompanyValid: self.isCompanyValid, isPasswordValid: self.isPasswordValid )
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(sender as! UIBarButtonItem) != self.saveButton {
            lockNKey = nil
            return
        }
        
        var url = ""
        if (!((self.urlTextField.text?.isEmpty)!)){
            url = self.urlTextField.text!
        }
        self.lockNKey = LockNKey(companyName: companyNameTextField.text!, userName: userNameTextField.text!, password: passwordTextField.text!, url: url)
    }
}