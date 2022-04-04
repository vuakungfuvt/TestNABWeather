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
    static let heightCell: CGFloat = 35

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
