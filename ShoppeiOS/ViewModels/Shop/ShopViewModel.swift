import SwiftUI
import Combine

class ShopViewModel: ObservableObject {
    @Published var currentBannerIndex: Int = 0
    @Published var hours: String = "02"
    @Published var minutes: String = "45"
    @Published var seconds: String = "30"

    // Banner Carousel Data
    let banners: [BannerModel] = [
        BannerModel(icon: "gift.fill", color: "#FF6B6B", title: "Big Sale"),
        BannerModel(icon: "sparkles", color: "#4ECDC4", title: "New Arrivals"),
        BannerModel(icon: "crown.fill", color: "#FFE66D", title: "Premium"),
        BannerModel(icon: "heart.fill", color: "#FF85A2", title: "Special Offer")
    ]

    // Categories Data (2x4 grid)
    let categories: [CategoryModel] = [
        CategoryModel(name: "Clothing", icon: "tshirt.fill", color: "#FF6B6B", count: 1240),
        CategoryModel(name: "Shoes", icon: "shoe.fill", color: "#4ECDC4", count: 856),
        CategoryModel(name: "Accessories", icon: "glasses.fill", color: "#FFE66D", count: 432),
        CategoryModel(name: "Bags", icon: "bag.fill", color: "#FF85A2", count: 328),
        CategoryModel(name: "Electronics", icon: "phone.fill", color: "#6B6BFF", count: 567),
        CategoryModel(name: "Home", icon: "house.fill", color: "#6BFF9D", count: 892),
        CategoryModel(name: "Beauty", icon: "star.fill", color: "#FFB66B", count: 234),
        CategoryModel(name: "Sports", icon: "basketball.fill", color: "#A66BFF", count: 445)
    ]

    // Top Products (5 horizontal)
    let topProducts: [ProductModel] = [
        ProductModel(name: "Summer Dress", price: "$89.00", originalPrice: nil, icon: "tshirt.fill", color: "#FF6B6B", rating: 4.8),
        ProductModel(name: "Running Shoes", price: "$129.00", originalPrice: nil, icon: "shoe.fill", color: "#4ECDC4", rating: 4.9),
        ProductModel(name: "Leather Bag", price: "$199.00", originalPrice: nil, icon: "bag.fill", color: "#FFE66D", rating: 4.7),
        ProductModel(name: "Smart Watch", price: "$299.00", originalPrice: nil, icon: "watch.fill", color: "#6B6BFF", rating: 4.6),
        ProductModel(name: "Sunglasses", price: "$79.00", originalPrice: nil, icon: "glasses.fill", color: "#FF85A2", rating: 4.5)
    ]

    // New Items (3 column grid)
    let newItems: [ProductModel] = [
        ProductModel(name: "Casual Shirt", price: "$45.00", originalPrice: nil, icon: "tshirt.fill", color: "#FF6B6B", rating: nil),
        ProductModel(name: "Denim Jeans", price: "$65.00", originalPrice: nil, icon: "jeans.fill", color: "#4ECDC4", rating: nil),
        ProductModel(name: "Canvas Shoes", price: "$55.00", originalPrice: nil, icon: "shoe.fill", color: "#FFE66D", rating: nil)
    ]

    // Flash Sale Products (3x2 grid)
    let flashSaleProducts: [ProductModel] = [
        ProductModel(name: "Wireless Earbuds", price: "$79.00", originalPrice: "$99.00", icon: "airpodspro.fill", color: "#FF6B6B", rating: nil),
        ProductModel(name: "Phone Case", price: "$19.00", originalPrice: "$24.00", icon: "iphone.fill", color: "#4ECDC4", rating: nil),
        ProductModel(name: "Desk Lamp", price: "$39.00", originalPrice: "$49.00", icon: "lamp.floor.fill", color: "#FFE66D", rating: nil),
        ProductModel(name: "Water Bottle", price: "$25.00", originalPrice: "$32.00", icon: "cup.and.saucer.fill", color: "#FF85A2", rating: nil),
        ProductModel(name: "Backpack", price: "$89.00", originalPrice: "$110.00", icon: "bag.fill", color: "#6B6BFF", rating: nil),
        ProductModel(name: "Headphones", price: "$159.00", originalPrice: "$199.00", icon: "headphones.fill", color: "#6BFF9D", rating: nil)
    ]

    // Most Popular (4 horizontal)
    let popularProducts: [ProductModel] = [
        ProductModel(name: "Classic Watch", price: "$249.00", originalPrice: nil, icon: "watch.fill", color: "#FF6B6B", rating: 4.9),
        ProductModel(name: "Leather Wallet", price: "$79.00", originalPrice: nil, icon: "wallet.pass.fill", color: "#4ECDC4", rating: 4.8),
        ProductModel(name: "Scarf", price: "$45.00", originalPrice: nil, icon: "scarf.fill", color: "#FFE66D", rating: 4.7),
        ProductModel(name: "Beanie", price: "$29.00", originalPrice: nil, icon: "hat.fill", color: "#FF85A2", rating: 4.6)
    ]

    // Just For You (2x2 grid)
    let recommendedProducts: [ProductModel] = [
        ProductModel(name: "Yoga Mat", price: "$35.00", originalPrice: nil, icon: "yoga.mat.fill", color: "#FF6B6B", rating: nil),
        ProductModel(name: "Fitness Tracker", price: "$99.00", originalPrice: nil, icon: "heart.rectangle.fill", color: "#4ECDC4", rating: nil),
        ProductModel(name: "Running Shorts", price: "$39.00", originalPrice: nil, icon: "shorts.fill", color: "#FFE66D", rating: nil),
        ProductModel(name: "Sports Bra", price: "$49.00", originalPrice: nil, icon: "heart.fill", color: "#FF85A2", rating: nil)
    ]

    private var timer: AnyCancellable?

    init() {
        startBannerAutoScroll()
        startCountdownTimer()
    }

    private func startBannerAutoScroll() {
        timer = Timer.publish(every: 5, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                withAnimation(.easeInOut(duration: 0.5)) {
                    self.currentBannerIndex = (self.currentBannerIndex + 1) % self.banners.count
                }
            }
    }

    private func startCountdownTimer() {
        Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.updateCountdown()
            }
            .store(in: &timer)
    }

    private func updateCountdown() {
        var totalSeconds = (Int(hours) ?? 0) * 3600 + (Int(minutes) ?? 0) * 60 + (Int(seconds) ?? 0)

        if totalSeconds > 0 {
            totalSeconds -= 1

            let h = totalSeconds / 3600
            let m = (totalSeconds % 3600) / 60
            let s = totalSeconds % 60

            hours = String(format: "%02d", h)
            minutes = String(format: "%02d", m)
            seconds = String(format: "%02d", s)
        }
    }
}

// MARK: - Models

struct BannerModel {
    let icon: String
    let color: String
    let title: String
}

struct CategoryModel {
    let name: String
    let icon: String
    let color: String
    let count: Int
}

struct ProductModel {
    let name: String
    let price: String
    let originalPrice: String?
    let icon: String
    let color: String
    let rating: Double?
}
