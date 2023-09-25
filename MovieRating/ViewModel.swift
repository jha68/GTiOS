//
//  ViewModel.swift
//  MovieRatings
//
//  Created by Nicholas Candello on 9/20/23.
//

import Foundation

class ViewModel: ObservableObject {
    var currentMovieIndex: Int
    @Published var currentMovie: Movie
    @Published var ratings: [Movie] = []
    
    init(startingIndex: Int) {
        currentMovieIndex = startingIndex
        currentMovie = Movie.allMovies[startingIndex]
    }
    
    func getNextMovie() {
        currentMovieIndex = (currentMovieIndex == (Movie.allMovies.count - 1) ? 0 : (currentMovieIndex+1))
        
        currentMovie = Movie.allMovies[currentMovieIndex]
    }
}
