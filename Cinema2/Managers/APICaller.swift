//
//  APICaller.swift
//  Cinema2
//
//  Created by BeeCon on 14/5/25.
//

import Foundation

class APIService {
    static let shared = APIService()
    private init() {}

    private let apiKey = "81841bfe25bc5b1f866036b1dea10af4"
    private let baseURL = "https://api.themoviedb.org/3"

    func fetchRecommendedMovies() async throws -> [Movie] {
        let urlString = "\(baseURL)/movie/popular?api_key=\(apiKey)&language=en-US&page=1"
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }

        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(MovieResponse.self, from: data)
        return response.results
    }
}

