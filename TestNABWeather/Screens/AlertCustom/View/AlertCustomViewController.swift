//
//  AlertCustomViewController.swift
//  TestNABWeather
//
//  Created by tungphan on 02/04/2022.
//

import UIKit

class AlertCustomViewController: UIViewController, XibViewController {

    // MARK: - Outlets
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var btnOK: UIButton!
    @IBOutlet weak var widthContentViewConstraint: NSLayoutConstraint!
    
    // MARK: - Variables
    
    private var viewModel = AlertCustomViewModel(content: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        initData()
    }
    
    func setupViewModel(viewModel: AlertCustomViewModel) {
        self.viewModel = viewModel
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
        widthContentViewConstraint.constant = 60
    }
    
    func initData() {
        lblContent.text = viewModel.content
    }

    // MARK:  Actions
    
    @IBAction func btnOKTouchUpInside(_ sender: Any) {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5) {
            self.widthContentViewConstraint.constant = 0
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.dismiss(animated: false) {
                
            }
        }
    }
}
