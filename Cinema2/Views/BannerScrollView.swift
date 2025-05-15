//
//  bannerScrollView.swift
//  Cinema2
//
//  Created by BeeCon on 9/5/25.
//

import UIKit

class bannerScrollView: UIView {
    
    let bannerImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "banner"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 10/255, green: 48/255, blue: 104/255, alpha: 0.69)
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "-50% На сімейну підписку!"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        self.backgroundColor = .systemBlue
        
        addSubview(bannerImageView)
        addSubview(overlayView)
        addSubview(titleLabel)
        
        bannerImageView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Ảnh phủ toàn bộ UIView
            bannerImageView.topAnchor.constraint(equalTo: topAnchor),
            bannerImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bannerImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            //overlay
            overlayView.topAnchor.constraint(equalTo: topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // Label nằm giữa ảnh
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
