//
//  SettingViewModel.swift
//  TestNABWeather
//
//  Created by tungphan on 01/04/2022.
//

import UIKit

class SettingViewModel: NSObject {
    
    var setting = Configuration.shared.setting
    
    var didUpdateFontSize: (() -> Void)?

    override init() {
        
    }
    
    func setTextSize(textSize: Int) {
        Configuration.shared.setting.fontSize = textSize
        self.setting?.fontSize = textSize
        didUpdateFontSize?()
    }
    
    func createCountDayViewModel() -> SelectListViewModel {
        let items = ["7", "10", "15", "20"]
        let countDayViewModel = SelectListViewModel(items: items)
        let currentItem = "\(self.setting?.countDay ?? 7)"
        countDayViewModel.currentItem = currentItem
        countDayViewModel.selectedIndex = items.firstIndex { $0 == currentItem } ?? 0
        return countDayViewModel
    }
    
    func createTempTypeViewModel() -> SelectListViewModel {
        let tempTypes: [UnitTemp] = [.Celsius, .Fahrenheit, .Kelvin]
        let tempTypeViewModel = SelectListViewModel(items: tempTypes.compactMap { $0.rawValue })
        tempTypeViewModel.currentItem = "\(self.setting?.unitTemp ?? "")"
        tempTypeViewModel.selectedIndex = tempTypes.firstIndex { $0.rawValue == setting?.unitTemp } ?? 0
        return tempTypeViewModel
    }
}
