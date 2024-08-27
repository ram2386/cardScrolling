import SwiftUI

struct DotModel {
    var numberOfDotIndicators: Int = 0
    var viewWidth: CGFloat = 16
    var viewHeight: CGFloat = 16
    var marginBetweenDotIndicators: CGFloat = 8
    var radiusWidth: CGFloat = 2
    var radiusColor: Color = .white
    var unselectedDotIndicatorColor: Color = .gray
    var selectedDotIndicatorColor: Color = .black
}

struct DotView: View {
    @Binding var selectedDot: Int
    var model: DotModel
    @State private var scale: CGFloat = 1.0

    private var currentPosition: CGFloat {
        let totalWidthOfView = model.viewWidth * CGFloat(model.numberOfDotIndicators) + model.marginBetweenDotIndicators * CGFloat(model.numberOfDotIndicators - 1)
        let halfWidthOfView = totalWidthOfView / 2
        let initialPosition = -halfWidthOfView + (model.viewWidth / 2)
        let distanceToNextDot = model.viewWidth + model.marginBetweenDotIndicators
        let DotIndex = CGFloat(selectedDot)
        return initialPosition + (DotIndex * distanceToNextDot)
    }

    var body: some View {
        ZStack {
            HStack(spacing: model.marginBetweenDotIndicators) {
                ForEach(0 ..< model.numberOfDotIndicators, id: \.self) { index in
                    Circle()
                        .fill(model.unselectedDotIndicatorColor)
                        .tag(index)
                        .frame(width: model.viewWidth, height: model.viewHeight)
                }
            }
            Circle()
                .stroke(model.radiusColor, lineWidth: model.radiusWidth)
                .frame(width: model.viewWidth, height: model.viewHeight)
                .shadow(color: Color.black.opacity(0.7), radius: model.radiusWidth)
                .offset(x: currentPosition)
        }
    }
}
