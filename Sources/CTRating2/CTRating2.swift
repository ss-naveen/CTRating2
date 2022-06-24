//
//  CTRating2.swift
//  CTRatings2 Master
//
//  Created by Stewart Lynch on 2020-01-10.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import SwiftUI

/// A view of inline images that represents a rating.
/// Tapping on an image will change it from an unfilled to a filled version of the image.
///
/// The following example shows a CTRating view with a maximum rating of 10 red flags, each with a width of 20:
///
///     CTRating2(maxRating: 10,
///              currentRating: $currentRating,
///              width: 20,
///              color: .red,
///              ratingImage: .flag)
///
///
public struct CTRating2: View {
    var maxRating: Int
    @Binding var currentRating: Int
    var width:Int
    var color: UIColor
    var ratingImage: RatingImage

    public init(maxRating: Int, currentRating: Binding<Int>, width:Int = 20, color: UIColor = .systemYellow, ratingImage: RatingImage = .star) {
        self.maxRating = maxRating
        self._currentRating = currentRating
        self.width = width
        self.color = color
        self.ratingImage = ratingImage
    }
    public var body: some View {
        HStack {
            ForEach(0..<maxRating) { rating in
                correctImage(for: rating)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color(color))
                    .onTapGesture {
                        self.currentRating = rating+1
                    }
            }
        }.frame(width: CGFloat(maxRating * width))
    }
    
    func correctImage(for rating: Int) -> Image {
        if rating < currentRating {
            return ratingImage.fillImage
        } else {
            return ratingImage.openImage
        }
    }
}

struct CTRating_Previews: PreviewProvider {
    static var previews: some View {
        CTRating2(maxRating: 5, currentRating: .constant(3))
            .environment(\.colorScheme, .light)
            .previewLayout(.sizeThatFits)
            .padding(10)
    }
}
