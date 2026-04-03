import SwiftUI

struct ProductFullPage: View {
    @StateObject private var viewModel = ProductFullViewModel()
    @State private var currentIndex: Int = 0
    @State private var selectedColor: String = "Pink"
    @State private var selectedSize: String = "M"
    @State private var selectedDelivery: DeliveryOption = .standard

    enum DeliveryOption {
        case standard, express
    }

    var body: some View {
        ZStack {
            Color.white

            ScrollView {
                VStack(spacing: 0) {
                    // Product Image with Carousel
                    productImageSection

                    // Product Info
                    VStack(spacing: 24) {
                        // Price
                        Text(viewModel.product.price)
                            .font(.system(size: 26, weight: .bold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                            .padding(.top, 16)

                        // Description
                        Text(viewModel.product.description)
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.black)
                            .lineLimit(3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)

                        // Variations Section
                        variationsSection

                        // Specifications Section
                        specificationsSection

                        // Origin Section
                        originSection

                        // Delivery Section
                        deliverySection

                        // Rating & Reviews Section
                        ratingReviewsSection

                        // Most Popular Section
                        mostPopularSection

                        // You Might Like Section
                        youMightLikeSection

                        // Bottom spacing for navigation
                        Spacer().frame(height: 100)
                    }
                }
            }
        }
        .overlay(alignment: .topTrailing) {
            // Share Button
            shareButton
        }
        .overlay(alignment: .bottom) {
            // Bottom Action Bar
            bottomActionBar
        }
    }

    // MARK: - Product Image Section
    private var productImageSection: some View {
        VStack(spacing: 12) {
            // Main Image
            ZStack {
                Image(systemName: viewModel.product.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 375, height: 439)
                    .background(Color(hex: viewModel.product.color))
            }
            .mask(
                GeometryReader { geo in
                    Path { path in
                        path.move(to: CGPoint(x: 0, y: 0))
                        path.addLine(to: CGPoint(x: geo.size.width, y: 0))
                        path.addLine(to: CGPoint(x: geo.size.width, y: geo.size.height - 20))
                        path.addCurve(
                            to: CGPoint(0, y: geo.size.height),
                            control1: CGPoint(geo.size.width * 0.5, y: geo.size.height - 20),
                            control2: CGPoint(geo.size.width * 0.3, y: geo.size.height)
                        )
                        path.closeSubpath()
                    }
                }
            )

            // Page Indicator Dots
            HStack(spacing: 10) {
                ForEach(0..<viewModel.product.images.count, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 5)
                        .fill(index == currentIndex ? Color(hex: "#0042E0") : Color.gray.opacity(0.3))
                        .frame(width: index == currentIndex ? 40 : 10, height: 10)
                        .onTapGesture {
                            withAnimation {
                                currentIndex = index
                            }
                        }
                }
            }
            .padding(.top, 8)
        }
        .frame(height: 470)
    }

    // MARK: - Variations Section
    private var variationsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack {
                Text("Variations")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)

                Spacer()

                // Color and Size Pills
                HStack(spacing: 8) {
                    VariationPill(title: selectedColor, isSelected: false)
                    VariationPill(title: selectedSize, isSelected: false)
                }

                // Arrow Button
                Button(action: {}) {
                    ZStack {
                        Circle()
                            .fill(Color(hex: "#004CFF"))
                            .frame(width: 40, height: 40)

                        Image(systemName: "arrow.right")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(.horizontal, 20)

            // Variation Images Grid
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(viewModel.product.images.indices, id: \.self) { index in
                        VariationImageCard(
                            color: viewModel.product.imageColors[index],
                            isSelected: index == currentIndex
                        )
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }

    // MARK: - Specifications Section
    private var specificationsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Specifications")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)

            // Material
            VStack(alignment: .leading, spacing: 8) {
                Text("Material")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack(spacing: 8) {
                    SpecificationChip(title: "Cotton 95%", color: "#FFEBEB")
                    SpecificationChip(title: "Nylon 5%", color: "#FFEBEB")
                }
            }
            .padding(.horizontal, 20)
        }
        .padding(.top, 8)
    }

    // MARK: - Origin Section
    private var originSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Origin")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.black)

                Spacer()

