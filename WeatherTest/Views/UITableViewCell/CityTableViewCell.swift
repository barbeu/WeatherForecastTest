//
//  CityTableViewCell.swift
//  WeatherTest
//
//  Created by Eugeniy on 13.08.2020.
//  Copyright © 2020 Eugeniy. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(18)
        return label
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(14)
        return label
    }()
    
    let forecastImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let forecastDescription: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(14)
        return label
    }()
    
    var forecast: Forecast? {
        didSet {
            cityLabel.text = forecast?.name
            
            temperatureLabel.text = "Температура \(forecast?.main?.temp ?? 0) ℃"
            forecastDescription.text = forecast?.weather?[0].description
            guard let icon = forecast?.weather?[0].icon else { return }
            forecastImageView.download(from: "https://openweathermap.org/img/wn/\(icon)@2x.png")
            
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.clipsToBounds = true
        
        addSubview(cityLabel)
        cityLabel.anchor(top: topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 16, left: 10, bottom: 0, right: 10))
        
        addSubview(temperatureLabel)
        temperatureLabel.anchor(top: cityLabel.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 14, left: 10, bottom: 0, right: 10))
        
        addSubview(forecastImageView)
        forecastImageView.anchor(top: temperatureLabel.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 10, bottom: 0, right: 0), size: .init(width: 40, height: 40))
        
        addSubview(forecastDescription)
        forecastDescription.anchor(top: nil, leading: forecastImageView.trailingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 0))
        forecastDescription.centerYAnchor.constraint(equalTo: forecastImageView.centerYAnchor).isActive = true
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
