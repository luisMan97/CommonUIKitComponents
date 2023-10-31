//
//  PopoverMenuViewController.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 28/12/22.
//

import UIKit

class PopoverMenuViewController: UIViewController {

    // MARK: - Private UI Properties

    private lazy var tableView = UITableView().then {
        let cell = UINib(nibName: "PopoverMenuTableViewCell", bundle: bundleForXib(type: PopoverMenuTableViewCell.self))
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = .clear
        $0.register(cell, forCellReuseIdentifier: "PopoverMenuTableViewCell")
        $0.tableFooterView = UIView()
    }

    // MARK: - Private Properties

    private var viewModel: PopoverMenuViewModelProtocol

    // MARK: - Initializers

    init(viewModel: PopoverMenuViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIViewController Lyfecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Private Methods

    private func addSubViews() {
        view.addSubview(tableView)
        addConstraints()
    }

    private func addConstraints() {
        tableView.fixInView(view)
    }

}

// MARK: - UITableViewDataSource
extension PopoverMenuViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        35
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PopoverMenuTableViewCell = tableView.reuse(at: indexPath)
        let isLast = indexPath.row + 1 == viewModel.numberOfItems
        cell.popoverMenuItem = viewModel.items[indexPath.row]
        cell.bottomViewHidde = isLast
        return cell
    }

}

// MARK: - UITableViewDelegate
extension PopoverMenuViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: false) {
            self.viewModel.callBack(indexPath.row)
        }
    }

}

