import SwiftUI

struct Movie: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let imageName: String
    let absencePoints: Int
    let hasPostCreditScene: Bool
    let absenceDescriptions: [String]
    let absenceTimes: [String]
    
    var durationInMinutes: Int {
        let components = description.replacingOccurrences(of: "Tempo de Duração:", with: "").split(separator: "h")
        let hours = Int(components[0]) ?? 0
        let minutes = Int(components[1].replacingOccurrences(of: "m", with: "")) ?? 0
        return hours * 60 + minutes
    }
}

struct UserInput: Identifiable {
    let id = UUID()
    let movieID: UUID
    let absenceDescription: String
}

struct ContentView: View {
    @State private var searchText = ""
    @State private var selectedMovie: Movie? = nil
    @State private var showBottomSheet = false
    @State private var userEntry = ""
    @State private var userInputs: [UserInput] = []
    
    var movies: [Movie] = [
        Movie(title: "Barbie", description: "Tempo de Duração:1h54m", imageName: "barbie", absencePoints: 4, hasPostCreditScene: false, absenceDescriptions: [
            "Lorem ipsum dolor sit amet. Aut velit enim.",
            "Lorem ipsum dolor sit amet. Aut velit enim.",
            "Lorem ipsum dolor sit amet. Aut velit enim.",
            "Lorem ipsum dolor sit amet. Aut velit enim."
        ], absenceTimes: ["00:30", "00:45", "01:15", "01:30"]),
        Movie(title: "Oppenheimer", description: "Tempo de Duração:3h00m", imageName: "oppenheimer", absencePoints: 2, hasPostCreditScene: false, absenceDescriptions: [
            "Lorem ipsum dolor sit amet. Aut velit enim.",
            "Lorem ipsum dolor sit amet. Aut velit enim."
        ], absenceTimes: ["00:25", "01:40"]),
        Movie(title: "Fale Comigo", description: "Tempo de Duração:1h35m", imageName: "falecomigo", absencePoints: 4, hasPostCreditScene: false, absenceDescriptions: [
            "Lorem ipsum dolor sit amet. Aut velit enim.",
            "Lorem ipsum dolor sit amet. Aut velit enim.",
            "Lorem ipsum dolor sit amet. Aut velit enim.",
            "Lorem ipsum dolor sit amet. Aut velit enim."
        ], absenceTimes: ["00:20", "00:40", "01:00", "01:20"]),
        Movie(title: "Guerra Civil", description: "Tempo de Duração:1h54m", imageName: "guerracivil", absencePoints: 3, hasPostCreditScene: false, absenceDescriptions: [
            "Lorem ipsum dolor sit amet. Aut velit enim.",
            "Lorem ipsum dolor sit amet. Aut velit enim.",
            "Lorem ipsum dolor sit amet. Aut velit enim."
        ], absenceTimes: ["00:25", "00:50", "01:15"]),
        Movie(title: "Abigail", description: "Tempo de Duração:1h49m", imageName: "abigail", absencePoints: 2, hasPostCreditScene: false, absenceDescriptions: [
            "Lorem ipsum dolor sit amet. Aut velit enim.",
            "Lorem ipsum dolor sit amet. Aut velit enim."
        ], absenceTimes: ["00:35", "01:10"]),
        Movie(title: "Madame Teia", description: "Tempo de Duração:1h56m", imageName: "madameteia", absencePoints: 2, hasPostCreditScene: true, absenceDescriptions: [
            "Lorem ipsum dolor sit amet. Aut velit enim.",
            "Lorem ipsum dolor sit amet. Aut velit enim."
        ], absenceTimes: ["00:50", "01:30"]),
        Movie(title: "BeeKeeper", description: "Tempo de Duração:1h45m", imageName: "beekeeper", absencePoints: 3, hasPostCreditScene: false, absenceDescriptions: [
            "Lorem ipsum dolor sit amet. Aut velit enim.",
            "Lorem ipsum dolor sit amet. Aut velit enim.",
            "Lorem ipsum dolor sit amet. Aut velit enim."
        ], absenceTimes: ["00:25", "00:50", "01:15"]),
        Movie(title: "Meninas Malvadas", description: "Tempo de Duração:1h52m", imageName: "meninasmalvadas", absencePoints: 3, hasPostCreditScene: false, absenceDescriptions: [
            "Lorem ipsum dolor sit amet. Aut velit enim.",
            "Lorem ipsum dolor sit amet. Aut velit enim.",
            "Lorem ipsum dolor sit amet. Aut velit enim."
        ], absenceTimes: ["00:30", "01:00", "01:30"])
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
                        .foregroundStyle(Color.black)
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
                                HStack(){
                                    Text(movie.title)
                                        .font(.header2)
                                        .padding()
                                        .foregroundColor(.douradoC)
                                        //.multilineTextAlignment(.center)
//                                        .offset(x: 30)
                                        .frame(alignment: .topLeading)
                                    Spacer()
                                    Button{
                                        self.showBottomSheet.toggle()
                                    } label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .font(.body.bold())
//                                            .padding([.top, .trailing], 9)
                                            .foregroundStyle(.red)
                                            .imageScale(.large)
//                                            .mask(Circle())
//                                            .frame( alignment: .topTrailing)
                                            .offset(y: -16)
                                            .padding()
                                    }
                                }
//                                .background(.green)
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                Image(movie.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 200)
                                    .cornerRadius(12)
                                
