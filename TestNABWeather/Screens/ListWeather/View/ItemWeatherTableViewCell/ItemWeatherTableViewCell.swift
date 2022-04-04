//
//  ItemWeatherTableViewCell.swift
//  TestNABWeather
//
//  Created by tungphan on 31/03/2022.
//

import UIKit

class ItemWeatherTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAverageTemp: UILabel!
    @IBOutlet weak var lblPressure: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imvWeather: UIImageView!
    @IBOutlet var labelItems: [UILabel]!
    
    // MARK: - Variables
    
    var cellViewModel: ItemWeatherCellViewModel? {
        didSet {
            lblDate.text = "Date: \(cellViewModel?.date.stringFromDateFormat("EEE, dd MMM yyyy") ?? "")"
            lblAverageTemp.text = "Average Temperature: \(cellViewModel?.averageTemp ?? 0)\(cellViewModel?.nameTempUnit ?? "")"
            lblPressure.text = "Pressure: \(cellViewModel?.pressure ?? 0)"
            lblHumidity.text = "Humidity: \(cellViewModel?.humidity ?? 0)%"
            lblDescription.text = "Description: \(cellViewModel?.description ?? "")"
            if let url = URL(string: cellViewModel?.imageUrl ?? "") {
                imvWeather.loadImage(url: url)
            } else {
                imvWeather.image = cellViewModel?.mainWeather.imageWeather
            }
            labelItems.forEach {
                $0.font = UIFont.regular(size: CGFloat(cellViewModel?.fontSize ?? 14))
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
