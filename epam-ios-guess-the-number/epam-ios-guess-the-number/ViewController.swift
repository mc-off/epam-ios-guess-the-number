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
    @IBOutlet weak var ansLabel: UILabel!
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
        self.ansLabel.text = ""
        //print(imagineNumber)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Find out what the text field will be after adding the current edit
        let text = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string)

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
    
    func setColor(_ int:Int) {
        let imagineNumberInt = Int(imagineNumber)
        switch (abs(imagineNumberInt-int)/10){
        case 0:
            self.ansLabel.textColor = UIColor.systemBlue
        case 1:
            self.ansLabel.textColor = UIColor.systemYellow
        case 2:
            self.ansLabel.textColor = UIColor.orange
        case 3:
            self.ansLabel.textColor = UIColor.systemOrange
        case 4:
            self.ansLabel.textColor = UIColor.red
        default:
            self.ansLabel.textColor = UIColor.systemRed
        }
    }
    
    @IBAction func Button(_ sender: Any) {
        guard let textFromField = inputField.text else {
            print("Problem")
            return
        }
        if Int(textFromField) ?? Int(INT8_MAX) < Int(imagineNumber){
            self.ansLabel.text = (textFromField + " is less than imagine number")
            setColor(Int(textFromField) ?? Int(INT8_MAX))
            
        } else
            if Int(textFromField) ?? Int(INT8_MIN) > Int(imagineNumber){
                self.ansLabel.text = (textFromField + " is more than imagine number")
                setColor(Int(textFromField) ?? Int(INT8_MIN))

            } else{
                self.ansLabel.text = ("You're right!")
                self.ansLabel.textColor = UIColor.green

        }

    }

}
