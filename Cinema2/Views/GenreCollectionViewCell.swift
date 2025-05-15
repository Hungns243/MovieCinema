//
//  GenreCollectionViewCell.swift
//  Cinema2
//
//  Created by BeeCon on 9/5/25.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "GenreCollectionViewCell"
    
    private let genreImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //Hàm khởi tạo khi k sử dụng storyboard
        override init(frame: CGRect) {
            super.init(frame: frame)
            
          //Thêm ảnh và tiêu đề vào cell
            
            contentView.addSubview(genreImageView)
            contentView.addSubview(genreLabel)
            applyConstraints()
           
        }
        
        required init?(coder: NSCoder) {
            fatalError()
        }
        
    private func applyConstraints() {
            NSLayoutConstraint.activate([
                // Genre image view ở giữa theo chiều ngang, cách top 8pt
                genreImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                genreImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                genreImageView.widthAnchor.constraint(equalToConstant: 32),
                genreImageView.heightAnchor.constraint(equalToConstant: 32),
                
                // Genre label ở dưới image view, canh giữa
                genreLabel.topAnchor.constraint(equalTo: genreImageView.bottomAnchor, constant: 8),
                genreLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            ])
        }
        
        func configure2(with imageName2: String, genre: String) {
            
            genreImageView.image = UIImage(named: imageName2)
            genreLabel.text = genre
        }
}
