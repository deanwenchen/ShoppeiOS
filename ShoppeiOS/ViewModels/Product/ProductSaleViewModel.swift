import SwiftUI
import Combine

class ProductSaleViewModel: ObservableObject {
    @Published var product: ProductSaleModel = ProductSaleModel(
        price: "$24,00",
        originalPrice: "$30,00",
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam arcu mauris, scelerisque eu mauris id, pretium pulvinar sapien.",
        icon: "bag.fill",
        color: "#D58FFF",
        images: ["image1", "image2", "image3"],
        imageColors: ["#FF6B6B", "#FFE66D", "#FF85A2"],
        discount: 20
    )

    @Published var hours: String = "00"
    @Published var minutes: String = "36"
    @Published var seconds: String = "58"

    @Published var selectedColor: String = "Pink"
    @Published var selectedSize: String = "M"
    @Published var selectedQuantity: Int = 1

    var colors: [String] = ["Pink", "Blue", "Yellow", "Red"]
    var sizes: [String] = ["XS", "S", "M", "L", "XL", "XXL"]

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

struct ProductSaleModel {
    let price: String
    let originalPrice: String
    let description: String
    let icon: String
    let color: String
    let images: [String]
    let imageColors: [String]
    let discount: Int
}
