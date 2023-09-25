//
//  ContentView.swift
//  MovieRating
//
//  Created by HA JUNSEO on 9/23/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel(startingIndex: 0)
    @State private var currentRating: Int? = nil
    @State private var showingRatingsView: Bool = false

    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)

            VStack {
                // Movie Info
                Text(viewModel.currentMovie.title)
                    .font(.largeTitle)
                    .padding()

                Text(viewModel.currentMovie.year)
                    .font(.headline)

                Image(viewModel.currentMovie.image) // Assuming you have these images in Assets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)

                Text(viewModel.currentMovie.description)
                    .frame(height: 200)
                    .padding()

                // Rating System
                HStack {
                    ForEach(1..<6) { starIndex in
                        Image(systemName: (currentRating ?? 0) >= starIndex ? "star.fill" : "star")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .onTapGesture {
                                currentRating = starIndex
                            }
                    }
                }

                Button("Next Movie") {
                    if let rating = currentRating {
                        var movie = viewModel.currentMovie
                        movie.rating = rating
                        viewModel.ratings.append(movie)
                    }
                    viewModel.getNextMovie()
                    currentRating = nil
                }
                .padding()
                .bold()
                .foregroundColor(.white)

                Button("View Ratings") {
                    showingRatingsView.toggle()
                }
                .padding()
                .foregroundColor(.white)
                .bold()
                .sheet(isPresented: $showingRatingsView) {
                    RatingsView(ratings: viewModel.ratings)
                }
            }
        }
    }
}

struct RatingsView: View {
    var ratings: [Movie]

    var body: some View {
        ScrollView {
            // Check if ratings array is empty
            if ratings.isEmpty {
                Text("There's no rated movies to be shown.")
                    .padding()
                    .font(.headline)
                    .foregroundColor(.gray)
            } else {
                ForEach(ratings) { movie in
                    VStack() {
                        Text(movie.title).font(.headline)
                        Text(movie.year).font(.subheadline)
                        Image(movie.image).resizable().scaledToFit().frame(height: 150)
                        Text("Rating: \(movie.rating ?? 0) stars").font(.caption)
                    }
                    .padding()
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
