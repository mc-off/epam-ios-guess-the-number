//
//  SettingsViewController.swift
//  epam-ios-guess-the-number
//
//  Created by Артем Маков on 10/02/2020.
//  Copyright © 2020 Артем Маков. All rights reserved.
//
import UIKit

protocol SettingViewControllerDelegate {
    func didReadCode(_ anyData: Any?)
}

class SettingViewController: UIViewController {
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet  weak var label: UILabel!
    @IBOutlet weak var lowBorderField: UITextField!
    @IBOutlet weak var highBorderField: UITextField!
    @IBOutlet weak var saveButton: UIButton!

    var delegate: SettingViewControllerDelegate?
    var receivedLowBorder: Int?
    var receivedHighBorder: Int?
    var sendedLowBorder: Int?
    var sendedHighBorder: Int?

    func sendData(_ anyData: Any?) {
        if let array = anyData as? [Int?] {
            receivedLowBorder = array[0]
            receivedHighBorder = array[1]
        }
    }

    func isChanged() -> Bool {
        return (receivedLowBorder != sendedLowBorder || receivedHighBorder != sendedHighBorder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func saveVariables(_ sender: UIButton) {
        if let lowValue = Int(lowBorderField.text ?? "0") {
           sendedLowBorder = lowValue
        }
        if let highValue = Int(highBorderField.text ?? "0") {
           sendedHighBorder = highValue
        }
    }

    func resetVariables() {
        lowBorderField.text = String(receivedLowBorder ?? 0)
        highBorderField.text =  String(receivedHighBorder  ?? 0)
        sendedLowBorder = receivedLowBorder
        sendedHighBorder = receivedHighBorder
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let titleView = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        titleView.contentMode = .scaleAspectFit
        titleView.text = "Settings"
        navBar.titleView = titleView
        lowBorderField.keyboardType = .numberPad
        highBorderField.keyboardType = .numberPad
        resetVariables()
    }

    @IBAction private func testDelegate() {
        if isChanged() {
            delegate?.didReadCode([sendedLowBorder, sendedHighBorder])
        }
        navigationController?.popViewController(animated: true)
    }
}
