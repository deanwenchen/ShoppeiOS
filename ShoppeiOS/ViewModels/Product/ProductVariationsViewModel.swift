import SwiftUI

class ProductVariationsViewModel: ObservableObject {
    @Published var product: ProductVariationModel = ProductVariationModel(
        price: "$17,00",
        icon: "star.fill",
        selectedColorName: "Pink"
    )

    let colors: [String] = ["#FF6B6B", "#FFE66D", "#FF85A2", "#D58FFF"]
    let colorImages: [String] = ["image1", "image2", "image3", "image4"]
    let sizes: [String] = ["S", "M", "L", "XL", "XXL", "XXXL"]
    let disabledSizes: [String] = ["XXL", "XXXL"]

    @Published var selectedColorIndex: Int = 0
    @Published var selectedSize: String = "M"
    @Published var quantity: Int = 1
}

struct ProductVariationModel {
    let price: String
    let icon: String
    let selectedColorName: String
}
