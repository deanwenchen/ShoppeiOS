import SwiftUI

struct CartPage: View {
    @StateObject private var viewModel = CartViewModel()
    @State private var showingCheckout = false

    var body: some View {
        ZStack {
            Color.white

            VStack(spacing: 0) {
                // Header
                headerSection

                // Scrollable Content
                ScrollView {
                    VStack(spacing: 0) {
                        // Shipping Address
                        shippingAddressSection

                        // Cart Items
                        cartItemsSection

                        // Wishlist Section
                        wishlistSection

                        // Bottom spacing for total bar
                        Spacer().frame(height: 100)
                    }
                }
            }

            // Bottom Total Bar
            bottomTotalBar
        }
        .navigationBarHidden(true)
    }

    // MARK: - Header Section
    private var headerSection: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Cart")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.black)

                Spacer()

                // Item Count Badge
                HStack(spacing: 4) {
                    Image(systemName: "bag.fill")
                        .font(.system(size: 14, weight: .medium))

                    Text("\(viewModel.itemCount)")
                        .font(.system(size: 12, weight: .bold))
                }
                .foregroundColor(Color(hex: "#004CFF"))
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color(hex: "#E5EBFC"))
                .cornerRadius(16)
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 16)
        }
        .background(Color.white)
    }

    // MARK: - Shipping Address Section
    private var shippingAddressSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Shipping Address")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.black)

                Spacer()

                // Edit Button
                Button(action: {}) {
                    HStack(spacing: 6) {
                        Image(systemName: "pencil")
                            .font(.system(size: 12, weight: .semibold))

                        Text("Edit")
                            .font(.system(size: 12, weight: .medium))
                    }
                    .foregroundColor(Color(hex: "#004CFF"))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color(hex: "#E5EBFC"))
                    .cornerRadius(8)
                }
            }

            // Address Display
            HStack {
                Image(systemName: "location.fill")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(Color(hex: "#004CFF"))

                Text(viewModel.shippingAddress)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.black)

                Spacer()
            }
            .padding(16)
            .background(Color(hex: "#F9F9F9"))
            .cornerRadius(12)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 24)
    }

    // MARK: - Cart Items Section
    private var cartItemsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(viewModel.cartItems) { item in
                CartItemRow(
                    item: item,
                    onQuantityChange: { delta in
                        viewModel.updateQuantity(for: item.id, delta: delta)
                    },
                    onDelete: {
                        viewModel.removeFromCart(itemId: item.id)
                    }
                )
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 32)
    }

    // MARK: - Wishlist Section
    private var wishlistSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("From Your Wishlist")
                .font(.system(size: 17, weight: .bold))
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
        .padding(.bottom, 32)
    }

    // MARK: - Bottom Total Bar
    private var bottomTotalBar: some View {
        ZStack {
            Color.white
                .shadow(color: Color.black.opacity(0.16), radius: 1, x: 0, y: -1)

            HStack(spacing: 16) {
                // Total Amount
                VStack(alignment: .leading, spacing: 4) {
                    Text("Total")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(Color(hex: "#6B7280"))

                    Text(viewModel.totalAmount)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.black)
                }

                Spacer()

                // Checkout Button
                Button(action: {
                    showingCheckout = true
                }) {
                    Text("Checkout")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .frame(height: 52)
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#004CFF"))
                        .cornerRadius(12)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .padding(.bottom, 8)
        }
        .frame(height: 92)
        .offset(y: 0)
    }
}

// MARK: - Cart Item Row
struct CartItemRow: View {
    let item: CartItem
    let onQuantityChange: (Int) -> Void
    let onDelete: () -> Void
    @State private var quantity: Int = 1

    var body: some View {
        HStack(spacing: 16) {
            // Product Image
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(hex: item.imageColor))
                    .frame(width: 100, height: 100)

                Image(systemName: item.icon)
                    .font(.system(size: 40, weight: .regular))
                    .foregroundColor(.white.opacity(0.8))
            }

            // Product Info
            VStack(alignment: .leading, spacing: 8) {
                // Name
                Text(item.name)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(2)

                // Color and Size Pills
                HStack(spacing: 8) {
                    Text(item.color)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.black)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color(hex: "#E5EBFC"))
                        .cornerRadius(4)

                    Text(item.size)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.black)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color(hex: "#E5EBFC"))
                        .cornerRadius(4)

                    Spacer()
                }

                // Price and Quantity
                HStack {
                    Text(item.price)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)

                    Spacer()

                    // Quantity Controls
                    HStack(spacing: 8) {
                        Button(action: {
                            onQuantityChange(-1)
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color(hex: "#E5EBFC"))
                                    .frame(width: 32, height: 32)

                                Image(systemName: "minus")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(Color(hex: "#1A3168"))
                            }
                        }

                        Text("\(item.quantity)")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color(hex: "#1A3168"))
                            .frame(width: 40)

                        Button(action: {
                            onQuantityChange(1)
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color(hex: "#E5EBFC"))
                                    .frame(width: 32, height: 32)

                                Image(systemName: "plus")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(Color(hex: "#1A3168"))
                            }
                        }
                    }
                }
            }

            // Delete Button
            Button(action: onDelete) {
                Image(systemName: "trash")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(Color(hex: "#9CA3AF"))
                    .frame(width: 40, height: 40)
                    .background(Color(hex: "#F9F9F9"))
                    .cornerRadius(8)
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.04), radius: 2, x: 0, y: 1)
    }
}

// MARK: - Wishlist Item Row
struct WishlistItemRow: View {
    let item: CartItem
    let onAddToCart: () -> Void
    let onDelete: () -> Void

    var body: some View {
        HStack(spacing: 16) {
            // Product Image
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(hex: item.imageColor))
                    .frame(width: 100, height: 100)

                Image(systemName: item.icon)
                    .font(.system(size: 40, weight: .regular))
                    .foregroundColor(.white.opacity(0.8))
            }

            // Product Info
            VStack(alignment: .leading, spacing: 8) {
                // Name
                Text(item.name)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(2)

                // Color and Size Pills
                HStack(spacing: 8) {
                    Text(item.color)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.black)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color(hex: "#E5EBFC"))
                        .cornerRadius(4)

                    Text(item.size)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.black)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color(hex: "#E5EBFC"))
                        .cornerRadius(4)

                    Spacer()
                }

                // Price and Actions
                HStack {
                    Text(item.price)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)

                    Spacer()

                    HStack(spacing: 8) {
                        // Add to Cart Icon
                        Button(action: onAddToCart) {
                            Image(systemName: "bag.fill")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(Color(hex: "#004CFF"))
                                .frame(width: 40, height: 40)
                                .background(Color(hex: "#E5EBFC"))
                                .cornerRadius(8)
                        }

                        // Delete Button
                        Button(action: onDelete) {
                            Image(systemName: "trash")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(Color(hex: "#9CA3AF"))
                                .frame(width: 40, height: 40)
                                .background(Color(hex: "#F9F9F9"))
                                .cornerRadius(8)
                        }
                    }
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.04), radius: 2, x: 0, y: 1)
    }
}

// MARK: - Preview
struct CartPage_Previews: PreviewProvider {
    static var previews: some View {
        CartPage()
    }
}
