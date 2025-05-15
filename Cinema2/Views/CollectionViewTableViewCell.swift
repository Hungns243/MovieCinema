//
//  CollectionViewTableViewCell.swift
//  Cinema2
//
//  Created by BeeCon on 7/5/25.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {

   static let identifier = "CollectionViewTableViewCell"
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 146, height: 211)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CustomMovieCollectionViewCell.self, forCellWithReuseIdentifier: CustomMovieCollectionViewCell.identifier)
        collectionView.backgroundColor = .black
        return collectionView
    }()
    
    private let movies: [(imageName: String, title: String, title2: String)] = [
        ("movie1", "Avenger", "Endgame"),
        ("movie2", "Inception", "2010"),
        ("movie3", "The Dark Knight", "Rises"),
        ("movie1", "The Lion King", "2019"),
        ("movie2", "Spiderman", "No Way Home")
    ]
        
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
//        collectionView.backgroundColor = .black
    }
    
}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomMovieCollectionViewCell.identifier, for: indexPath) as? CustomMovieCollectionViewCell else {
            
            
            return UICollectionViewCell()
        }
        let movie = movies[indexPath.row]
        cell.configure(with: movie.imageName, title: movie.title, title2: movie.title2)
        cell.setRating(4)
        
        
        return cell
        
    }
    
    
    //set thanh 5 item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
}