                                BarChartView(duration: movie.durationInMinutes, absenceTimes: movie.absenceTimes)
                                    .padding(.horizontal)
                                    .padding(.bottom)
                                
                                ForEach(Array(zip(movie.absenceDescriptions.indices, movie.absenceDescriptions)), id: \.0) { index, description in
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text("Ponto de Ausência \(index + 1):")
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                            Text(movie.absenceTimes[index])
                                                .fontWeight(.bold)
                                                .font(.header5)
                                                .background(.red)
                                                .foregroundColor(.white)
                                                .cornerRadius(10)
                                        }
                                        Text(description)
                                            .foregroundColor(.black)
                                            .fixedSize(horizontal: false, vertical: true)
                                            .padding(.bottom, 8)
                                    }
                                    .padding(.horizontal)
                                }
     

                            
                       
                                
                                /*    // Mostrar entradas do usuário
                                    VStack(alignment: .leading) {
                                        Text("Entradas do Usuário:")
                                            .fontWeight(.bold)
                                            .foregroundColor(.black)
                                        ForEach(userInputs.filter { $0.movieID == movie.id }) { input in
                                            Text(input.absenceDescription)
                                                .foregroundColor(.black)
                                                .padding(.bottom, 2)
                                        }
                                    }
                                    .padding(.horizontal)
                                    .padding(.top, 16) */
                                
                                ScrollView {
                                    Text("Você achou algum outro ponto de ausência?")
                                        .foregroundColor(.black)
                                    Text("Conta pra gente!")
                                        .foregroundColor(.black)
                                    TextField(
                                        "",
                                        text: $userEntry
                                    )
                                    .font(.body)
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .foregroundStyle(Color.black)
                                    .cornerRadius(8)
                                    .overlay(RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray, lineWidth: 1)
                                    )
                                    .padding()
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            if let movie = selectedMovie, !userEntry.isEmpty {
                                                let newInput = UserInput(movieID: movie.id, absenceDescription: userEntry)
                                                userInputs.append(newInput)
                                                userEntry = ""
                                            }
                                        }) {
                                            Text("Enviar")
                                                .fontWeight(.bold)
                                                .padding()
                                                .background(Color.red)
                                                .foregroundColor(.white)
                                                .cornerRadius(8)
                                                .offset(y: -15)
                                                .offset(x: -30)
                                        }
                                    }
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
            .toolbarBackground(Color.black, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .foregroundColor(.white)
            .background(Color.black)
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
    }
}

#Preview {
    ContentView()
}
