import SwiftUI
import Combine

class FlashSaleLiveViewModel: ObservableObject {
    @Published var hours: String = "00"
    @Published var minutes: String = "36"
    @Published var seconds: String = "58"

    // Showcase colors for live section
    let showcaseColors: [String] = ["#E8D5F5", "#F5E8D5", "#D5E8F5", "#F5D5E8"]

    // Flash Sale Products
    let flashSaleProducts: [ProductModel] = [
        ProductModel(
            name: "Flash Sale Item 1",
            price: "$16,00",
            originalPrice: "$20,00",
            description: "Lorem ipsum dolor sit amet consectetur",
            icon: "bag.fill",
            color: "#FF6B6B",
            discount: 20
        ),
        ProductModel(
            name: "Flash Sale Item 2",
            price: "$16,00",
            originalPrice: "$20,00",
            description: "Lorem ipsum dolor sit amet consectetur",
            icon: "star.fill",
            color: "#D58FFF",
            discount: 20
        ),
        ProductModel(
            name: "Flash Sale Item 3",
            price: "$16,00",
            originalPrice: "$20,00",
            description: "Lorem ipsum dolor sit amet consectetur",
            icon: "heart.fill",
            color: "#8FD5FF",
            discount: 20
        ),
        ProductModel(
            name: "Flash Sale Item 4",
            price: "$16,00",
            originalPrice: "$20,00",
            description: "Lorem ipsum dolor sit amet consectetur",
            icon: "sparkles",
            color: "#FFD58F",
            discount: 20
        )
    ]

    private var timer: AnyCancellable?

    init() {
        startCountdownTimer()
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

// MARK: - Product Model

struct ProductModel {
    let name: String
    let price: String
    let originalPrice: String
    let description: String
    let icon: String
    let color: String
    let discount: Double
}
