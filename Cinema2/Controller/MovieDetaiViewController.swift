//
//  MovieDetaiViewController.swift
//  Cinema2
//
//  Created by BeeCon on 9/5/25.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movieImageName: String?
    var movieTitle: String?
    var movieDescription: String?
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
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
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.tintColor = .white
//        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        button.backgroundColor = UIColor(white: 1, alpha: 0.3)
        button.layer.cornerRadius = 14
        button.clipsToBounds = true
        
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.086, green: 0.070, blue: 0.169, alpha: 1.0)
        
        
        
//      backButton
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: customBackButton)
        customBackButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        navigationItem.hidesBackButton = true
        
        setupUI()
        loadData()
        
        
       
    }
    
    private func setupUI() {
        
        view.addSubview(imageView)
        view.addSubview(overlayView)
        view.addSubview(customBackButton)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(trailerButton)
        
        view.bringSubviewToFront(customBackButton)
        
        
        
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        customBackButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        trailerButton.translatesAutoresizingMaskIntoConstraints = false
        
        overlayView.isUserInteractionEnabled = false
        
        
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
        
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        
        trailerButton.setTitle("▶ Xem Trailer", for: .normal)
        trailerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        trailerButton.tintColor = .white
        trailerButton.backgroundColor = UIColor.systemRed
        trailerButton.layer.cornerRadius = 10
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
            
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            trailerButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            trailerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            trailerButton.widthAnchor.constraint(equalToConstant: 180),
            trailerButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc func handleBack() {
        navigationController?.popViewController(animated: true)
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
        descriptionLabel.text = movieDescription
        
//        
    }
    
    
    
//    @objc func trailerButtonTapped() {
//        if let urlString = trailerURL, let url = URL(string: urlString) {
//            UIApplication.shared.open(url)
//        }
//    }

    
 
}
