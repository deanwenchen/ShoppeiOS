import SwiftUI

enum ShippingOptionType {
    case standard
    case express
}

struct ProductDetailPage: View {
    @StateObject private var viewModel = ProductDetailViewModel()
    @State private var currentIndex: Int = 0
    @State private var selectedColor: String = "Pink"
    @State private var selectedSize: String = "M"
    @State private var showVariationsSheet: Bool = false
    @State private var selectedShippingOption: ShippingOptionType = .standard
    @State private var showReviewsSheet: Bool = false

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

                        // Shipping Options Section
                        shippingOptionsSection

                        // Reviews Section
                        reviewsSection

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
        .sheet(isPresented: $showVariationsSheet) {
            VariationsSheet(
                selectedColor: $selectedColor,
                selectedSize: $selectedSize,
                onClose: {
                    showVariationsSheet = false
                }
            )
        }
        .sheet(isPresented: $showReviewsSheet) {
            ReviewsSheet()
        }
    }

    // MARK: - Product Image Section
    private var productImageSection: some View {
        VStack(spacing: 12) {
            // Main Image
            ZStack {
                // Product Image from Figma
                AsyncImage(url: URL(string: ImageURLProvider.getProductImageURL(for: viewModel.product.color))) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 375, height: 439)
                } placeholder: {
                    Image(systemName: viewModel.product.icon)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 375, height: 439)
                        .background(Color(hex: viewModel.product.color))
                }

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
                    showVariationsSheet = true
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
                            imageColor: getVariationColor(at: index),
                            isSelected: index == currentIndex
                        )
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .padding(.top, 16)
    }

    // MARK: - Shipping Options Section
    private var shippingOptionsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Shipping Options")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.black)
                .padding(.horizontal, 20)

            VStack(spacing: 8) {
                // Standard Shipping
                ShippingOptionRow(
                    title: "Standard",
                    duration: "5-7 days",
                    price: "$5.00",
                    isSelected: selectedShippingOption == .standard
                ) {
                    selectedShippingOption = .standard
                }

                // Express Shipping
                ShippingOptionRow(
                    title: "Express",
                    duration: "1-2 days",
                    price: "$12.00",
                    isSelected: selectedShippingOption == .express
                ) {
                    selectedShippingOption = .express
                }
            }
            .padding(.horizontal, 20)
        }
        .padding(.top, 16)
    }

    // MARK: - Reviews Section
    private var reviewsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack {
                Text("Reviews")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.black)

                Spacer()

                // See All Button
                Button(action: {
                    showReviewsSheet = true
                }) {
                    HStack(spacing: 4) {
                        Text("See All")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color(hex: "#004CFF"))

                        Image(systemName: "chevron.right")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(Color(hex: "#004CFF"))
                    }
                }
            }
            .padding(.horizontal, 20)

            // Rating Summary
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    Text("4.8")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.black)

                    VStack(alignment: .leading, spacing: 2) {
                        HStack(spacing: 2) {
                            ForEach(0..<5, id: \.self) { index in
                                Image(systemName: index < 4 ? "star.fill" : "star.lefthalf.fill")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(hex: "#FFB800"))
                            }
                        }

                        Text("1,234 reviews")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.gray)
                    }

                    Spacer()
                }
                .padding(.horizontal, 20)

                // Rating Bars
                VStack(spacing: 4) {
                    RatingBar(stars: 5, count: 890, totalCount: 1234)
                    RatingBar(stars: 4, count: 234, totalCount: 1234)
                    RatingBar(stars: 3, count: 78, totalCount: 1234)
                    RatingBar(stars: 2, count: 20, totalCount: 1234)
                    RatingBar(stars: 1, count: 12, totalCount: 1234)
                }
                .padding(.horizontal, 20)
            }

            // Sample Review
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Circle()
                        .fill(Color(hex: "#FFD1DC"))
                        .frame(width: 40, height: 40)
                        .overlay(
                            Text("J")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.black)
                        )

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Jessica M.")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.black)

                        HStack(spacing: 2) {
                            ForEach(0..<5, id: \.self) { index in
                                Image(systemName: "star.fill")
                                    .font(.system(size: 10))
                                    .foregroundColor(Color(hex: "#FFB800"))
                            }
                        }
                    }

                    Spacer()

                    Text("2 days ago")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.gray)
                }

                Text("Absolutely love this product! The quality is amazing and it arrived faster than expected. Will definitely buy again!")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.black)
                    .lineSpacing(3)
            }
            .padding(16)
            .background(Color(hex: "#F8F8F8"))
            .cornerRadius(12)
            .padding(.horizontal, 20)
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

            // Figma Share Icon
            AsyncImage(url: URL(string: shareIconURL)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 14, height: 14)
            } placeholder: {
                Image(systemName: "arrowshape.turn.up.right.fill")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)
            }
        }
        .offset(x: -25, y: 470)
    }

    // MARK: - Get Variation Color for Image
    private func getVariationColor(at index: Int) -> String {
        guard index < viewModel.product.imageColors.count else { return "#FFB6C1" }
        return viewModel.product.imageColors[index]
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

// MARK: - Shipping Option Row
struct ShippingOptionRow: View {
    let title: String
    let duration: String
    let price: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                // Radio Button
                ZStack {
                    Circle()
                        .fill(isSelected ? Color(hex: "#E5EBFC") : Color.clear)
                        .frame(width: 20, height: 20)
                        .overlay(
                            Circle()
                                .stroke(Color(hex: isSelected ? "#004CFF" : "#D1D5DB"), lineWidth: 2)
                        )

                    if isSelected {
                        Circle()
                            .fill(Color(hex: "#004CFF"))
                            .frame(width: 10, height: 10)
                    }
                }

                // Icon
                Image(systemName: isSelected ? "shippingbox.fill" : "shippingbox")
                    .font(.system(size: 18))
                    .foregroundColor(isSelected ? Color(hex: "#004CFF") : .gray)

                // Title and Duration
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.black)

                    Text(duration)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.gray)
                }

                Spacer()

                // Price
                Text(price)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(isSelected ? Color(hex: "#E5EBFC") : Color(hex: "#F9F9F9"))
            )
        }
    }
}

