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
            // Product Image from Figma
            ZStack {
                AsyncImage(url: URL(string: getProductImageURL(for: item.imageColor))) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                } placeholder: {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(hex: item.imageColor))
                        .frame(width: 100, height: 100)
                }
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
            // Product Image from Figma
            ZStack {
                AsyncImage(url: URL(string: getProductImageURL(for: item.imageColor))) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                } placeholder: {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(hex: item.imageColor))
                        .frame(width: 100, height: 100)
                }
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

// MARK: - Product Image URL Helper
func getProductImageURL(for color: String) -> String {
    switch color {
    case "#FFB6C1": // Pink
        return "https://www.figma.com/api/mcp/asset/ed3e9463-9a3b-43ba-90b9-da37bf20ccaa"
    case "#B6D4FF": // Blue
        return "https://www.figma.com/api/mcp/asset/e3719d83-504e-4f54-a3b0-1b4760a4d9cb"
    case "#FFF4B6": // Yellow
        return "https://www.figma.com/api/mcp/asset/95dc9ed1-944f-49ec-b9f6-43b9e090d3da"
    case "#FFD1DC": // Light Pink
        return "https://www.figma.com/api/mcp/asset/d80951b1-d8df-4011-b71e-8824a19e43f1"
    case "#E8F5E9": // Green
        return "https://www.figma.com/api/mcp/asset/c8d6c11f-0ac9-411e-9169-335a6e032f55"
    default:
        return "https://www.figma.com/api/mcp/asset/d80951b1-d8df-4011-b71e-8824a19e43f1"
    }
}
