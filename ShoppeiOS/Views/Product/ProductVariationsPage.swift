import SwiftUI

struct ProductVariationsPage: View {
    @StateObject private var viewModel = ProductVariationsViewModel()
    @State private var selectedColor: Int = 0
    @State private var selectedSize: String = "M"
    @State private var quantity: Int = 1

    var body: some View {
        ZStack {
            Color.white

            // Blurred Background Image
            productImageBackground

            // Header Section
            headerSection

            // Bottom Sheet Content
            VStack(spacing: 0) {
                // Drag Handle
                RoundedRectangle(cornerRadius: 3)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 36, height: 6)
                    .padding(.top, 12)

                // Content
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        // Color Options
                        colorOptionsSection

                        // Size Selection
                        sizeSection

                        // Quantity
                        quantitySection

                        // Bottom spacing for navigation bar
                        Spacer().frame(height: 40)
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                }
            }
            .offset(y: 278)
        }
        .overlay(alignment: .bottom) {
            bottomActionBar
        }
    }

    // MARK: - Product Image Background
    private var productImageBackground: some View {
        ZStack {
            Image(systemName: "person.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 375, height: 439)
                .background(Color(hex: "#FFE66D"))
                .blur(radius: 5)
        }
        .frame(height: 439)
    }

    // MARK: - Header Section
    private var headerSection: some View {
        VStack(spacing: 0) {
            // Light blue background for header
            RoundedRectangle(cornerRadius: 9)
                .fill(Color(hex: "#F8FAFF"))
                .frame(height: 141)
                .overlay(
                    HStack(spacing: 16) {
                        // Thumbnail Image
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color(hex: viewModel.colors[selectedColor]))
                                .frame(width: 75, height: 75)

                            Image(systemName: viewModel.product.icon)
                                .font(.system(size: 30))
                                .foregroundColor(.white.opacity(0.8))
                        }

                        // Price and Info
                        VStack(spacing: 8) {
                            Text(viewModel.product.price)
                                .font(.system(size: 26, weight: .extraBold))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            HStack(spacing: 8) {
                                Text(viewModel.selectedColorName)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.black)
                                    .frame(height: 25)
                                    .padding(.horizontal, 12)
                                    .background(Color(hex: "#E5EBFC"))
                                    .cornerRadius(4)

                                Text(viewModel.selectedSize)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.black)
                                    .frame(height: 25)
                                    .padding(.horizontal, 12)
                                    .background(Color(hex: "#E5EBFC"))
                                    .cornerRadius(4)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(16)
                )
                .offset(y: 278)
        }
    }

    // MARK: - Color Options Section
    private var colorOptionsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Color Options")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.black)

            HStack(spacing: 12) {
                ForEach(viewModel.colors.indices, id: \.self) { index in
                    ColorOptionCard(
                        color: viewModel.colors[index],
                        image: viewModel.colorImages[index],
                        isSelected: selectedColor == index
                    ) {
                        selectedColor = index
                    }
                }
            }
        }
    }

    // MARK: - Size Section
    private var sizeSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Size")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.black)

            HStack(spacing: 8) {
                ForEach(viewModel.sizes, id: \.self) { size in
                    SizeOptionChip(
                        size: size,
                        isSelected: selectedSize == size,
                        isDisabled: viewModel.disabledSizes.contains(size)
                    ) {
                        selectedSize = size
                    }
                }
            }
        }
    }

    // MARK: - Quantity Section
    private var quantitySection: some View {
        HStack {
            Text("Quantity")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.black)

            Spacer()

            HStack(spacing: 12) {
                // Less Button
                Button(action: {
                    if quantity > 1 {
                        quantity -= 1
                    }
                }) {
                    ZStack {
                        Circle()
                            .fill(Color(hex: "#E5EBFC"))
                            .frame(width: 50, height: 50)

                        Image(systemName: "minus")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color(hex: "#1A3168"))
                    }
                }

                // Quantity Display
                Text("\(quantity)")
                    .font(.system(size: 29, weight: .medium))
                    .foregroundColor(Color(hex: "#1A3168"))
                    .frame(width: 72, height: 50)
                    .background(Color(hex: "#E5EBFC"))
                    .cornerRadius(16)

                // More Button
                Button(action: {
                    if quantity < 99 {
                        quantity += 1
                    }
                }) {
                    ZStack {
                        Circle()
                            .fill(Color(hex: "#E5EBFC"))
                            .frame(width: 50, height: 50)

                        Image(systemName: "plus")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color(hex: "#1A3168"))
                    }
                }
            }
        }
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

struct ColorOptionCard: View {
    let color: String
    let image: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color(hex: color))
                    .frame(width: 79, height: 79)

                if isSelected {
                    ZStack {
                        Circle()
                            .fill(Color(hex: "#004CFF"))
                            .frame(width: 24, height: 24)

                        Image(systemName: "checkmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .offset(x: 8, y: -8)
                }
            }
        }
    }
}

struct SizeOptionChip: View {
    let size: String
    let isSelected: Bool
    let isDisabled: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(size)
                .font(.system(size: size.count <= 2 ? 14 : 13, weight: .medium))
                .foregroundColor(isDisabled ? Color(hex: "#BEC8E5") : .black)
                .frame(width: 50, height: 25)
                .background(
                    ZStack {
                        if isSelected {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color(hex: "#E5EBFC"))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color(hex: "#004CFF"), lineWidth: 1)
                                )
                        } else if isDisabled {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color(hex: "#E5EBFC"))
                        } else {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color(hex: "#F9F9F9"))
                        }
                    }
                )
        }
        .disabled(isDisabled)
    }
}

// MARK: - Preview
struct ProductVariationsPage_Previews: PreviewProvider {
    static var previews: some View {
        ProductVariationsPage()
    }
}
