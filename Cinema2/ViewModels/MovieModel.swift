import Foundation

@MainActor
class MovieListViewModel: ObservableObject {
    @Published var movie1: [Movie] = []
    @Published var isLoading = false

    func loadMovies() async {
        isLoading = true
        do {
            movie1 = try await APIService.shared.fetchRecommendedMovies()
        } catch {
            print("Error loading movies: \(error)")
        }
        isLoading = false
    }
}
