import SwiftUI

struct ContentView: View {
    @State var records: [ImageModel] = [ImageModel(id: 1, name: "image1"),
                                        ImageModel(id: 2, name: "image2"),
                                        ImageModel(id: 3, name: "image3"),
                                        ImageModel(id: 4, name: "image4"),
                                        ImageModel(id: 5, name: "image5"),
                                        ImageModel(id: 6, name: "image6")]

    @State var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    @State var viewState = CGSize.zero
    let itemCount: Int = 6

    var body: some View {
        VStack {
            ZStack {
                ForEach(0..<records.count, id: \.self) { index in
                    VStack {
                        Image(records[index].name)
                            .frame(width: UIScreen.width - 128)
                            .offset(x: viewState.width + CGFloat(index - currentIndex) * (UIScreen.width - 60) + dragOffset, y: 0)
                            .scaleEffect(currentIndex == index ? 1.0 : 0.8)
                            .opacity(currentIndex == index ? 1.0 : 0.3)
                    }
                }
            }
            .background(.clear)
            .gesture(
                DragGesture()
                    .onChanged{ value in
                        withAnimation {
                            viewState = value.translation
                        }
                    }
                    .onEnded{ value in
                        cardsSwipeHandling(threshold: 10, 
                                           width: value.translation.width,
                                           itemsCount: itemCount)
                    }
            )

            showPageControl(count: itemCount)
                .padding(.top, 25)
        }
        .frame(width: UIScreen.width)
    }

    private func cardsSwipeHandling(threshold: CGFloat,
                                    width: CGFloat,
                                    itemsCount: Int) {
        if width > threshold {
            withAnimation {
                updateCurrentIndex(movement: .left)
            }
        } else if width < -threshold {
            withAnimation {
                updateCurrentIndex(movement: .right)
            }
        }
        if #available(iOS 17, *) {
            withAnimation(.spring()) {
                viewState = .zero
            }
        } else {
            withAnimation {
                viewState = .zero
            }
        }
    }

    private func showPageControl(count: Int) -> some View {
        HStack {
            leftButton()
                .padding(.leading, 24)
                .frame(width: 44, height: 44)
            Spacer()
            let dotModel = DotModel(numberOfDotIndicators: count)
            DotView(selectedDot: $currentIndex, model: dotModel)
            Spacer()
            rightButton()
                .padding(.trailing, 24)
                .frame(width: 44, height: 44)
        }
    }

    private func leftButton() -> some View {
        Button(action: {
            withAnimation {
//                if currentIndex > 0 {
                    updateCurrentIndex(movement: .left)
//                }
            }
        }, label: {
            Image("left_arrow_icon_black")
                .scaledToFit()
                .accessibilityHidden(true)
        })
    }

    private func rightButton(gap: Int = 1) -> some View {
        Button(action: {
            withAnimation {
//                if currentIndex < itemCount - 1 {
                    updateCurrentIndex(movement: .right)
//                }
            }
        }, label: {
            Image("right_arrow_icon_black")
                .scaledToFit()
                .accessibilityHidden(true)
        })
    }

    private func updateCurrentIndex(movement: Movement) {
        if movement == .left {
            currentIndex = currentIndex - 1//max(0, currentIndex - 1)
            print("Left Current Index: \(currentIndex)")
            if currentIndex == -1 {
                currentIndex = itemCount-1
            }
        } else {
            currentIndex = currentIndex + 1//min(itemCount - 1, currentIndex + 1)
            print("Right Current Index: \(currentIndex)")
            if currentIndex == itemCount {
                currentIndex = 0
            }
        }
    }
}

enum Movement {
    case left
    case right
}

struct ImageModel: Identifiable {
    var id: Int
    var name: String
}

extension UIScreen {
    static var isSmallerDevice: Bool {
        UIScreen.main.bounds.width <= 320.0
    }

    static var width: CGFloat {
        UIScreen.main.bounds.width
    }
}

#Preview {
    ContentView()
}
