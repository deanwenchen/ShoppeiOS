import SwiftUI

struct ProductDetailPage: View {
    @StateObject private var viewModel = ProductDetailViewModel()
    @State private var currentIndex: Int = 0
    @State private var selectedColor: String = "Pink"
    @State private var selectedSize: String = "M"

    var body: some View {
        ZStack {
            Color.white

            ScrollView {
                VStack(spacing: 0) {
                    // Product Image with Carousel
                    productImageSection

                    // Product Info
                    VStack(spacing: 16) {
                        // Price
                        Text(viewModel.product.price)
                            .font(.system(size: 26, weight: .extraBold))
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

                // Gradient overlay at bottom
                LinearGradient(
                    colors: [.clear, .black.opacity(0.1)],
                    startPoint: .top,
                    endPoint: .bottom
                )
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
                    Circle()
                        .fill(index == currentIndex ? Color(hex: "#004CFF") : Color.gray.opacity(0.3))
                        .frame(width: 10, height: 10)
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
                    .font(.system(size: 20, weight: .extraBold))
                    .foregroundColor(.black)

                Spacer()

                // Color and Size Pills
                HStack(spacing: 8) {
                    VariationPill(title: selectedColor, isSelected: false)
                    VariationPill(title: selectedSize, isSelected: false)
                }

                // Arrow Button
                Button(action: {
                    // Open variations sheet
                }) {
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
        .padding(.top, 16)
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

// MARK: - Subviews

struct VariationPill: View {
    let title: String
    let isSelected: Bool

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.black)
        }
        .frame(width: 60, height: 32)
        .background(Color(hex: "#F9F9F9"))
        .cornerRadius(4)
    }
}

struct VariationImageCard: View {
    let color: String
    let isSelected: Bool

    var body: some View {
        ZStack(alignment: .topTrailing) {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color(hex: color))
                .frame(width: 100, height: 100)

            if isSelected {
                Circle()
                    .fill(Color(hex: "#004CFF"))
                    .frame(width: 16, height: 16)
                    .overlay(
                        Image(systemName: "checkmark")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.white)
                    )
                    .offset(x: -4, y: 4)
            }
        }
    }
}

// MARK: - Preview
struct ProductDetailPage_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailPage()
    }
}
