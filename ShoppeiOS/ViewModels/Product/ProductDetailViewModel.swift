import SwiftUI

class ProductDetailViewModel: ObservableObject {
    @Published var product: ProductDetailModel = ProductDetailModel(
        price: "$17,00",
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam arcu mauris, scelerisque eu mauris id, pretium pulvinar sapien.",
        icon: "person.fill",
        color: "#F5E8D5",
        images: ["image1", "image2", "image3"],
        imageColors: ["#FF6B6B", "#FFE66D", "#FF85A2"]
    )

    @Published var selectedColor: String = "Pink"
    @Published var selectedSize: String = "M"
    @Published var selectedQuantity: Int = 1

    var colors: [String] = ["Pink", "Blue", "Yellow", "Red"]
    var sizes: [String] = ["XS", "S", "M", "L", "XL", "XXL"]
}

struct ProductDetailModel {
    let price: String
    let description: String
    let icon: String
    let color: String
    let images: [String]
    let imageColors: [String]
}
