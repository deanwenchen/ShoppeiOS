import SwiftUI

class PaymentViewModel: ObservableObject {
    @Published var shippingAddress: String = "26, Duong So 2, Thao Dien Ward, An Phu, District 2, Ho Chi Minh city"
    @Published var phone: String = "+84932000000"
    @Published var email: String = "amandamorgan@example.com"

    @Published var selectedShippingOption: ShippingOption = .standard

    @Published var items: [OrderItem] = [
        OrderItem(
            id: 1,
            name: "Lorem ipsum dolor sit amet consectetur.",
            price: "$17,00",
            quantity: 1,
            imageColor: "#FF85A2",
            icon: "person.fill"
        ),
        OrderItem(
            id: 2,
            name: "Lorem ipsum dolor sit amet consectetur.",
            price: "$17,00",
            quantity: 1,
            imageColor: "#FFD700",
            icon: "person.fill"
        )
    ]

    @Published var cardNumber: String = "1579"

    var shippingOptions: [ShippingOption] {
        [
            ShippingOption(id: "standard", title: "Standard", duration: "5-7 days", price: "FREE", priceValue: 0),
            ShippingOption(id: "express", title: "Express", duration: "1-2 days", price: "$12,00", priceValue: 12)
        ]
    }

    var itemsTotal: Double {
        items.reduce(0) { $0 + Double($1.price.replacingOccurrences(of: "$", with: "").replacingOccurrences(of: ",", with: ".")) ?? 0 }
    }

    var shippingTotal: Double {
        selectedShippingOption.priceValue
    }

    var totalAmount: String {
        let total = itemsTotal + shippingTotal
        let formatted = String(format: "%.2f", total)
        return "$\(formatted.replacingOccurrences(of: ".", with: ","))"
    }
}

struct ShippingOption: Identifiable {
    let id: String
    let title: String
    let duration: String
    let price: String
    let priceValue: Double
}

struct OrderItem: Identifiable {
    let id: Int
    let name: String
    let price: String
    let quantity: Int
    let imageColor: String
    let icon: String
}
