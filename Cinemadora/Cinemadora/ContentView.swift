import SwiftUI

struct ContentView: View {
    @State var movie: String = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20.0) {
                    TextField(
                        "Pesquise o nome do filme",
                        text: $movie
                    )
                    .font(.body)
                    .padding()
                    .background(Color.cinza1)
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                    )
                    .multilineTextAlignment(.center)
                    
                    HStack {
                        Image(ImageResource.barbie)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 150)
                            .frame(maxWidth: 150)
                            .alignmentGuide(.leading) { _ in
                                0
                            }
                        
                        VStack(alignment: .leading){
                            Text("Barbie")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.douradoC)
                            Text("Tempo de Duração:1h54m")
                            Text("Pontos de Ausência: 4")
                            Text("Tem pós-créditos? Não!")
                        }
                    }
                    .alignmentGuide(.leading) { _ in
                        0
                    }
                    
                    HStack {
                        Image(ImageResource.oppenheimer)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 150)
                            .frame(maxWidth: 150)
                            .alignmentGuide(.leading) { _ in
                                0
                            }
                        
                    VStack(alignment: .leading){
                            Text("Oppenheimer")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.douradoC)
                            Text("Tempo de Duração:3h")
                            Text("Pontos de Ausência: 2")
                            Text("Tem pós-créditos? Não!")
                            
                        }
                    }
                    HStack {
                        Image(ImageResource.falecomigo)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 150)
                            .frame(maxWidth: 150)
                            .alignmentGuide(.leading) { _ in
                                0
                            }
                        
                    VStack(alignment: .leading){
                            Text("Fale Comigo")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.douradoC)
                            Text("Tempo de Duração:1h35m")
                            Text("Pontos de Ausência: 4")
                            Text("Tem pós-créditos? Não!")
                            
                        }
                    }
                    HStack {
                        Image(ImageResource.guerracivil)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 150)
                            .frame(maxWidth: 150)
                            .alignmentGuide(.leading) { _ in
                                0
                            }
                        
                    VStack(alignment: .leading){
                            Text("Guerra Civil")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.douradoC)
                            Text("Tempo de Duração:1h54m")
                            Text("Pontos de Ausência: 3")
                            Text("Tem pós-créditos? Não!")
                            
                        }
                    }
                    HStack {
                        Image(ImageResource.abigail)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 150)
                            .frame(maxWidth: 150)
                            .alignmentGuide(.leading) { _ in
                                0
                            }
                        
                    VStack(alignment: .leading){
                            Text("Abigail")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.douradoC)
                            Text("Tempo de Duração:1h49m")
                            Text("Pontos de Ausência: 3")
                            Text("Tem pós-créditos? Não!")
                            
                        }
                    }
                    HStack {
                        Image(ImageResource.madameteia)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 150)
                            .frame(maxWidth: 150)
                            .alignmentGuide(.leading) { _ in
                                0
                            }
                        
                    VStack(alignment: .leading){
                            Text("Madame Teia")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.douradoC)
                            Text("Tempo de Duração:1h56m")
                            Text("Pontos de Ausência: 2")
                            Text("Tem pós-créditos? Sim!")
                            
                        }
                    }
                    HStack {
                        Image(ImageResource.beekeeper)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 150)
                            .frame(maxWidth: 150)
                            .alignmentGuide(.leading) { _ in
                                0
                            }
                        
                    VStack(alignment: .leading){
                            Text("BeeKeeper")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.douradoC)
                            Text("Tempo de Duração:1h45m")
                            Text("Pontos de Ausência: 3")
                            Text("Tem pós-créditos? Não!")
                            
                        }
                    }
                    
                    HStack {
                        Image(ImageResource.meninasmalvadas)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 150)
                            .frame(maxWidth: 150)
                            .alignmentGuide(.leading) { _ in
                                0
                            }
                        
                    VStack(alignment: .leading){
                            Text("Meninas Malvadas")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.douradoC)
                            Text("Tempo de Duração:1h52m")
                            Text("Pontos de Ausência: 3")
                            Text("Tem pós-créditos? Não!")
                            
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
        
        //.padding()
    }
}


#Preview {
    ContentView()
}

