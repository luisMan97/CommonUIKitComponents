//
//  ViewController.swift
//  CommonUIKitComponents
//
//  Created by luisMan97 on 09/01/2022.
//  Copyright (c) 2022 luisMan97. All rights reserved.
//

import UIKit
import CommonUIKitComponents

class ViewController: UIViewController {
    
    private lazy var tableView = UITableView().then {
        $0.dataSource = self
        $0.delegate = self
    }
    
    enum Options: String, CaseIterable {
        case modal = "Modal"
    }
    
    let options = Options.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UIKitCommons"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        addSubViews()
    }
    
    private func addSubViews() {
        tableView.fixInView(view)
    }

}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row + 1). \(options[indexPath.row].rawValue)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        options.count
    }
    
}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let modalExampleViewController = ModalExampleViewController()
            modalExampleViewController.title = options[indexPath.row].rawValue
            navigationController?.pushViewController(modalExampleViewController, animated: true)
        default: break
        }
    }
    
}
