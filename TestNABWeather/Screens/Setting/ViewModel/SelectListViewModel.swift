//
//  SelectListViewModel.swift
//  TestNABWeather
//
//  Created by tungphan on 01/04/2022.
//

import UIKit

class SelectListViewModel: NSObject {
    
    var currentItem: String = ""
    
    fileprivate var items: [String] = [] {
        didSet {
            loadAllItemCellViewModels()
        }
    }
    
    var selectedIndex: Int = 0 {
        didSet {
            for index in 0 ..< itemCellViewModel.count {
                if index == selectedIndex {
                    self.itemCellViewModel[index].isSelected = true
                } else {
                    self.itemCellViewModel[index].isSelected = false
                }
            }
        }
    }
    
    var itemCellViewModel = [ItemSelectTableViewCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    var reloadTableView: (() -> Void)?
    var didSelectTableView: (() -> Void)?
    
    init(items: [String]) {
        super.init()
        self.items = items
        loadAllItemCellViewModels()
        self.selectedIndex = 0
    }
    
    func loadAllItemCellViewModels() {
        var viewModels = [ItemSelectTableViewCellViewModel]()
        self.items.forEach {
            let vm = ItemSelectTableViewCellViewModel(name: $0, isSelected: false)
            viewModels.append(vm)
        }
        self.itemCellViewModel = viewModels
        self.selectedIndex = 0
    }

    func getCellViewModel(indexPath: IndexPath) -> ItemSelectTableViewCellViewModel {
        return self.itemCellViewModel[indexPath.row]
    }
    
    func selectTableView(indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        self.currentItem = self.items[indexPath.row]
        self.didSelectTableView?()
    }
}
