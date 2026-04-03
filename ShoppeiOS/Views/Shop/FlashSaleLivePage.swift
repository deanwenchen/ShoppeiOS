import SwiftUI

struct FlashSaleLivePage: View {
    @StateObject private var viewModel = FlashSaleLiveViewModel()
    @State private var selectedDiscount: Double = 20
    @State private var selectedTab: Tab = .home

    enum Tab {
        case home, cart, categories, wishlist, profile
    }

    var body: some View {
        ZStack {
            Color.white

            ScrollView {
                VStack(spacing: 0) {
                    // Header Section
                    headerSection

                    // Discount Filter Pills
                    discountFilterSection

                    // Product Grid
                    productGridSection

                    // Live Section
                    liveSection

                    // More Flash Sale Products
                    moreProductsSection

                    // Bottom padding for navigation
                    Spacer().frame(height: 100)
                }
            }
        }
        .overlay(alignment: .bottom) {
            bottomNavigationBar
        }
    }

    // MARK: - Header Section
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Flash Sale")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.black)

                    Text("Choose Your Discount")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.black.opacity(0.7))
                }

                Spacer()

                // Timer
                HStack(spacing: 4) {
                    Image(systemName: "clock.fill")
                        .font(.system(size: 16))
                        .foregroundColor(.black.opacity(0.7))

                    TimerBox(value: viewModel.hours)
                    TimerBox(value: viewModel.minutes)
                    TimerBox(value: viewModel.seconds)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
        }
        .background(
            ZStack {
                Color.white
                // Decorative blue background at top
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color(hex: "#004CFF"))
                    .mask(
                        Path { path in
                            path.move(to: CGPoint(x: 0, y: 0))
                            path.addLine(to: CGPoint(x: 375, y: 0))
                            path.addLine(to: CGPoint(x: 375, y: 150))
                            path.addCurve(to: CGPoint(0, y: 100),
                                         control1: CGPoint(200, y: 150),
                                         control2: CGPoint(100, y: 50))
                            path.closeSubpath()
                        }
                    )
                    .offset(y: -80)
            }
        )
    }

    // MARK: - Discount Filter Section
    private var discountFilterSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                FilterChip(title: "All", discount: 0, selected: $selectedDiscount)
                FilterChip(title: "10%", discount: 10, selected: $selectedDiscount)
                FilterChip(title: "20%", discount: 20, selected: $selectedDiscount)
                FilterChip(title: "30%", discount: 30, selected: $selectedDiscount)
                FilterChip(title: "40%", discount: 40, selected: $selectedDiscount)
                FilterChip(title: "50%", discount: 50, selected: $selectedDiscount)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
    }

    // MARK: - Product Grid Section
    private var productGridSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("20% Discount")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)
                .padding(.horizontal, 20)
                .padding(.top, 24)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(viewModel.flashSaleProducts.prefix(2)) { product in
                    FlashSaleProductCard(product: product)
                }
            }
            .padding(.horizontal, 20)
        }
    }

    // MARK: - Live Section
    private var liveSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("ARTICALE REIMAGINED")
                .font(.system(size: 12, weight: .bold, design: .monospaced))
                .foregroundColor(.black.opacity(0.5))
                .padding(.horizontal, 20)
                .padding(.top, 8)

            ZStack {
                RoundedRectangle(cornerRadius: 13)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 160)

                // Product showcase images
                HStack(spacing: 2) {
                    ForEach(0..<4, id: \.self) { index in
                        Rectangle()
                            .fill(Color(hex: viewModel.showcaseColors[index]))
                            .frame(height: 160)

                        if index == 3 {
                            // Live badge
                            VStack {
                                Text("Live")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                            .frame(width: 50, height: 24)
                            .background(Color.green)
                            .cornerRadius(4)
                            .padding(.trailing, 8)
                            .padding(.bottom, 8)
                            .offset(x: 60, y: 50)
                        }
                    }
                }

                // Play button
                Circle()
                    .fill(Color.white.opacity(0.9))
                    .frame(width: 50, height: 50)
                    .overlay(
                        Image(systemName: "play.fill")
                            .font(.system(size: 18))
                            .foregroundColor(.black)
                    )
            }
            .padding(.horizontal, 20)
        }
    }

    // MARK: - More Products Section
    private var moreProductsSection: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
            ForEach(viewModel.flashSaleProducts.dropFirst(2)) { product in
                FlashSaleProductCard(product: product)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
    }

    // MARK: - Bottom Navigation Bar
    private var bottomNavigationBar: some View {
        HStack {
            NavigationTabIndicator(
                icon: "house.fill",
                title: "Home",
                isSelected: selectedTab == .home,
                showIndicator: true
            ) {
                selectedTab = .home
            }

            NavigationTabIndicator(
                icon: "heart",
                title: "Wishlist",
                isSelected: selectedTab == .wishlist,
                showIndicator: false
            ) {
                selectedTab = .wishlist
            }

            NavigationTabIndicator(
                icon: "list.bullet.rectangle",
                title: "Categories",
                isSelected: selectedTab == .categories,
                showIndicator: false
            ) {
                selectedTab = .categories
            }

            NavigationTabIndicator(
                icon: "bag.fill",
                title: "Cart",
                isSelected: selectedTab == .cart,
                showIndicator: false
            ) {
                selectedTab = .cart
            }

            NavigationTabIndicator(
                icon: "person",
                title: "Profile",
                isSelected: selectedTab == .profile,
                showIndicator: false
            ) {
                selectedTab = .profile
            }
        }
        .frame(height: 84)
        .padding(.horizontal, 8)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: -1)
    }
}