// MARK: - Rating Bar
struct RatingBar: View {
    let stars: Int
    let count: Int
    let totalCount: Int

    var body: some View {
        HStack(spacing: 8) {
            Text("\(stars)")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.black)
                .frame(width: 12)

            HStack(spacing: 2) {
                ForEach(0..<5, id: \.self) { index in
                    Image(systemName: index < stars ? "star.fill" : "star")
                        .font(.system(size: 8))
                        .foregroundColor(Color(hex: "#FFB800"))
                }
            }
            .frame(width: 60)

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color(hex: "#E5EBFC"))
                        .frame(height: 6)

                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color(hex: "#004CFF"))
                        .frame(width: geo.size.width * CGFloat(count) / max(totalCount, 1), height: 6)
                }
            }
            .frame(height: 6)

            Text("\(count)")
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.gray)
                .frame(width: 30)
        }
    }
}

// MARK: - Variations Sheet
struct VariationsSheet: View {
    @Binding var selectedColor: String
    @Binding var selectedSize: String
    let onClose: () -> Void

    let colors: [(name: String, color: String)] = [
        ("Pink", "#FFB6C1"),
        ("Blue", "#B6D4FF"),
        ("Green", "#B6FFC7"),
        ("Yellow", "#FFF4B6")
    ]

    let sizes: [String] = ["S", "M", "L", "XL", "XXL", "XXXL"]

