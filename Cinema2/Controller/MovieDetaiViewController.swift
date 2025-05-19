//
//  MovieDetaiViewController.swift
//  Cinema2
//
//  Created by BeeCon on 9/5/25.
//

import UIKit

class MovieDetailViewController: UIViewController, CustomSegmentedControlDelegate {
    
    
    
    
    var movieImageName: String?
    var movieTitle: String?
    var movieDate: String?
    var movieDescription: String?
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    
    private let descriptionLabel = UILabel()
    
    private let trailerButton = UIButton(type: .system)
    
    private let viewModel = MovieListViewModel()
    
    let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        
        return view
    }()
    
    private let customBackButton: UIButton = {
        let button = UIButton(type: .system)
        //        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        let boldConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold)
        let image = UIImage(systemName: "arrow.backward", withConfiguration: boldConfig)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(white: 1, alpha: 0.3)
        button.layer.cornerRadius = 14
        button.clipsToBounds = true
        
        return button
    }()
    
    private let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        let boldConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold)
        let image = UIImage(systemName: "bookmark", withConfiguration: boldConfig)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(white: 1, alpha: 0.3)
        button.layer.cornerRadius = 14
        button.clipsToBounds = true
        
        return button
    }()
    
    let customSegment = CustomSegmentedControl()
    
    private let underlineView = UIView()

    func setupUnderline(for segmentedControl: UISegmentedControl) {
        underlineView.backgroundColor = .white
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addSubview(underlineView)
        
        // Lấy frame của segment đang chọn
        let segmentWidth = segmentedControl.bounds.width / CGFloat(segmentedControl.numberOfSegments)
        underlineView.frame = CGRect(
            x: CGFloat(segmentedControl.selectedSegmentIndex) * segmentWidth,
            y: segmentedControl.bounds.height - 2,
            width: segmentWidth,
            height: 2
        )
    }
    
    private let seeMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Читати далі", for: .normal) // "Xem thêm" tiếng Ukraina
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        
        return button
    }()

    private var isExpanded = false
    
    let ratingView = InteractiveRatingView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 22/255, green: 18/255, blue: 43/255, alpha: 1.0)
    
        customBackButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        navigationItem.hidesBackButton = true
        
        customSegment.titles = ["Опис", "Галерея", "Відгуки"]
        customSegment.delegate = self
        
        setupUI()
        loadData()
        
        
        
    }
    
    func segmentChanged(to index: Int) {
        switch index {
        case 0:
            descriptionLabel.isHidden = false
            seeMoreButton.isHidden = false
        case 1:
            descriptionLabel.isHidden = true
            seeMoreButton.isHidden = true
        default:
            descriptionLabel.isHidden = true
            seeMoreButton.isHidden = true
        }
    }
    
    private func setupUI() {
        
        view.addSubview(imageView)
        view.addSubview(overlayView)
        view.addSubview(customBackButton)
        view.addSubview(bookmarkButton)
        view.addSubview(titleLabel)
        view.addSubview(ratingView)
        view.addSubview(dateLabel)
        view.addSubview(customSegment)
        view.addSubview(descriptionLabel)
        view.addSubview(seeMoreButton)
        view.addSubview(trailerButton)
        
        view.bringSubviewToFront(customBackButton)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        customBackButton.translatesAutoresizingMaskIntoConstraints = false
        bookmarkButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        customSegment.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        seeMoreButton.translatesAutoresizingMaskIntoConstraints = false
        trailerButton.translatesAutoresizingMaskIntoConstraints = false
        
        overlayView.isUserInteractionEnabled = false
        
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        
        ratingView.rating = 4.5
        ratingView.onRatingChanged = { newRating in
            print("User selected rating: \(newRating)")
        }
        
        dateLabel.font = .systemFont(ofSize: 16)
        dateLabel.textColor = .gray
        dateLabel.numberOfLines = 0
        
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
        
        seeMoreButton.addTarget(self, action: #selector(toggleDescription), for: .touchUpInside)
        
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        
        trailerButton.setTitle("▶  Xem Trailer", for: .normal)
        trailerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        trailerButton.tintColor = .white
        trailerButton.backgroundColor = UIColor(white: 1, alpha: 0.1)
        trailerButton.layer.cornerRadius = 20
        trailerButton.addTarget(self, action: #selector(didTapTrailer), for: .touchUpInside)
        
        
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalToConstant: 370),
            
            overlayView.topAnchor.constraint(equalTo: imageView.topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            overlayView.heightAnchor.constraint(equalToConstant: 370),
            
            customBackButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 24),
            customBackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            customBackButton.widthAnchor.constraint(equalToConstant: 45),
            customBackButton.heightAnchor.constraint(equalToConstant: 45),
            
            bookmarkButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 24),
            bookmarkButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 45),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 45),
            
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            ratingView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 11),
            ratingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            ratingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ratingView.heightAnchor.constraint(equalToConstant: 20),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: ratingView.leadingAnchor, constant: 120),
//            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),
            
            customSegment.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 24),
            customSegment.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            customSegment.widthAnchor.constraint(equalToConstant: 315),
            customSegment.heightAnchor.constraint(equalToConstant: 40),
            
            descriptionLabel.topAnchor.constraint(equalTo: customSegment.bottomAnchor, constant: 24),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 120),
            
            seeMoreButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            seeMoreButton.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            
            trailerButton.topAnchor.constraint(equalTo: seeMoreButton.bottomAnchor, constant: 32),
            trailerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            trailerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            trailerButton.heightAnchor.constraint(equalToConstant: 68)
        ])
    }
    
    @objc func handleBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        let segmentWidth = sender.bounds.width / CGFloat(sender.numberOfSegments)
        let newX = CGFloat(sender.selectedSegmentIndex) * segmentWidth

        UIView.animate(withDuration: 0.3) {
            self.underlineView.frame.origin.x = newX
        }
    }
    
    @objc private func toggleDescription() {
        isExpanded.toggle()

        descriptionLabel.numberOfLines = isExpanded ? 0 : 3
        let buttonTitle = isExpanded ? "Згорнути" : "Читати далі" // Thu gọn / Xem thêm
        seeMoreButton.setTitle(buttonTitle, for: .normal)
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func didTapTrailer() {
        let alert = UIAlertController(title: "Xem Trailer", message: "Chức năng xem trailer đang được phát triển.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đóng", style: .cancel))
        present(alert, animated: true)
    }
    
    private func loadData() {
        // Load data vào các thành phần giao diện
        //        imageView.image = UIImage(named: movieImageName ?? "")
        
        if let imagePath = movieImageName,
           let url = URL(string: "https://image.tmdb.org/t/p/w500\(imagePath)") {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }.resume()
        }
        
        titleLabel.text = movieTitle
        dateLabel.text = movieDate
        
//        descriptionLabel.text = movieDescription
        if let description = movieDescription {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .justified
            paragraphStyle.lineBreakMode = .byWordWrapping

            let attributedText = NSAttributedString(
                string: description,
                attributes: [
                    .paragraphStyle: paragraphStyle,
                    .foregroundColor: UIColor.white,
                    .font: UIFont.systemFont(ofSize: 14)
                ]
            )

            descriptionLabel.attributedText = attributedText
        }
    }
    
    
    
}


