import SwiftUI

struct EmptyCartFromPopularView: View {
    @StateObject private var viewModel = CartViewModel()
    @State private var showingCheckout = false

    let popularProducts: [PopularProduct] = [
        PopularProduct(id: 1, sales: "1780", badge: "New", imageColor: "#FFD4C5", icon: "person.fill"),
        PopularProduct(id: 2, sales: "1780", badge: "Sale", imageColor: "#FFB6C1", icon: "person.fill"),
        PopularProduct(id: 3, sales: "1780", badge: "Hot", imageColor: "#FF6B6B", icon: "person.fill"),
        PopularProduct(id: 4, sales: "1780", badge: "Hot", imageColor: "#FFD700", icon: "person.fill")
    ]

    var body: some View {
        ZStack {
            Color.white

            VStack(spacing: 0) {
                // Status Bar Spacer
                Spacer().frame(height: 44)

                // Header
                headerSection

                // Shipping Address
                shippingAddressSection

                // Main Content
                ScrollView {
                    VStack(spacing: 24) {
                        // Empty Cart Icon
                        emptyCartIcon

                        // Amount Display
                        amountSection

                        // Most Popular Section
                        popularSection

                        Spacer().frame(height: 40)
                    }
                    .padding(.top, 20)
                }
            }

            // Bottom Total Bar
            bottomTotalBar
        }
        .navigationBarHidden(true)
    }

    // MARK: - Header Section
    private var headerSection: some View {
        HStack(spacing: 8) {
            Text("Cart")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(Color(hex: "#202020"))

            // Item Count Badge
            Text("\(viewModel.itemCount)")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.black)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color(hex: "#E5EBFC"))
                .cornerRadius(12)

            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 8)
        .padding(.bottom, 8)
    }

    // MARK: - Shipping Address Section
    private var shippingAddressSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Shipping Address")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(Color(hex: "#202020"))

            Text("26, Duong So 2, Thao Dien Ward, An Phu, District 2, Ho Chi Minh city")
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
        .padding(.horizontal, 20)
        .padding(.top, 8)
    }

    // MARK: - Empty Cart Icon
    private var emptyCartIcon: some View {
        ZStack {
            Circle()
                .fill(Color.white)
                .frame(width: 160, height: 160)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)

            Image(systemName: "shopping.bag.fill")
                .font(.system(size: 80, weight: .medium))
                .foregroundColor(Color(hex: "#004CFF"))
                .overlay(
                    Text("S")
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(.white)
                        .offset(y: 5)
                )
        }
    }

    // MARK: - Amount Section
    private var amountSection: some View {
        HStack(spacing: 8) {
            Image(systemName: "dollarsign.circle.fill")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.black)

            Text("\(viewModel.itemCount)")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.black)
        }
        .padding(.horizontal, 20)
    }

    // MARK: - Most Popular Section
    private var popularSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header with See All
            HStack {
                Text("Most Popular")
                    .font(.system(size: 21, weight: .bold))
                    .foregroundColor(Color(hex: "#202020"))

                Spacer()

                Button(action: {}) {
                    HStack(spacing: 8) {
                        Text("See All")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(Color(hex: "#202020"))

                        ZStack {
                            Circle()
                                .fill(Color(hex: "#004CFF"))
                                .frame(width: 28, height: 28)

                            Image(systemName: "arrow.right")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.white)
                        }
                    }
                }
            }

            // Horizontal Scroll
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(popularProducts) { product in
                        PopularProductCard(product: product)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }

    // MARK: - Bottom Total Bar
    private var bottomTotalBar: some View {
        ZStack {
            Color(hex: "#F9F9F9")

            HStack(spacing: 16) {
                // Total Amount
                VStack(alignment: .leading, spacing: 4) {
                    Text("Total")
                        .font(.system(size: 20, weight: .extraBold))
                        .foregroundColor(.black)

                    Text("$0,00")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color(hex: "#202020"))
                }

                Spacer()

                // Checkout Button
                Button(action: {
                    showingCheckout = true
                }) {
                    Text("Checkout")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color(hex: "#141414"))
                        .frame(height: 48)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
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

// MARK: - Popular Product Model
struct PopularProduct: Identifiable {
    let id: Int
    let sales: String
    let badge: String
    let imageColor: String
    let icon: String
}

// MARK: - Popular Product Card
struct PopularProductCard: View {
    let product: PopularProduct

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Product Image
            ZStack(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color(hex: product.imageColor))
                    .frame(width: 104, height: 140)

                Image(systemName: product.icon)
                    .font(.system(size: 50, weight: .regular))
                    .foregroundColor(.white.opacity(0.6))
            }

            // Sales Count
            HStack(spacing: 4) {
                Text(product.sales)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.black)

                Image(systemName: "heart.fill")
                    .font(.system(size: 10, weight: .regular))
                    .foregroundColor(Color(hex: "#004CFF"))
            }

            // Badge
            Text(product.badge)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(Color(hex: "#202020"))
        }
        .frame(width: 104)
    }
}

// MARK: - Preview
struct EmptyCartFromPopularView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyCartFromPopularView()
    }
}
