//
//  CustomRatingView.swift
//  Cinema2
//
//  Created by BeeCon on 18/5/25.
//


import UIKit

class InteractiveRatingView: UIView {
    
    private var starImageViews: [UIImageView] = []
    private let maxRating: Float = 5.0
    var starSize: CGSize = CGSize(width: 14, height: 14)
    var spacing: CGFloat = 6

    // Callback khi người dùng chọn rating
    var onRatingChanged: ((Float) -> Void)?

    var rating: Float = 0 {
        didSet {
            updateStars()
            onRatingChanged?(rating)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStars()
        setupGesture()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStars()
        setupGesture()
    }

    private func setupStars() {
        for _ in 0..<Int(maxRating) {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = .systemYellow
            imageView.translatesAutoresizingMaskIntoConstraints = false
            starImageViews.append(imageView)
            addSubview(imageView)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        for (index, imageView) in starImageViews.enumerated() {
            let x = CGFloat(index) * (starSize.width + spacing)
            imageView.frame = CGRect(x: x, y: 0, width: starSize.width, height: starSize.height)
        }
    }

    private func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }

    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self)
        
        for (index, imageView) in starImageViews.enumerated() {
            if location.x < imageView.frame.maxX {
                let halfStarThreshold = imageView.frame.minX + imageView.frame.width / 2
                if location.x < halfStarThreshold {
                    rating = Float(index) + 0.5
                } else {
                    rating = Float(index) + 1.0
                }
                return
            }
        }
        
        rating = maxRating
    }

    private func updateStars() {
        for (index, imageView) in starImageViews.enumerated() {
            let starValue = Float(index) + 1
            if rating >= starValue {
                imageView.image = UIImage(systemName: "star.fill")
            } else if rating >= starValue - 0.5 {
                imageView.image = UIImage(systemName: "star.leadinghalf.filled")
            } else {
                imageView.image = UIImage(systemName: "star")
            }
        }
    }
}
