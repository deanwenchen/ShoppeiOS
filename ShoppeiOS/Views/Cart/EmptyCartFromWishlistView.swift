import SwiftUI

struct EmptyCartFromWishlistView: View {
    @StateObject private var viewModel = CartViewModel()
    @State private var showingCheckout = false

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

                        // Wishlist Section
                        wishlistSection

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

    // MARK: - Wishlist Section
    private var wishlistSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("From Your Wishlist")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.black)

            ForEach(viewModel.wishlistItems) { item in
                WishlistItemRow(
                    item: item,
                    onAddToCart: {
                        viewModel.moveToCart(itemId: item.id)
                    },
                    onDelete: {
                        viewModel.removeFromWishlist(itemId: item.id)
                    }
                )
            }
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
                        .foregroundColor(Color(hex: "#0C0C0C"))
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

// MARK: - Wishlist Item Row
struct WishlistItemRow: View {
    let item: CartItem
    let onAddToCart: () -> Void
    let onDelete: () -> Void

    var body: some View {
        HStack(spacing: 16) {
            // Product Image from Figma
            ZStack {
                AsyncImage(url: URL(string: ImageURLProvider.getProductImageURL(for: item.imageColor))) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                } placeholder: {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color(hex: item.imageColor))
                        .frame(width: 100, height: 100)
                }
            }

            // Product Info
            VStack(alignment: .leading, spacing: 8) {
                // Name
                Text("Lorem ipsum dolor sit amet consectetur.")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(2)

                // Price
                Text(item.price)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(hex: "#202020"))

                // Color and Size Pills
                HStack(spacing: 8) {
                    Text(item.color)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.black)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(Color(hex: "#E5EBFC"))
                        .cornerRadius(4)

                    Text(item.size)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.black)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(Color(hex: "#E5EBFC"))
                        .cornerRadius(4)

                    Spacer()
                }

                // Action Buttons
                HStack(spacing: 12) {
                    // Delete Button
                    Button(action: onDelete) {
                        ZStack {
                            Circle()
                                .fill(Color(hex: "#FFE0E0"))
                                .frame(width: 40, height: 40)

                            Image(systemName: "trash")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(Color(hex: "#FF4444"))
                        }
                    }

                    Spacer()

                    // Add to Cart Button
                    Button(action: onAddToCart) {
                        Image(systemName: "bag.fill")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(Color(hex: "#004CFF"))
                            .frame(width: 44, height: 44)
                            .background(Color(hex: "#E5EBFC"))
                            .cornerRadius(12)
                    }
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(9)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

// MARK: - Preview
struct EmptyCartFromWishlistView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyCartFromWishlistView()
    }
}
