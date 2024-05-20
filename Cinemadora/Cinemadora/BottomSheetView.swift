//
//  BottomSheetView.swift
//  Cinemadora
//
//  Created by Bruno Cezario on 17/05/24.
//

import SwiftUI

struct BottomSheetView<Content: View>: View {
    let maxHeight: CGFloat
    let minHeight: CGFloat
    let movie: Movie?
    let content: Content

    @GestureState private var translation: CGFloat = 0
    @State private var offset: CGFloat = 0

    init(maxHeight: CGFloat, minHeight: CGFloat, movie: Movie?, @ViewBuilder content: () -> Content) {
        self.maxHeight = maxHeight
        self.minHeight = minHeight
        self.movie = movie
        self.content = content()
    }

    private var topOffset: CGFloat {
        return 0
    }

    private var bottomOffset: CGFloat {
        return UIScreen.main.bounds.height - minHeight
    }

    private var currentOffset: CGFloat {
        return offset + translation
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                self.content
            }
            .frame(width: geometry.size.width, height: self.maxHeight, alignment: .top)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(radius: 10)
            .offset(y: max(self.topOffset, min(self.bottomOffset, self.bottomOffset + self.currentOffset)))
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.height
                }
                .onEnded { value in
                    let snapDistance = self.maxHeight / 2
                    withAnimation(.interactiveSpring()) {
                        if value.translation.height < -snapDistance {
                            self.offset = self.topOffset - self.bottomOffset
                        } else if value.translation.height > snapDistance {
                            self.offset = 0
                        } else {
                            self.offset += value.translation.height
                        }
                    }
                }
            )
        }
    }
}
