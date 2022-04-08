//
//  ItemSelectTableViewCell.swift
//  TestNABWeather
//
//  Created by tungphan on 01/04/2022.
//

import UIKit

class ItemSelectTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var imvSelection: UIImageView!
    
    // MARK: - Variables
    var cellViewModel: ItemSelectTableViewCellViewModel? {
        didSet {
            lblItemName.text = cellViewModel?.name
            imvSelection.isHidden = !(cellViewModel?.isSelected ?? false)
        }
    }
    static let height: CGFloat = 35
}
