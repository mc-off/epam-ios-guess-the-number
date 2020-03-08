//
//  HistoryViewController.swift
//  epam-ios-guess-the-number
//
//  Created by Артем Маков on 08/03/2020.
//  Copyright © 2020 Артем Маков. All rights reserved.
//

import UIKit

enum Constant: String {
    case sectionTitle = "Sessions"
}

class HistoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var sessionArray:[Session] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
    }

    private func registerTableView() {
        registerTableViewCells()
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func registerTableViewCells() {
        let cell = UINib(nibName: "HistoryTableViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "HistoryTableViewCell")
    }

    func sendData(_ anyData: Any?) {
        if let array = anyData as? [Session] {
            sessionArray = array
        }
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    private func checkDuplicateData(namePerson: String) ->Bool {
        return true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessionArray.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Constant.sectionTitle.rawValue
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as? HistoryTableViewCell {

            cell.countLabel.text = String(sessionArray[indexPath.row].tryCounter)
            cell.imagineLabel.text = String(sessionArray[indexPath.row].imagineNumber)
            return cell
        }
        return UITableViewCell()
    }
}
