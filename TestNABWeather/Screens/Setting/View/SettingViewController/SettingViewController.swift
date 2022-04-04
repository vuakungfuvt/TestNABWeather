//
//  SettingViewController.swift
//  TestNABWeather
//
//  Created by tungphan on 01/04/2022.
//

import UIKit

let screenSize = UIScreen.main.bounds.size

protocol SettingViewControllerDelegate: AnyObject {
    func didUpdateFontSize(fontSize: Int)
    func didUpdateNumberCountDay(count: Int)
    func didUpdateTempUnit(tempUnit: UnitTemp)
}

class SettingViewController: UIViewController, XibViewController {

    // MARK: - Outlets
    @IBOutlet weak var widthContentViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var countDayView: SelectListView!
    @IBOutlet weak var tempTypeView: SelectListView!
    @IBOutlet weak var sliderTextSize: UISlider!
    @IBOutlet weak var lblCurrentTextSize: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    
    // MARK: - Variables
    var viewModel = SettingViewModel()
    weak var delegate: SettingViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        initData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5) {
            self.widthContentViewConstraint.constant = screenSize.width - 60
            self.view.layoutIfNeeded()
        } completion: { _ in
            
        }
    }
    
    func setupView() {
        self.widthContentViewConstraint.constant = 100
        sliderTextSize.minimumValue = 10
        sliderTextSize.maximumValue = 40
        sliderTextSize.value = Float(viewModel.setting?.fontSize ?? 0)
        
        countDayView.didSelectValue = { [weak self] value in
            guard let self = self else {
                return
            }
            let number = Int(value) ?? 7
            self.delegate?.didUpdateNumberCountDay(count: number)
        }
        
        tempTypeView.didSelectValue = { [weak self] value in
            guard let self = self else {
                return
            }
            self.delegate?.didUpdateTempUnit(tempUnit: UnitTemp(rawValue: value) ?? .Celsius)
        }
    }
    
    func setupViewModel() {
        viewModel.didUpdateFontSize = {
            self.lblCurrentTextSize.text = "Text size: \(self.viewModel.setting?.fontSize ?? 0)"
        }
    }
    
    func initData() {
        countDayView.viewModel = viewModel.createCountDayViewModel()
        tempTypeView.viewModel = viewModel.createTempTypeViewModel()
        self.lblCurrentTextSize.text = "Text size: \(self.viewModel.setting?.fontSize ?? 0)"
        setupViewModel()
    }
    
    // MARK: - Actions
    
    @IBAction func btnCloseTouchUpInside(_ sender: Any) {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5) {
            self.widthContentViewConstraint.constant = 100
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.dismiss(animated: false) {
                
            }
        }
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        viewModel.setTextSize(textSize: Int(sliderTextSize.value))
        delegate?.didUpdateFontSize(fontSize: self.viewModel.setting?.fontSize ?? 0)
    }
}
