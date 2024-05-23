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
                
                ForEach(Array(absenceMarkers.enumerated()), id: \.0) { index, marker in
                    VStack {
                        Rectangle()
                            .fill(Color.red)
                            .frame(width: 12, height: totalHeight)
                            .offset(x: CGFloat(marker) / CGFloat(durationInSeconds) * totalWidth)
                            .offset(y: 8)
                        
                        Text("PA\(index + 1)")
                            .font(.caption)
                            .foregroundColor(.black)
                            .offset(x: CGFloat(marker) / CGFloat(durationInSeconds) * totalWidth - 6)
                            .offset(y: 8)
                            
                    }
                }
            }
        }
        .frame(height: 60)
    }
}
