import SwiftUI

class CartViewModel: ObservableObject {
    @Published var shippingAddress: String = "123 Main Street, Apt 4B"
    @Published var cartItems: [CartItem] = [
        CartItem(
            id: 1,
            name: "Lorem ipsum dolor",
            color: "Pink",
            size: "M",
            price: "$17,00",
            quantity: 1,
            imageColor: "#FF85A2",
            icon: "star.fill"
        ),
        CartItem(
            id: 2,
            name: "Lorem ipsum dolor",
            color: "Pink",
            size: "M",
            price: "$17,00",
            quantity: 1,
            imageColor: "#FF85A2",
            icon: "star.fill"
        )
    ]

    @Published var wishlistItems: [CartItem] = [
        CartItem(
            id: 3,
            name: "Lorem ipsum dolor sit amet consectetur.",
            color: "Pink",
            size: "M",
            price: "$17,00",
            quantity: 1,
            imageColor: "#FF85A2",
            icon: "star.fill",
            hasProductImage: true
        ),
        CartItem(
            id: 4,
            name: "Lorem ipsum dolor sit amet consectetur.",
            color: "Pink",
            size: "M",
            price: "$17,00",
            quantity: 1,
            imageColor: "#FF6B6B",
            icon: "star.fill",
            hasProductImage: true
        )
    ]

    var totalAmount: String {
        let total = cartItems.reduce(0.0) { $0 + Double($1.price.replacingOccurrences(of: "$", with: "").replacingOccurrences(of: ",", with: ".")) ?? 0.0 }
        let formatted = String(format: "%.2f", total)
        return "$\(formatted.replacingOccurrences(of: ".", with: ","))"
    }

    var itemCount: Int {
        return cartItems.reduce(0) { $0 + $1.quantity }
    }

    func updateQuantity(for itemId: Int, delta: Int) {
        guard let index = cartItems.firstIndex(where: { $0.id == itemId }) else { return }
        let newQuantity = cartItems[index].quantity + delta
        if newQuantity >= 1 && newQuantity <= 99 {
            cartItems[index].quantity = newQuantity
        }
    }

    func removeFromCart(itemId: Int) {
        cartItems.removeAll(where: { $0.id == itemId })
    }

    func removeFromWishlist(itemId: Int) {
        wishlistItems.removeAll(where: { $0.id == itemId })
    }

    func moveToCart(itemId: Int) {
        guard let index = wishlistItems.firstIndex(where: { $0.id == itemId }) else { return }
        cartItems.append(wishlistItems[index])
        wishlistItems.remove(at: index)
    }
}

struct CartItem: Identifiable {
    let id: Int
    let name: String
    let color: String
    let size: String
    let price: String
    var quantity: Int
    let imageColor: String
    let icon: String
    var hasProductImage: Bool = false
}