// MARK: - Subviews

struct TimerBox: View {
    let value: String

    var body: some View {
        Text(value)
            .font(.system(size: 17, weight: .bold))
            .foregroundColor(.black)
            .frame(width: 44, height: 32)
            .background(Color.white)
            .cornerRadius(7)
    }
}

struct FilterChip: View {
    let title: String
    let discount: Double
    @Binding var selected: Double

    var isSelected: Bool {
        selected == discount
    }

    var body: some View {
        Button(action: {
            withAnimation {
                selected = discount
            }
        }) {
            HStack {
                if isSelected && discount > 0 {
                    Image(systemName: "arrowshape.down.fill")
                        .font(.system(size: 8, weight: .bold))
                        .rotationEffect(.degrees(180))
                }
            }
            .frame(width: isSelected ? 88 : 60, height: 36)
            .background(
                ZStack {
                    if isSelected {
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color.white)
                            .shadow(color: Color(hex: "#004CFF").opacity(0.16), radius: 5, x: 0, y: 5)
                    }
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(isSelected ? Color(hex: "#004CFF") : Color.gray.opacity(0.3), lineWidth: isSelected ? 2 : 1)
            )
            .overlay(
                Text(title)
                    .font(.system(size: 13, weight: isSelected ? .bold : .regular))
                    .foregroundColor(isSelected ? Color(hex: "#004CFF") : .black)
            )
        }
    }
}

struct FlashSaleProductCard: View {
    let product: ProductModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: 9)
                    .fill(Color(hex: product.color))
                    .frame(height: 180)

                // -20% Badge
                VStack {
                    Text("-20%")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.white)
                }
                .frame(width: 50, height: 24)
                .background(
                    LinearGradient(
                        colors: [Color(hex: "#FF5790"), Color(hex: "#F81140")],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(5, corners: [.topLeft, .topRight, .bottomLeft])
            }

            Text(product.description)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.black)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)

            HStack(spacing: 6) {
                Text(product.price)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.black)

                Text(product.originalPrice)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(Color(hex: "#F1AEAE"))
                    .strikethrough()
            }
        }
    }
}

struct NavigationTabIndicator: View {
    let icon: String
    let title: String
    let isSelected: Bool
    let showIndicator: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                ZStack {
                    Image(systemName: icon)
                        .font(.system(size: 22))
                        .foregroundColor(isSelected ? Color(hex: "#004CFF") : .gray.opacity(0.5))

                    if showIndicator && isSelected {
                        VStack {
                            Spacer()
                            Image(systemName: "arrowshape.down.fill")
                                .font(.system(size: 8))
                                .rotationEffect(.degrees(180))
                                .foregroundColor(Color(hex: "#004CFF"))
                        }
                        .frame(height: 16)
                        .offset(y: 14)
                    }
                }
                .frame(height: 30)

                if showIndicator && isSelected {
                    Text(title)
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(Color(hex: "#004CFF"))
                        .padding(.top, 2)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

// Helper for corner radius
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// MARK: - Preview
struct FlashSaleLivePage_Previews: PreviewProvider {
    static var previews: some View {
        FlashSaleLivePage()
    }
}
