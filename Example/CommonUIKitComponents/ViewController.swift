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
        case accordionView = "AccordionView"
        case alertView = "AlertView"
        case allowedCharsTextField = "AllowedCharsTextField"
        case buttonPadView = "ButtonPadView"
        case customPopoverMessage = "CustomPopoverMessage"
        case draggableModal = "DraggableModal"
        case indicator = "Indicator"
        case labelComponentView = "LabelComponentView"
        case modal = "Modal"
        case popoverMessage = "PopoverMessageView"
        case scrollView = "ScrollView"
        case sideView = "SideView"
        case stepperView = "StepperView"
        case textFieldOTP = "TextFieldOTP"
        case toggleView = "ToggleView"
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
            let uiTextFieldOTPExampleController = AccordionViewController()
            uiTextFieldOTPExampleController.title = options[indexPath.row].rawValue
            navigationController?.pushViewController(uiTextFieldOTPExampleController, animated: true)
        case 1:
            let alertViewExampleViewController = AlertViewExampleViewController()
            alertViewExampleViewController.title = options[indexPath.row].rawValue
            navigationController?.pushViewController(alertViewExampleViewController, animated: true)
        case 2:
            let alertViewExampleViewController = AllowedCharsTextFieldViewController()
            alertViewExampleViewController.title = options[indexPath.row].rawValue
            navigationController?.pushViewController(alertViewExampleViewController, animated: true)
        case 3:
            let alertViewExampleViewController = ButtonPadViewController()
            alertViewExampleViewController.title = options[indexPath.row].rawValue
            navigationController?.pushViewController(alertViewExampleViewController, animated: true)
        case 4:
            let alertViewExampleViewController = CustomPopoverMessageController()
            alertViewExampleViewController.title = options[indexPath.row].rawValue
            navigationController?.pushViewController(alertViewExampleViewController, animated: true)
        case 5:
            ModalTagsFactory.showModalTags(originController: self,
                                           tags: [.init(text: "Text",
                                                        descriptionTag: "Description tag")])
        case 6:
            let modalExampleViewController = IndicatorViewController()
            modalExampleViewController.title = options[indexPath.row].rawValue
            navigationController?.pushViewController(modalExampleViewController, animated: true)
        case 7:
            let modalExampleViewController = LabelComponentViewController()
            modalExampleViewController.title = options[indexPath.row].rawValue
            navigationController?.pushViewController(modalExampleViewController, animated: true)
        case 8:
            let modalExampleViewController = ModalExampleViewController()
            modalExampleViewController.title = options[indexPath.row].rawValue
            navigationController?.pushViewController(modalExampleViewController, animated: true)
        case 9:
            let modalExampleViewController = PopoverMessageViewController()
            modalExampleViewController.title = options[indexPath.row].rawValue
            navigationController?.pushViewController(modalExampleViewController, animated: true)
        case 10:
            let modalExampleViewController = ScrollViewController()
            modalExampleViewController.title = options[indexPath.row].rawValue
            navigationController?.pushViewController(modalExampleViewController, animated: true)
        case 11:
            let modalExampleViewController = SideViewController()
            modalExampleViewController.title = options[indexPath.row].rawValue
            navigationController?.pushViewController(modalExampleViewController, animated: true)
        case 12:
            let uiTextFieldOTPExampleController = StepperViewController()
            uiTextFieldOTPExampleController.title = options[indexPath.row].rawValue
            navigationController?.pushViewController(uiTextFieldOTPExampleController, animated: true)
        case 13:
            let uiTextFieldOTPExampleController = UITextFieldOTPExampleController()
            uiTextFieldOTPExampleController.title = options[indexPath.row].rawValue
            navigationController?.pushViewController(uiTextFieldOTPExampleController, animated: true)
        case 14:
            let uiTextFieldOTPExampleController = ToggleViewController()
            uiTextFieldOTPExampleController.title = options[indexPath.row].rawValue
            navigationController?.pushViewController(uiTextFieldOTPExampleController, animated: true)
        default: break
        }
    }

}