    var body: some View {
        NavigationView {
            ZStack {
                Color.white

                VStack(spacing: 24) {
                    // Color Selection
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Color")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(.black)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(colors, id: \.name) { color in
                                    Button(action: {
                                        selectedColor = color.name
                                    }) {
                                        ZStack {
                                            Circle()
                                                .fill(Color(hex: color.color))
                                                .frame(width: 60, height: 60)

                                            if selectedColor == color.name {
                                                Circle()
                                                    .stroke(Color(hex: "#004CFF"), lineWidth: 3)
                                                    .frame(width: 68, height: 68)
                                                    .overlay(
                                                        Circle()
                                                            .fill(Color(hex: "#004CFF"))
                                                            .frame(width: 20, height: 20)
                                                            .overlay(
                                                                Image(systemName: "checkmark")
                                                                    .font(.system(size: 12, weight: .bold))
                                                                    .foregroundColor(.white)
                                                            )
                                                    )
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }

                    // Size Selection
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Size")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(.black)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(sizes, id: \.self) { size in
                                    Button(action: {
                                        selectedSize = size
                                    }) {
                                        Text(size)
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundColor(selectedSize == size ? .white : .black)
                                            .frame(width: 50, height: 50)
                                            .background(selectedSize == size ? Color(hex: "#004CFF") : Color(hex: "#F8F8F8"))
                                            .cornerRadius(8)
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }

                    Spacer()
                }
                .padding(.top, 20)
            }
            .navigationTitle("Select Variations")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        onClose()
                    }
                    .foregroundColor(Color(hex: "#004CFF"))
                }
            }
        }
    }
}

// MARK: - Reviews Sheet
struct ReviewsSheet: View {
    @Environment(\.dismiss) var dismiss

    let reviews: [(name: String, initial: String, rating: Int, date: String, comment: String)] = [
        ("Jessica M.", "J", 5, "2 days ago", "Absolutely love this product! The quality is amazing and it arrived faster than expected."),
        ("Sarah K.", "S", 5, "1 week ago", "Great purchase! Fits perfectly and the color is exactly as shown in the pictures."),
        ("Mike R.", "M", 4, "2 weeks ago", "Good quality for the price. Shipping took a bit longer but overall satisfied."),
        ("Emily T.", "E", 5, "3 weeks ago", "Exceeded my expectations! Will definitely order more colors."),
        ("David L.", "D", 5, "1 month ago", "Perfect! Exactly what I was looking for.")
    ]

    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: "#F8F8F8")

                ScrollView {
                    VStack(spacing: 16) {
                        // Rating Summary
                        VStack(spacing: 8) {
                            Text("4.8 out of 5")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.black)

                            HStack(spacing: 2) {
                                ForEach(0..<5, id: \.self) { index in
                                    Image(systemName: index < 4 ? "star.fill" : "star.lefthalf.fill")
                                        .font(.system(size: 20))
                                        .foregroundColor(Color(hex: "#FFB800"))
                                }
                            }

                            Text("Based on 1,234 reviews")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.gray)
                        }
                        .padding(20)
                        .background(Color.white)
                        .cornerRadius(12)

                        // Reviews List
                        ForEach(reviews, id: \.name) { review in
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Circle()
                                        .fill(Color(hex: "#FFD1DC"))
                                        .frame(width: 40, height: 40)
                                        .overlay(
                                            Text(review.initial)
                                                .font(.system(size: 16, weight: .bold))
                                                .foregroundColor(.black)
                                        )

                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(review.name)
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundColor(.black)

                                        HStack(spacing: 2) {
                                            ForEach(0..<5, id: \.self) { index in
                                                Image(systemName: index < review.rating ? "star.fill" : "star")
                                                    .font(.system(size: 10))
                                                    .foregroundColor(Color(hex: "#FFB800"))
                                            }
                                        }
                                    }

                                    Spacer()

                                    Text(review.date)
                                        .font(.system(size: 12, weight: .regular))
                                        .foregroundColor(.gray)
                                }

                                Text(review.comment)
                                    .font(.system(size: 13, weight: .regular))
                                    .foregroundColor(.black)
                                    .lineSpacing(3)
                            }
                            .padding(16)
                            .background(Color.white)
                            .cornerRadius(12)
                        }
                    }
                    .padding(16)
                }
            }
            .navigationTitle("Customer Reviews")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(Color(hex: "#004CFF"))
                }
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

// MARK: - Variation Image Card
struct VariationImageCard: View {
    let color: String
    let imageColor: String
    let isSelected: Bool

    var body: some View {
        ZStack(alignment: .topTrailing) {
            // Product Image from Figma
            AsyncImage(url: URL(string: ImageURLProvider.getVariationImageURL(for: imageColor))) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
            } placeholder: {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color(hex: imageColor))
                    .frame(width: 100, height: 100)
            }

            // Selection Indicator
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
