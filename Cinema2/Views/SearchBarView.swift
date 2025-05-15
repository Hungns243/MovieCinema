//
//  SearchBarView.swift
//  Cinema2
//
//  Created by BeeCon on 9/5/25.
//

import UIKit

class SearchBarView: UIView {

    let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logomovie"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let searchButton: UIButton = {
            let button = UIButton(type: .system)
            let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)
            let searchImage = UIImage(systemName: "magnifyingglass", withConfiguration: config)
            button.setImage(searchImage, for: .normal)
            button.tintColor = .white
            return button
        }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Optional: Bo góc + nền mờ như yêu cầu trước
//        self.backgroundColor = UIColor.white.withAlphaComponent(0.1)
//        self.layer.cornerRadius = 12
//        self.clipsToBounds = true
        
        addSubview(logoImageView)
        addSubview(searchButton)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 21),
            logoImageView.widthAnchor.constraint(equalToConstant: 130),
            
            searchButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchButton.heightAnchor.constraint(equalToConstant: 24),
            searchButton.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
