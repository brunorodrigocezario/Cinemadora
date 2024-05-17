//AQUI
//  ContentView.swift
//  Cinemadora
//
//  Created by Bruno Cezario on 15/05/24.
//

import SwiftUI

struct Movie: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let imageName: String
    let absencePoints: Int
    let hasPostCreditScene: Bool
}

struct ContentView: View {
    @State private var searchText = ""
    
    var movies: [Movie] = [
        Movie(title: "Barbie", description: "Tempo de Duração:1h54m", imageName: "barbie", absencePoints: 4, hasPostCreditScene: false),
        Movie(title: "Oppenheimer", description: "Tempo de Duração:3h", imageName: "oppenheimer", absencePoints: 2, hasPostCreditScene: false),
        Movie(title: "Fale Comigo", description: "Tempo de Duração:1h35m", imageName: "falecomigo", absencePoints: 4, hasPostCreditScene: false),
        Movie(title: "Guerra Civil", description: "Tempo de Duração: 1h54m", imageName: "guerracivil", absencePoints: 3, hasPostCreditScene: false),
        Movie(title: "Abigail", description: "Tempo de Duração:1h49m", imageName: "abigail", absencePoints: 2, hasPostCreditScene: false),
        Movie(title: "Madame Teia", description: "Tempo de Duração:1h56m", imageName: "madameteia", absencePoints: 2, hasPostCreditScene: true),
        Movie(title: "BeeKeeper", description: "Tempo de Duração:1h45m", imageName: "beekeeper", absencePoints: 3, hasPostCreditScene: false),
        Movie(title: "Meninas Malvadas", description: "Tempo de Duração:1h52m", imageName: "meninasmalvadas", absencePoints: 3, hasPostCreditScene: false)
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
            ScrollView {
                VStack(alignment: .leading, spacing: 20.0) {
                    TextField(
                        "Pesquise o nome do filme",
                        text: $searchText
                    )
                    .font(.body)
                    .padding()
                    .background(Color.cinza1)
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
                                .alignmentGuide(.leading) { _ in
                                    0
                                }
                            
                            VStack(alignment: .leading){
                                Text(movie.title)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.douradoC)
                                Text(movie.description)
                                Text("Pontos de Ausência: \(movie.absencePoints)")
                                Text("Tem pós-créditos? \(movie.hasPostCreditScene ? "Sim" : "Não")")

                                Button(action: {
                                    // abrir o pop-up
 
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
                        .alignmentGuide(.leading) { _ in
                            0
                        }
                    }
                }
                .padding()
                .ignoresSafeArea(edges: .top)
            }
            .navigationTitle("CINEMADORA")
            .scrollDismissesKeyboard(.immediately)
            .toolbarBackground(.pretoC, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .foregroundColor(.white)
            .background(Color.pretoC)
        }
    }
}

#Preview {
    ContentView()
}
