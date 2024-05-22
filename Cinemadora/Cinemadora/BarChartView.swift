import SwiftUI

struct BarChartView: View {
    let duration: Int
    let absenceTimes: [String]
    
    func timeStringToMinutes(_ timeString: String) -> Int {
        let components = timeString.split(separator: ":").map { Int($0) ?? 0 }
        return components[0] * 60 + components[1]
    }
    
    var body: some View {
        GeometryReader { geometry in
            let totalWidth = geometry.size.width
            let totalHeight: CGFloat = 40
            let durationInSeconds = duration * 60
            let absenceMarkers = absenceTimes.map { timeStringToMinutes($0) * 60 }
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: totalHeight)
                  //  .padding(.bottom, 16)
                
                ForEach(absenceMarkers, id: \.self) { marker in
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 12, height: totalHeight)
                        .offset(x: CGFloat(marker) / CGFloat(durationInSeconds) * totalWidth)
                   //     .padding(.bottom, 16)
                }
            }
        }
        .frame(height: 20)
    }
}
