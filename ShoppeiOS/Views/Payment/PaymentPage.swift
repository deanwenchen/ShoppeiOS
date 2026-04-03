import SwiftUI

struct PaymentPage: View {
    @StateObject private var viewModel = PaymentViewModel()
    @State private var showingPaymentProcessing = false

    var body: some View {
        ZStack {
            Color.white

            VStack(spacing: 0) {
                // Status Bar Spacer
                Spacer().frame(height: 44)

                // Header
                headerSection

                // Scrollable Content
                ScrollView {
                    VStack(spacing: 24) {
                        // Shipping Address
                        infoCard(title: "Shipping Address", content: viewModel.shippingAddress)

                        // Contact Information
                        contactInfoCard

                        // Items Section
                        itemsSection

                        // Shipping Options
                        shippingOptionsSection

                        // Payment Method
                        paymentMethodSection

                        Spacer().frame(height: 40)
                    }
                    .padding(.top, 16)
                }
            }

            // Bottom Total Bar
            bottomTotalBar
        }
        .navigationBarHidden(true)
    }

    // MARK: - Header Section
    private var headerSection: some View {
        HStack {
            Text("Payment")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(Color(hex: "#202020"))

            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 8)
        .padding(.bottom, 8)
    }

    // MARK: - Contact Information Card
    private var contactInfoCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Contact Information")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(Color(hex: "#202020"))

            VStack(alignment: .leading, spacing: 2) {
                Text(viewModel.phone)
                    .font(.system(size: 10, weight: .regular))
                    .foregroundColor(.black)

                Text(viewModel.email)
                    .font(.system(size: 10, weight: .regular))
                    .foregroundColor(.black)
            }

            HStack {
                Spacer()

                Button(action: {}) {
                    ZStack {
                        Circle()
                            .fill(Color(hex: "#004CFF"))
                            .frame(width: 32, height: 32)

                        Image(systemName: "pencil")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .padding(16)
        .background(Color(hex: "#F9F9F9"))
        .cornerRadius(10)
    }

    // MARK: - Info Card Helper
    private func infoCard(title: String, content: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(Color(hex: "#202020"))

            Text(content)
                .font(.system(size: 10, weight: .regular))
                .foregroundColor(.black)
                .lineLimit(2)

            HStack {
                Spacer()

                Button(action: {}) {
                    ZStack {
                        Circle()
                            .fill(Color(hex: "#004CFF"))
                            .frame(width: 32, height: 32)

                        Image(systemName: "pencil")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .padding(16)
        .background(Color(hex: "#F9F9F9"))
        .cornerRadius(10)
    }

    // MARK: - Items Section
    private var itemsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack {
                HStack(spacing: 8) {
                    Text("Items")
                        .font(.system(size: 21, weight: .bold))
                        .foregroundColor(Color(hex: "#202020"))

                    Text("\(viewModel.items.count)")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color(hex: "#004CFF"))
                        .cornerRadius(12)
                }

                Spacer()

                // Add Voucher Button
                Button(action: {}) {
                    Text("Add Voucher")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(Color(hex: "#004BFE"))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 11)
                                .stroke(Color(hex: "#004BFE"), lineWidth: 1)
                        )
                }
            }

            // Items List
            VStack(spacing: 12) {
                ForEach(viewModel.items) { item in
                    OrderItemRow(item: item)
                }
            }
        }
        .padding(.horizontal, 20)
    }

    // MARK: - Shipping Options Section
    private var shippingOptionsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Shipping Options")
                .font(.system(size: 21, weight: .bold))
                .foregroundColor(Color(hex: "#202020"))

            VStack(spacing: 8) {
                ForEach(viewModel.shippingOptions) { option in
                    ShippingOptionRow(
                        option: option,
                        isSelected: viewModel.selectedShippingOption.id == option.id,
                        action: {
                            viewModel.selectedShippingOption = option
                        }
                    )
                }
            }

