//
//  DetailMovieImageView.swift
//  Cinema2
//
//  Created by BeeCon on 12/5/25.
//

import UIKit

class DetailMovieImageView: UIView {

    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let btnBack: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        btn.tintColor = .white
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        self.layer.cornerRadius = 30
//        self.clipsToBounds = true
//        self.backgroundColor = .black
        
        posterImageView.addSubview(posterImageView)
        btnBack.addSubview(btnBack)
        
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        btnBack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            btnBack.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            btnBack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            btnBack.widthAnchor.constraint(equalToConstant: 30),
            btnBack.heightAnchor.constraint(equalToConstant: 30)
            
        ])
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
