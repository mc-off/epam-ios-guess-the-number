//
//  ViewController.swift
//  epam-ios-guess-the-number
//
//  Created by Артем Маков on 23/01/2020.
//  Copyright © 2020 Артем Маков. All rights reserved.
//

import UIKit

enum Constants: String {
    case title = "Guess the number"
    case typeHint = "Type here"
    case problem  = "Problem"
    case triesDone = " tries done"
    case lessImagine = " is less than imagine number"
    case moreImagine = " is more than imagine number"
    case right = "You're right!"
    case specify = "Please, specify deffault in settings"
    case allertUpdated = "Your deffaults were updated. Wanna new game?"
    case alertDeffault = "Wanna new game?"
    case alertWin = "You win!"
    case alertAttention = "Attention!"
}

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var ansLabel: UILabel!
    @IBOutlet weak var navBar: UINavigationItem!
    //variables
    let userDefaults: UserDefaults = UserDefaults.standard
    var lowBorder: Int?
    var highBorder: Int?
    var alertStartOnViewAppear: Bool = false
    var alertText: String = ""
    var alertTitle: String = ""
    var session: Session = Session()
    var sessionArray: [Session] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        ansLabel.text = ""
        resetAlertParams()
    }

    func checkSetDeffault() -> Bool {
        print("low is ")
        print(userDefaults.integer(forKey: "lowBorder"))
        print("high is ")
        print(userDefaults.integer(forKey: "highBorder"))
        return (userDefaults.integer(forKey: "lowBorder") != 0 || userDefaults.integer(forKey: "highBorder") != 0)
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        if (checkSetDeffault()) {
            setInputActive(bool: true)
            startNewGame()
        } else {
            setInputActive(bool: false)
            ansLabel.text = Constants.specify.rawValue
        }

        setButtonActive(bool: false)
        inputField.delegate = self
        inputField.keyboardType = .numberPad
        let titleView = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        titleView.contentMode = .scaleAspectFit
        titleView.text = Constants.title.rawValue
        navBar.titleView = titleView
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if (alertStartOnViewAppear) {
            allertAboutNewGame()
            resetAlertParams()
        }
    }

    func startNewGame() {
        updateLocalValues()
        ansLabel.text = ""
        inputField.text = ""
        if (session.imagineNumber != Session().imagineNumber) {
            sessionArray.append(session)
            session = Session()
        }
        session.imagineNumber = Int.random(in: (lowBorder ?? 0) ..< (highBorder ?? 100))
    }

    func stopGame() {

    }

    func incCounter() {
        session.tryCounter += 1
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Find out what the text field will be after adding the current edit
        let text = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string)

//        if Int(text) != nil {
//            // Text field converted to an Int
//            setButtonActive(bool: <#T##Bool#>)
//        } else {
//            // Text field is not an Int
//            button.isEnabled = false
//        }
        setButtonActive(bool: Int(text) != nil)
        //return true if success
        return true
    }

    func setButtonActive(bool: Bool) {
        button.isEnabled = bool
    }

    func setInputActive(bool: Bool) {
        inputField.isEnabled = bool
    }

    func setColor (_ int: Int) {
        let imagineNumberInt = Int(session.imagineNumber)
        switch abs(imagineNumberInt-int) {
        case 0:
            self.ansLabel.textColor = .green
        case 1...10:
            self.ansLabel.textColor = .systemBlue
        case 11...20:
            self.ansLabel.textColor = .systemYellow
        case 21...30:
            self.ansLabel.textColor = .orange
        case 31...40:
            self.ansLabel.textColor = .systemOrange
        case 41...50:
            self.ansLabel.textColor = .red
        default:
            self.ansLabel.textColor = .systemRed
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingViewController = segue.destination as? SettingViewController {
            settingViewController.sendData([lowBorder, highBorder])
            settingViewController.delegate = self
        }

        if let historyViewController = segue.destination as? HistoryViewController {
            historyViewController.sendData(sessionArray)
        }
    }
    //button action
    @IBAction func button(_ sender: Any) {
        guard let textFromField = inputField.text else {
            print(NSLocalizedString(Constants.problem.rawValue, comment: ""))
            return
        }

        incCounter()

        if Int(textFromField) ?? Int(INT8_MAX) < session.imagineNumber {
            self.ansLabel.text = (textFromField + NSLocalizedString(Constants.lessImagine.rawValue, comment: ""))
            setColor(Int(textFromField) ?? Int(INT8_MAX))
        } else
        if Int(textFromField) ?? Int(INT8_MIN) > session.imagineNumber {
                self.ansLabel.text = (textFromField + NSLocalizedString(Constants.moreImagine.rawValue, comment: ""))
                setColor(Int(textFromField) ?? Int(INT8_MIN))

            } else {
                self.ansLabel.text = NSLocalizedString(Constants.right.rawValue, comment: "")
                alertTitle = Constants.alertWin.rawValue
                alertText = Constants.alertDeffault.rawValue
                allertAboutNewGame()
                setColor(Int(textFromField) ?? 0)
        }
    }

    func updateLocalValues() {
        lowBorder = userDefaults.integer(forKey: "lowBorder")
        highBorder = userDefaults.integer(forKey: "highBorder")
    }

    func allertAboutNewGame() {
        let alert = UIAlertController(title: alertTitle, message:  alertText, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.startNewGame()
        }))

        self.present(alert, animated: true)
    }

    func resetAlertParams() {
        alertStartOnViewAppear = false
        alertText = Constants.alertDeffault.rawValue
        alertTitle = Constants.alertAttention.rawValue
    }
}

extension ViewController: SettingViewControllerDelegate {
    func didReadCode(_ anyData: Any?) {
        if let array = anyData as? [Int?] {
            userDefaults.set(array[0], forKey: "lowBorder")
            userDefaults.set(array[1], forKey: "highBorder")
            alertText = Constants.allertUpdated.rawValue
            alertStartOnViewAppear = true
            alertTitle = Constants.alertAttention.rawValue
        }
    }
}
