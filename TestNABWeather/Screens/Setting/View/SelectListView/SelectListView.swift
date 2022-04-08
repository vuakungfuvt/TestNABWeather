//
//  SelectListView.swift
//  TestNABWeather
//
//  Created by tungphan on 01/04/2022.
//

import UIKit

class SelectListView: BaseNibView {

    // MARK: - Outlets
    @IBOutlet weak var lblCurrentValue: UILabel!
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightTableViewConstraint: NSLayoutConstraint!
    
    // MARK: - Variables
    var viewModel = SelectListViewModel(items: []) {
        didSet {
            self.lblCurrentValue.text = self.viewModel.currentItem
            viewModel.didSelectTableView = {
                self.reloadView()
            }
        }
    }
    var didSelectValue: ((_ value: String) -> Void)?

    override func setupViews() {
        tableView.registerNibCellFor(type: ItemSelectTableViewCell.self)
        tableView.set(delegateAndDataSource: self)
    }
    
    func reloadView() {
        self.showHideTableView(isShowed: false)
        self.tableView.reloadData()
        self.lblCurrentValue.text = self.viewModel.currentItem
        self.didSelectValue?(self.viewModel.currentItem)
    }
    
    // MARK: - Actions
    
    @IBAction func btnSelectTouchUpInside(_ sender: Any) {
        guard heightTableViewConstraint.constant == 0 else {
            return
        }
        showHideTableView(isShowed: true)
    }
    
    func showHideTableView(isShowed: Bool) {
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.2) {
            self.heightTableViewConstraint.constant = isShowed ? 90 : 0
            self.layoutIfNeeded()
        } completion: { _ in
            
        }
    }
    
}

extension SelectListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemCellViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.reusableCell(type: ItemSelectTableViewCell.self, indexPath: indexPath) else {
            return UITableViewCell()
        }
        let cellViewModel = viewModel.getCellViewModel(indexPath: indexPath)
        cell.cellViewModel = cellViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ItemSelectTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectTableView(indexPath: indexPath)
    }
}