                // EU Badge
                Text("EU")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
                    .frame(width: 59, height: 25)
                    .background(Color(hex: "#E5EBFC"))
                    .cornerRadius(4)
            }
            .padding(.horizontal, 20)

            // Size Guide Button
            HStack {
                Text("Size guide")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.black)

                Spacer()

                Button(action: {}) {
                    HStack {
                        Image(systemName: "arrow.right")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.black)
                    }
                    .frame(width: 30, height: 30)
                    .background(Color.white)
                    .cornerRadius(15)
                }
            }
            .padding(.horizontal, 20)
        }
        .padding(.top: 8)
    }

    // MARK: - Delivery Section
    private var deliverySection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Delivery")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)

            // Standard Delivery
            DeliveryOptionRow(
                title: "Standart",
                days: "5-7 days",
                price: "$3,00",
                isSelected: selectedDelivery == .standard
            ) {
                selectedDelivery = .standard
            }

            // Express Delivery
            DeliveryOptionRow(
                title: "Express",
                days: "1-2 days",
                price: "$12,00",
                isSelected: selectedDelivery == .express
            ) {
                selectedDelivery = .express
            }
        }
        .padding(.top: 8)
    }

    // MARK: - Rating & Reviews Section
    private var ratingReviewsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Rating & Reviews")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)

                Spacer()

                // Rating Badge
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                    Text("4/5")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.black)
                }
                .frame(width: 38, height: 20)
                .background(Color(hex: "#DFE9FF"))
                .cornerRadius(6)
            }
            .padding(.horizontal, 20)

            // User Review Card
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    // User Avatar
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 40, height: 40)
                        .overlay(
                            Image(systemName: "person.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.gray)
                        )

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Veronika")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)

                        // Stars
                        HStack(spacing: 2) {
                            ForEach(0..<5, id: \.self) { index in
                                Image(systemName: index < 4 ? "star.fill" : "star")
                                    .font(.system(size: 12))
                                    .foregroundColor(index < 4 ? .black : .gray.opacity(0.3))
                            }
                        }
                    }

                    Spacer()
                }

                Text(viewModel.review.text)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.black)
                    .lineLimit(3)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Button(action: {}) {
                    Text("View All Reviews")
                        .font(.system(size: 16, weight: .light))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(Color(hex: "#004CFF"))
                        .cornerRadius(11)
                }
            }
            .padding(16)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
            .padding(.horizontal, 20)
        }
        .padding(.top: 8)
    }

    // MARK: - Most Popular Section
    private var mostPopularSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Most Popular")
                    .font(.system(size: 21, weight: .bold))
                    .foregroundColor(.black)

                Spacer()

                HStack {
                    Text("See All")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.black)

                    Button(action: {}) {
                        Image(systemName: "arrow.right")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.black)
                    }
                }
            }
            .padding(.horizontal, 20)

            // Horizontal Scroll
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(viewModel.popularProducts.indices, id: \.self) { index in
                        PopularProductCardFull(product: viewModel.popularProducts[index])
                            .frame(width: 140)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .padding(.top: 8)
    }

    // MARK: - You Might Like Section
    private var youMightLikeSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("You Might Like")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(viewModel.recommendedProducts.indices, id: \.self) { index in
                    RecommendedProductCard(product: viewModel.recommendedProducts[index])
                }
            }
            .padding(.horizontal, 20)
        }
        .padding(.top: 8)
    }

    // MARK: - Share Button
    private var shareButton: some View {
        ZStack {
            Circle()
                .fill(Color.white)
                .frame(width: 30, height: 30)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)

            Image(systemName: "arrowshape.turn.up.right.fill")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.black)
        }
        .offset(x: -25, y: 470)
        .padding(.trailing, 20)
    }

    // MARK: - Bottom Action Bar
    private var bottomActionBar: some View {
        ZStack {
            Color.white
                .shadow(color: Color.black.opacity(0.16), radius: 1, x: 0, y: -1)

            HStack(spacing: 12) {
                // Like Button
                ZStack {
                    RoundedRectangle(cornerRadius: 11)
                        .fill(Color(hex: "#F9F9F9"))
                        .frame(width: 56, height: 56)

                    Image(systemName: "heart")
                        .font(.system(size: 22, weight: .regular))
                        .foregroundColor(.black)
                }

                // Add to Cart Button
                ZStack {
                    RoundedRectangle(cornerRadius: 11)
                        .fill(Color(hex: "#202020"))
                        .frame(height: 56)

                    Text("Add to cart")
                        .font(.system(size: 16, weight: .light))
                        .foregroundColor(.white)
                }

                // Buy Now Button
                ZStack {
                    RoundedRectangle(cornerRadius: 11)
                        .fill(Color(hex: "#004CFF"))
                        .frame(height: 56)

                    Text("Buy now")
                        .font(.system(size: 16, weight: .light))
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 14)
            .padding(.horizontal, 8)
        }
        .frame(height: 84)
    }
}

struct PopularProductCardFull: View {
    let product: ProductFullModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: 9)
                    .fill(Color(hex: product.color))
                    .frame(height: 140)

                // Like Icon
                Image(systemName: "heart")
                    .font(.system(size: 16))
                    .foregroundColor(.gray.opacity(0.5))
                    .padding(8)

                // Badge
                if let badge = product.badge {
                    Text(badge)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.black)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.white)
                        .cornerRadius(4)
                        .padding(8)
                }
            }

            Text("\(product.sales)")
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(.black)
        }
        .padding(.horizontal, 10)
    }
}

struct RecommendedProductCard: View {
    let product: ProductFullModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            RoundedRectangle(cornerRadius: 9)
                .fill(Color(hex: product.color))
                .frame(height: 180)

            Text(product.description)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.black)
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(product.price)
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.black)
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
struct ProductFullPage_Previews: PreviewProvider {
    static var previews: some View {
        ProductFullPage()
    }
}
