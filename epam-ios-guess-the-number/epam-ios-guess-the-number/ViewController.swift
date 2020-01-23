//
//  ViewController.swift
//  epam-ios-guess-the-number
//
//  Created by Артем Маков on 23/01/2020.
//  Copyright © 2020 Артем Маков. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var inputField: UITextField!
    var imagineNumber = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        imagineNumber = Int.random(in: 0 ..< 100)
        button.isEnabled = false
        inputField.delegate = self
        inputField.keyboardType = .numberPad
        print(imagineNumber)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Find out what the text field will be after adding the current edit
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)

        if Int(text) != nil {
            // Text field converted to an Int
            button.isEnabled = true
        } else {
            // Text field is not an Int
            button.isEnabled = false
        }

        // Return true so the text field will be changed
        return true
    }
    
    
    @IBAction func Button(_ sender: Any) {
        guard let textFromField = inputField.text else {
            print("Problem")
            return
        }
        if (Int(textFromField)! < Int(imagineNumber)){
            print(textFromField + " is less than imagine number")
        } else
            if (Int(textFromField)! > Int(imagineNumber)){
                print(textFromField + " is more than imagine number")
            } else{
                print("You're right!")
                
        }

    }

}
