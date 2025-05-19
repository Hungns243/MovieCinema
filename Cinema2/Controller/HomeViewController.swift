



import UIKit



class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    private let recommendedLabel: UILabel = {
        let label = UILabel()
        label.text = "Phim đề cử"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    private let latestLabel: UILabel = {
        let label = UILabel()
        label.text = "Phim mới nhất"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    private let recommendedCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 211)
        layout.minimumLineSpacing = 30
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return collectionView
    }()
    
    private let latestCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 82, height: 82)
        layout.minimumLineSpacing = 30
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return collectionView
    }()
    
//    private let movies: [(imageName: String, title: String, title2: String)] = [
//        ("movie1", "Avenger", "Endgame"),
//        ("movie2", "Inception", "2010"),
//        ("movie3", "The Dark Knight", "Rises"),
//        ("movie1", "The Lion King", "2019"),
//        ("movie2", "Spiderman", "No Way Home")
//    ]
    
    private let genres: [(imageName2: String, genre: String)] = [
        ("genre", "Action"),
        ("genre1", "Action1"),
        ("genre2", "Action2"),
        ("genre", "Action1"),
        ("genre1", "Action1")
    ]
    
    private let viewModel = MovieListViewModel()
    
    let searchBarView = SearchBarView()
    let bannerView = bannerScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 22/255, green: 18/255, blue: 43/255, alpha: 1.0)
        
        Task {
            await viewModel.loadMovies()
            recommendedCollectionView.reloadData()
        }
        
        // Register cell
        recommendedCollectionView.register(CustomMovieCollectionViewCell.self, forCellWithReuseIdentifier: CustomMovieCollectionViewCell.identifier)
        latestCollectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: GenreCollectionViewCell.identifier)
        
        recommendedCollectionView.delegate = self
        recommendedCollectionView.dataSource = self
        latestCollectionView.delegate = self
        latestCollectionView.dataSource = self
        
        // Add subviews
        view.addSubview(recommendedLabel)
        view.addSubview(recommendedCollectionView)
        view.addSubview(latestLabel)
        view.addSubview(latestCollectionView)
        view.addSubview(searchBarView)
        view.addSubview(bannerView)
        
        applyConstraints()
        
    }
    
    private func applyConstraints() {
        
        recommendedLabel.translatesAutoresizingMaskIntoConstraints = false
        recommendedCollectionView.translatesAutoresizingMaskIntoConstraints = false
        latestLabel.translatesAutoresizingMaskIntoConstraints = false
        latestCollectionView.translatesAutoresizingMaskIntoConstraints = false
        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            searchBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            searchBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchBarView.heightAnchor.constraint(equalToConstant: 24),
            
            bannerView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 32),
            bannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bannerView.heightAnchor.constraint(equalToConstant: 130),
            
            recommendedLabel.topAnchor.constraint(greaterThanOrEqualTo: bannerView.bottomAnchor, constant: 32),
            recommendedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            recommendedLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            recommendedCollectionView.topAnchor.constraint(equalTo: recommendedLabel.bottomAnchor, constant: -20),
            recommendedCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            recommendedCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            recommendedCollectionView.heightAnchor.constraint(equalToConstant: 280),
            
            latestLabel.topAnchor.constraint(equalTo: recommendedCollectionView.bottomAnchor, constant: 24),
            latestLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            latestLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            latestCollectionView.topAnchor.constraint(equalTo: latestLabel.bottomAnchor, constant: 0),
            latestCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            latestCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            latestCollectionView.heightAnchor.constraint(equalToConstant: 110)
            
        ])
    }
    

    // MARK: CollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == recommendedCollectionView {
            return viewModel.movie1.count
        } else {
            return genres.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == recommendedCollectionView {
            let movie = viewModel.movie1[indexPath.row]
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomMovieCollectionViewCell.identifier, for: indexPath) as? CustomMovieCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(
                    with: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")",
                    title: movie.title,
                    title2: movie.release_date
                )
            cell.setRating(4)
            cell.backgroundColor = .clear
            return cell
        } else {
            
            let genre = genres[indexPath.row]
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.identifier, for: indexPath) as? GenreCollectionViewCell else {
                
                return UICollectionViewCell()
            }
            cell.configure2(with: genre.imageName2, genre: genre.genre)
            cell.backgroundColor = UIColor(white: 1, alpha: 0.1)
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 20
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == recommendedCollectionView {
            
            let movie = viewModel.movie1[indexPath.row]
            let detailVC = MovieDetailViewController()
            
            detailVC.movieImageName = "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")"
            detailVC.movieTitle = movie.title
            detailVC.movieDate = movie.release_date
            detailVC.movieDescription = movie.overview
            
//            detailVC.movieImageName = movie.imageName
//            detailVC.movieTitle = movie.title
//            detailVC.movieDescription = movie.title2
            
            //ẩn tabbar bên moviedetail
            detailVC.hidesBottomBarWhenPushed = true
            
            navigationController?.pushViewController(detailVC, animated: true)
            
        }
    }

}