            // Delivery Date
            Text("Delivered on or before Thursday, 23 April 2020")
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.black)
                .padding(.top, 4)
        }
        .padding(.horizontal, 20)
    }

    // MARK: - Payment Method Section
    private var paymentMethodSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Payment Method")
                    .font(.system(size: 21, weight: .bold))
                    .foregroundColor(Color(hex: "#202020"))

                Spacer()

                // Edit Button
                Button(action: {}) {
                    ZStack {
                        Circle()
                            .fill(Color(hex: "#004CFF"))
                            .frame(width: 32, height: 32)

                        Image(systemName: "pencil")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                    }
                }
            }

            // Card Display
            HStack(spacing: 12) {
                // Card Icon
                ZStack {
                    Circle()
                        .fill(Color(hex: "#E5EBFC"))
                        .frame(width: 44, height: 44)

                    Image(systemName: "creditcard.fill")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(Color(hex: "#004CFF"))
                }

                // Card Number (masked)
                HStack(spacing: 4) {
                    Text("****  ****  ****")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.black)

                    Text(viewModel.cardNumber)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color(hex: "#202020"))
                }

                Spacer()

                // Card Label
                Text("Card")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(Color(hex: "#004CFF"))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color(hex: "#E5EBFC"))
                    .cornerRadius(18)
            }
            .padding(16)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.04), radius: 2, x: 0, y: 1)
        }
        .padding(.horizontal, 20)
    }

    // MARK: - Bottom Total Bar
    private var bottomTotalBar: some View {
        ZStack {
            Color(hex: "#F9F9F9")

            HStack(spacing: 16) {
                // Total Amount
                VStack(alignment: .leading, spacing: 4) {
                    Text("Total")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)

                    Text(viewModel.totalAmount)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color(hex: "#202020"))
                }

                Spacer()

                // Pay Button
                Button(action: {
                    showingPaymentProcessing = true
                }) {
                    Text("Pay")
                        .font(.system(size: 16, weight: .light))
                        .foregroundColor(Color(hex: "#F3F3F3"))
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#202020"))
                        .cornerRadius(11)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .padding(.bottom, 8)
        }
        .frame(height: 60)
    }
}

// MARK: - Order Item Row
struct OrderItemRow: View {
    let item: OrderItem

    var body: some View {
        HStack(spacing: 12) {
            // Product Image from Figma
            ZStack {
                AsyncImage(url: URL(string: ImageURLProvider.getProductImageURL(for: item.imageColor))) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                } placeholder: {
                    Circle()
                        .fill(Color(hex: item.imageColor))
                        .frame(width: 50, height: 50)
                }
            }

            // Quantity Badge
            Text("\(item.quantity)")
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(.black)
                .padding(6)
                .background(Color(hex: "#E5EBFC"))
                .cornerRadius(13)
                .offset(x: -15, y: -15)

            // Product Info
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.black)
                    .lineLimit(2)

                Text(item.price)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(hex: "#202020"))
            }

            Spacer()
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.04), radius: 2, x: 0, y: 1)
    }
}

// MARK: - Shipping Option Row
struct ShippingOptionRow: View {
    let option: ShippingOption
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                // Radio Button
                ZStack {
                    Circle()
                        .fill(isSelected ? Color(hex: "#E5EBFC") : Color.clear)
                        .frame(width: 22, height: 22)
                        .overlay(
                            Circle()
                                .stroke(Color(hex: isSelected ? "#004CFF" : "#D1D5DB"), lineWidth: 2)
                        )

                    if isSelected {
                        Circle()
                            .fill(Color(hex: "#004CFF"))
                            .frame(width: 12, height: 12)
                    }
                }

                // Title
                Text(option.title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)

                Spacer()

                // Duration Badge
                Text(option.duration)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(Color(hex: "#004CFF"))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color(hex: "#F5F8FF"))
                    .cornerRadius(4)

                // Price
                Text(option.price)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
            }
            .padding(12)
            .background(isSelected ? Color(hex: "#E5EBFC") : Color(hex: "#F9F9F9"))
            .cornerRadius(10)
        }
    }
}

// MARK: - Preview
struct PaymentPage_Previews: PreviewProvider {
    static var previews: some View {
        PaymentPage()
    }
}
