//
//  CustomMovieCollectionViewCell.swift
//  Cinema2
//
//  Created by BeeCon on 8/5/25.
//

import UIKit

class CustomMovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomMovieCollectionViewCell"
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    private let movieTitleLabel2: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    private let ratingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        return stackView
    }()
    
    
    
    
//Hàm khởi tạo khi k sử dụng storyboard
    override init(frame: CGRect) {
        super.init(frame: frame)
        
      //Thêm ảnh và tiêu đề vào cell
        
        contentView.addSubview(movieImageView)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(movieTitleLabel2)
        contentView.addSubview(ratingStackView)
        
        
        
        for _ in 0..<5 {
            let star = UIImageView()
            star.image = UIImage(named: "star.fill")
            star.tintColor = .systemYellow
            star.contentMode = .scaleAspectFit
            star.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
            ratingStackView.addArrangedSubview(star)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        movieImageView.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height - 40)
        movieTitleLabel.frame = CGRect(x: 0, y: contentView.frame.height - 40, width: contentView.frame.width, height: 40)
        movieTitleLabel2.frame = CGRect(x: 0, y: contentView.frame.height - 18, width: contentView.frame.width, height: 40)
        ratingStackView.frame = CGRect(x: 0, y: contentView.frame.height + 20, width: 100, height: 14)
        
        
    }
    

    
    func configure(with imageURL: String, title: String, title2: String) {
        // Tải ảnh từ URL
        if let url = URL(string: imageURL) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data {
                    DispatchQueue.main.async {
                        self.movieImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }

        movieTitleLabel.text = title
        movieTitleLabel2.text = title2
    }
    
    public func setRating(_ rating: Int) {
        for (index, view) in ratingStackView.arrangedSubviews.enumerated() {
            if let star = view as? UIImageView {
                star.image = UIImage(systemName: index < rating ? "star.fill" : "star")
            }
        }
    }
    
    
}
