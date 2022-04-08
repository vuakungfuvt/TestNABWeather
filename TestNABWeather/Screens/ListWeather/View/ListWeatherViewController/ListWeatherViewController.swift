//
//  ListWeatherViewController.swift
//  TestNABWeather
//
//  Created by tungphan on 31/03/2022.
//

import UIKit
import IQKeyboardManagerSwift

class ListWeatherViewController: UIViewController, XibViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnSetting: UIButton!
    
    // MARK: - Variables
    private var viewModel: ListWeatherViewModel!
    fileprivate var searchedString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        initData()
        bindViewModel()
    }
    
    func setupViewModel(viewModel: ListWeatherViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Actions
    
    @IBAction func btnCancelTouchUpInside(_ sender: Any) {
        tfSearch.text = ""
        tfSearch.resignFirstResponder()
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        searchedString = textField.text ?? ""
        guard searchedString.count >= 3 else {
            return
        }
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(searchCity), object: nil)
        perform(#selector(searchCity), with: nil, afterDelay: 1)
    }
    
    @IBAction func btnSettingTouchUpInside(_ sender: Any) {
        let viewModel = SettingViewModel()
        tfSearch.resignFirstResponder()
        SettingViewController.present(from: self, animated: false) { vc in
            vc.modalPresentationStyle = .overFullScreen
            vc.delegate = self
            vc.setupViewModel(viewModel: viewModel)
        } completion: {
            
        }
    }
    
    // MARK: - Util
    
    @objc func searchCity() {
        viewModel.getCityEntity(q: searchedString)
        self.showLoading()
    }

}

// MARK: - UITableViewDataSource + UITableViewDelegate

extension ListWeatherViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemWeatherCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.reusableCell(type: ItemWeatherTableViewCell.self, indexPath: indexPath) else {
            return UITableViewCell()
        }
        let cellViewModel = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - SettingViewControllerDelegate

extension ListWeatherViewController: SettingViewControllerDelegate {
    func didUpdateFontSize(fontSize: Int) {
        self.viewModel.updatefontSize(fontSize: fontSize)
    }
    
    func didUpdateNumberCountDay(count: Int) {
        self.viewModel.updateNumberCountDay(count: count)
    }
    
    func didUpdateTempUnit(tempUnit: UnitTemp) {
        self.viewModel.updateTempUnit(tempUnit: tempUnit)
    }
    
}

extension ListWeatherViewController: NABViewControllerViewModel {
    func bindViewModel() {
        viewModel.reloadDataTableView = { [weak self] in
            self?.tableView.reloadData()
            self?.tableView.pauseRefressh()
            self?.hideLoading()
        }
        viewModel.loadErrorContent = { [weak self] errorContent in
            self?.showError(errorContent: errorContent )
            self?.tableView.pauseRefressh()
            self?.hideLoading()
        }
    }
    
    func setupView() {
        self.navigationController?.isNavigationBarHidden = true
        tableView.registerNibCellFor(type: ItemWeatherTableViewCell.self)
        tableView.set(delegateAndDataSource: self)
        tfSearch.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        tableView.addPullRefresh {
            self.searchCity()
        }
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
    func initData() {
        viewModel.loadLocal()
        tfSearch.text = "saigon"
        self.searchedString = "saigon"
        searchCity()
    }
}
