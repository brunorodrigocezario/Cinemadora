//  ContentView.swift
//  Cinemadora
//
//  Created by Bruno Cezario on 15/05/24.
//https://stackoverflow.com/questions/77575569/how-to-make-1d-bar-chart-fill-up-entire-width-in-swiftui


import SwiftUI

struct Movie: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let imageName: String
    let absencePoints: Int
    let hasPostCreditScene: Bool
    let absenceDescriptions: [String]
}

struct ContentView: View {
    @State private var searchText = ""
    @State private var selectedMovie: Movie? = nil
    @State private var showBottomSheet = false
    
    var movies: [Movie] = [
        Movie(title: "Barbie", description: "Tempo de Duração:1h54m", imageName: "barbie", absencePoints: 4, hasPostCreditScene: false, absenceDescriptions: [
            "Lorem ipsum dolor sit amet. Aut velit enim.",
            "Lorem ipsum dolor sit amet. Aut velit enim.",
            "Lorem ipsum dolor sit amet. Aut velit enim.",
            "Lorem ipsum dolor sit amet. Aut velit enim."
        ]),
        Movie(title: "Oppenheimer", description: "Tempo de Duração:3h", imageName: "oppenheimer", absencePoints: 2, hasPostCreditScene: false, absenceDescriptions: [
            "Lorem ipsum dolor sit amet. Aut velit enim.",
            "Lorem ipsum dolor sit amet. Aut velit enim."
        ]),
        Movie(title: "Fale Comigo", description: "Tempo de Duração:1h35m", imageName: "falecomigo", absencePoints: 4, hasPostCreditScene: false, absenceDescriptions: [
            "Lorem ipsum dolor sit amet. Aut velit enim.",
            "Lorem ipsum dolor sit amet. Aut velit enim.",
            "Lorem ipsum dolor sit amet. Aut velit enim.",
            "Lorem ipsum dolor sit amet. Aut velit enim."
        ]),
        Movie(title: "Guerra Civil", description: "Tempo de Duração: 1h54m", imageName: "guerracivil", absencePoints: 3, hasPostCreditScene: false, absenceDescriptions: [
            "Lorem ipsum dolor sit amet. Aut velit enim.",
            "Lorem ipsum dolor sit amet. Aut velit enim.",
            "Lorem ipsum dolor sit amet. Aut velit enim."
        ]),
        Movie(title: "Abigail", description: "Tempo de Duração:1h49m", imageName: "abigail", absencePoints: 2, hasPostCreditScene: false, absenceDescriptions: [
            "Lorem ipsum dolor sit amet. Aut velit enim.",
            "Lorem ipsum dolor sit amet. Aut velit enim."
        ]),
        Movie(title: "Madame Teia", description: "Tempo de Duração:1h56m", imageName: "madameteia", absencePoints: 2, hasPostCreditScene: true, absenceDescriptions: [
            "Lorem ipsum dolor sit amet. Aut velit enim.",
            "Lorem ipsum dolor sit amet. Aut velit enim."
        ]),
        Movie(title: "BeeKeeper", description: "Tempo de Duração:1h45m", imageName: "beekeeper", absencePoints: 3, hasPostCreditScene: false, absenceDescriptions: [
            "Lorem ipsum dolor sit amet. Aut velit enim.",
            "Lorem ipsum dolor sit amet. Aut velit enim.",
            "Lorem ipsum dolor sit amet. Aut velit enim."
        ]),
        Movie(title: "Meninas Malvadas", description: "Tempo de Duração:1h52m", imageName: "meninasmalvadas", absencePoints: 3, hasPostCreditScene: false, absenceDescriptions: [
            "Lorem ipsum dolor sit amet. Aut velit enim.",
            "Lorem ipsum dolor sit amet. Aut velit enim.",
            "Lorem ipsum dolor sit amet. Aut velit enim."
        ])
    ]
    
    var filteredMovies: [Movie] {
        if searchText.isEmpty {
            return movies
        } else {
            return movies.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20.0) {
                        TextField(
                            "Pesquise o nome do filme",
                            text: $searchText
                        )
                        .font(.body)
                        .padding()
                        .background(Color.cinza1.opacity(1))
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                        )
                        .multilineTextAlignment(.center)
                        
                        ForEach(filteredMovies) { movie in
                            HStack {
                                Image(movie.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxHeight: 150)
                                    .frame(maxWidth: 150)
                                
                                VStack(alignment: .leading) {
                                    Text(movie.title)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.douradoC)
                                    Text(movie.description)
                                    Text("Pontos de Ausência: \(movie.absencePoints)")
                                    Text("Tem pós-créditos? \(movie.hasPostCreditScene ? "Sim" : "Não")")
                                    
                                    Button(action: {
                                        self.selectedMovie = movie
                                        self.showBottomSheet.toggle()
                                    }) {
                                        Text("Calcular Ausências")
                                            .fontWeight(.bold)
                                            .padding()
                                            .background(Color.douradoC)
                                            .foregroundColor(.black)
                                            .cornerRadius(8)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color.pretoC.edgesIgnoringSafeArea(.all))
                }
                
                if showBottomSheet {
                    BottomSheetView(maxHeight: UIScreen.main.bounds.height, minHeight: 100, movie: selectedMovie) {
                        VStack(spacing: 16) {
                            if let movie = selectedMovie {
                                Text(movie.title)
                                    .font(.headline)
                                    .padding()
                                    .colorInvert()
                                
                                Image(movie.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 200)
                                    .cornerRadius(12)
                                
                                VStack(alignment: .leading, spacing: 20){                                ForEach(Array(movie.absenceDescriptions.enumerated()), id: \.offset) { index, description in
                                    Text("Ponto de Ausência \(index + 1):\n \(description)")
                                        .padding()
                                        .colorInvert()
                                }
                                }
                                
                                Button(action: {
                                    self.showBottomSheet.toggle()
                                }) {
                                    Text("Fechar")
                                        .fontWeight(.bold)
                                        .padding()
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                            }
                        }
                        .padding()
                    }
                    .edgesIgnoringSafeArea(.all)
                }
            }
            .navigationTitle("CINEMADORA")
            .scrollDismissesKeyboard(.immediately)
            .toolbarBackground(Color.pretoC, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .foregroundColor(.white)
            .background(Color.pretoC)
            .background(Color.pretoC.edgesIgnoringSafeArea(.all))
        }
    }
}

#Preview {
    ContentView()
}
