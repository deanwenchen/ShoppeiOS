import SwiftUI

class AddVoucherViewModel: ObservableObject {
    @Published var vouchers: [Voucher] = [
        Voucher(
            id: 1,
            title: "First Purchase",
            description: "5% off for your next order",
            discountPercent: 5,
            validUntil: "5.16.20",
            icon: "lock.fill"
        ),
        Voucher(
            id: 2,
            title: "Gift From Customer Care",
            description: "15% off your next purchase",
            discountPercent: 15,
            validUntil: "6.20.20",
            icon: "gift.fill"
        )
    ]

    func applyVoucher(voucher: Voucher) {
        // Handle voucher application
        print("Applied voucher: \(voucher.title)")
    }
}

struct Voucher: Identifiable {
    let id: Int
    let title: String
    let description: String
    let discountPercent: Int
    let validUntil: String
    let icon: String
}
