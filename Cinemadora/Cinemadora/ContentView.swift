//ContentView.swift
//  Cinemadora
//
//  Created by Bruno Cezario on 15/05/24.

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
    @State private var userEntry = UserDefaults.standard.string(forKey: "UserEntry") ?? ""
    @State private var userInputs: [UserInput] = []
    
    var movies: [Movie] = [
        Movie(title: "Barbie", description: "Tempo de Duração:1h54m", imageName: "barbie", absencePoints: 4, hasPostCreditScene: false, absenceDescriptions: [
            "3min! Uma cena de comédia leve que pode ser pulada sem perder a trama.",
            "4.35min! Um número musical que não adiciona muito à história principal.",
            "2min! Uma cena de flashback que reitera informações já conhecidas.",
            "2.30min! Uma pausa para mostrar a paisagem, sem diálogo importante."
        ], absenceTimes: ["00:30", "00:55", "01:10", "01:30"]),
        Movie(title: "Oppenheimer", description: "Tempo de Duração:3h0m", imageName: "oppenheimer", absencePoints: 2, hasPostCreditScene: false, absenceDescriptions: [
            "2.32min! Uma discussão técnica sobre física que pode ser difícil de seguir para leigos.",
            "3.43min! Uma cena de contemplação solitária do protagonista."
        ], absenceTimes: ["00:25", "01:40"]),
        Movie(title: "Fale Comigo", description: "Tempo de Duração:1h35m", imageName: "falecomigo", absencePoints: 4, hasPostCreditScene: false, absenceDescriptions: [
            "1.54min! Uma cena de construção de tensão com poucos diálogos.",
            "2.04min! Um momento de exploração em um ambiente escuro e misterioso.",
            "3.07min! Uma conversa paralela entre personagens secundários.",
            "2.33min! Uma montagem de cenas para estabelecer o clima de suspense."
        ], absenceTimes: ["00:20", "00:48", "01:25", "01:20"]),
        Movie(title: "Guerra Civil", description: "Tempo de Duração:1h54m", imageName: "guerracivil", absencePoints: 3, hasPostCreditScene: false, absenceDescriptions: [
            "3.03min! Uma cena de treinamento de personagens secundários.",
            "2.22min! Um momento de planejamento estratégico com pouca ação.",
            "3min! Uma cena de flashback explicando a origem de um personagem secundário."
        ], absenceTimes: ["00:25", "00:53", "01:47"]),
        Movie(title: "Abigail", description: "Tempo de Duração:1h49m", imageName: "abigail", absencePoints: 2, hasPostCreditScene: false, absenceDescriptions: [
            "4min! Uma cena de construção de mundo com muitos detalhes visuais, mas pouco diálogo.",
            "3.32min! Uma conversa lenta entre dois personagens sobre eventos passados."
        ], absenceTimes: ["00:35", "01:13"]),
        Movie(title: "Madame Teia", description: "Tempo de Duração:1h56m", imageName: "madameteia", absencePoints: 2, hasPostCreditScene: true, absenceDescriptions: [
            "3.31min! Uma cena de explicação científica sobre as habilidades da protagonista.",
            "3.02min! Um momento introspectivo onde a protagonista reflete sobre suas responsabilidades."
        ], absenceTimes: ["00:42", "01:38"]),
        Movie(title: "BeeKeeper", description: "Tempo de Duração:1h45m", imageName: "beekeeper", absencePoints: 3, hasPostCreditScene: false, absenceDescriptions: [
            "3.45min! Uma cena de apicultura detalhada, mostrando o processo, mas sem relevância para a trama.",
            "4min! Uma conversa entre vizinhos sobre eventos locais sem impacto direto na história.",
            "2.33min! Uma pausa para mostrar a natureza ao redor da colmeia."
        ], absenceTimes: ["00:20", "00:55", "01:20"]),
        Movie(title: "Meninas Malvadas", description: "Tempo de Duração:1h52m", imageName: "meninasmalvadas", absencePoints: 3, hasPostCreditScene: false, absenceDescriptions: [
            "1.54min! Uma cena de fofoca entre os estudantes que não adiciona muito à trama principal.",
            "3.38min! Um número musical durante uma festa escolar.",
            "3.25min! Um momento de reflexão da protagonista sobre sua popularidade na escola."
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
                                
                                Divider()
                                ScrollView{
                                ForEach(Array(zip(movie.absenceDescriptions.indices, movie.absenceDescriptions)), id: \.0) { index, description in
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text("Ponto de Ausência \(index + 1):")
                                                .fontWeight(.bold)
                                                .font(.header5)
                                                .foregroundColor(.douradoC)
                                            Text(movie.absenceTimes[index])
                                                .fontWeight(.bold)
                                                .font(.header5)
                                                .background(.red)
                                                .foregroundColor(.white)
                                                .cornerRadius(10)
                                        }
                                        Text(description)
                                            .multilineTextAlignment(.leading)
                                            .foregroundColor(.black)
                                            //.font(.header7)
                                            
                                            .fixedSize(horizontal: false, vertical: true)
                                            .padding(.bottom, 8)
                                            
                                    }.padding(.horizontal, 18)
                                    
                                }
                                    Divider()
                                    Spacer()
                                    
                                    VStack(alignment: .leading) {
                                        HStack{
                                            Text("Pontos de Ausência:")
                                                .fontWeight(.bold)
                                                .font(.header5)
                                                .foregroundColor(.douradoC)
                                            Text("Usuário")
                                                .fontWeight(.bold)
                                                .font(.header5)
                                                .background(.red)
                                                .foregroundColor(.white)
                                                .cornerRadius(10)
                                                .fixedSize(horizontal: false, vertical: true)
                                        }
                                        
                                        ForEach(Array(userInputs.filter { $0.movieID == movie.id }.enumerated()), id: \.element.id) { index, input in
                                            VStack(alignment: .leading){
                                                Text("Ponto de Ausência \(index + 1):")
                                                    .fontWeight(.bold)
                                                    .font(.header5)
                                                    .foregroundColor(.red)
                                                Text(input.absenceDescription)
                                                    .multilineTextAlignment(.leading)
                                                    .foregroundColor(.black)
                                                    //.font(.header7)
                                                   // .fixedSize(horizontal: false, vertical: true)
                                                    .padding(.bottom, 8)
                                            }
                                            .padding(.bottom, 2)
                                        }
                                    }
                                    .padding(.horizontal)
                                    .padding(.top, 16)
                                    
                                    Divider()
                                    Spacer()
                                    Text("Você achou algum outro ponto de ausência?")
                                        .foregroundColor(.black)
                                    Text("Conta pra gente!")
                                        .foregroundColor(.black)
                                    TextEditor(
                                        text: $userEntry
                                    )
                                    .font(.body)
                                    .frame(height: 80)
                                    .background(Color.cinza1.opacity(1))
                                    .padding()
                                    //.background(Color.gray.opacity(0.1))
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
            .toolbarBackground(Color.pretoC, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .foregroundColor(.white)
            .background(Color.pretoC)
            .background(Color.pretoC.edgesIgnoringSafeArea(.all))
        }
        //para recuperar feedbacks enviados pelo usuário

            }
        }

#Preview {
    ContentView()
}
