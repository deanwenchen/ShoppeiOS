import SwiftUI

class ProductFullViewModel: ObservableObject {
    @Published var product: ProductFullModel = ProductFullModel(
        price: "$17,00",
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam arcu mauris, scelerisque eu mauris id, pretium pulvinar sapien.",
        icon: "person.fill",
        color: "#FFE66D",
        images: ["image1", "image2", "image3"],
        imageColors: ["#FF6B6B", "#FFE66D", "#FF85A2"]
    )

    @Published var review: ReviewModel = ReviewModel(
        userName: "Veronika",
        rating: 4,
        text: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed ..."
    )

    let popularProducts: [ProductFullModel] = [
        ProductFullModel(price: "$17,00", description: "Product 1", icon: "star.fill", color: "#FF6B6B", badge: "New", sales: "1780"),
        ProductFullModel(price: "$17,00", description: "Product 2", icon: "star.fill", color: "#FF85A2", badge: "Sale", sales: "1780"),
        ProductFullModel(price: "$17,00", description: "Product 3", icon: "star.fill", color: "#FFE66D", badge: "Hot", sales: "1780"),
        ProductFullModel(price: "$17,00", description: "Product 4", icon: "star.fill", color: "#6B6BFF", badge: "Hot", sales: "1780")
    ]

    let recommendedProducts: [ProductFullModel] = [
        ProductFullModel(price: "$21,00", description: "Lorem ipsum dolor sit amet consectetur", icon: "bag.fill", color: "#FF6B6B", badge: nil, sales: ""),
        ProductFullModel(price: "$17,00", description: "Lorem ipsum dolor sit amet consectetur", icon: "bag.fill", color: "#FFE66D", badge: nil, sales: ""),
        ProductFullModel(price: "$22,00", description: "Lorem ipsum dolor sit amet consectetur", icon: "bag.fill", color: "#FF85A2", badge: nil, sales: ""),
        ProductFullModel(price: "$17,00", description: "Lorem ipsum dolor sit amet consectetur", icon: "bag.fill", color: "#E8D5F5", badge: nil, sales: "")
    ]

    var materials: [String] = ["Cotton 95%", "Nylon 5%"]
    var origin: String = "EU"
}

struct ProductFullModel {
    let price: String
    let description: String
    let icon: String
    let color: String
    let images: [String]
    let imageColors: [String]
    var badge: String?
    var sales: String
}

struct ReviewModel {
    let userName: String
    let rating: Int
    let text: String
}
