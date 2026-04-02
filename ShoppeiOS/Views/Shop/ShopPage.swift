import SwiftUI

struct ShopPage: View {
    @StateObject private var viewModel = ShopViewModel()
    @State private var selectedTab: Tab = .home

    enum Tab {
        case home, cart, categories, wishlist, profile
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color.white

                ScrollView {
                    VStack(spacing: 0) {
                        // Search Bar
                        searchBar

                        // Content Sections
                        VStack(spacing: 24) {
                            bigSaleBanner
                            categoriesSection
                            topProductsSection
                            newItemsSection
                            flashSaleSection
                            mostPopularSection
                            justForYouSection

                            // Bottom padding for navigation bar
                            Spacer().frame(height: 100)
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                    }
                }
            }
            .navigationBarHidden(true)
            .overlay(alignment: .bottom) {
                bottomNavigationBar
            }
        }
    }

    // MARK: - Search Bar
    private var searchBar: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.gray.opacity(0.5))

            Text("Search")
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.gray.opacity(0.5))

            Spacer()
        }
        .frame(height: 44)
        .padding(.horizontal, 16)
        .background(Color(hex: "F8F8F8"))
        .cornerRadius(18)
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }

    // MARK: - Big Sale Banner
    private var bigSaleBanner: some View {
        TabView(selection: $viewModel.currentBannerIndex) {
            ForEach(viewModel.banners.indices, id: \.self) { index in
                Image(systemName: viewModel.banners[index].icon)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 150)
                    .background(Color(hex: viewModel.banners[index].color))
                    .cornerRadius(18)
                    .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .frame(height: 150)
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: viewModel.banners.count > 1 ? .always : .never))
    }

    // MARK: - Categories Section
    private var categoriesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Categories")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(viewModel.categories) { category in
                    CategoryCard(category: category)
                }
            }
        }
    }

    // MARK: - Top Products Section
    private var topProductsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Top Products")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(viewModel.topProducts) { product in
                        ProductCardHorizontal(product: product)
                    }
                }
            }
        }
    }

    // MARK: - New Items Section
    private var newItemsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("New Items")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)

            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                ForEach(viewModel.newItems) { product in
                    ProductCard(product: product)
                }
            }
        }
    }

    // MARK: - Flash Sale Section
    private var flashSaleSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Flash Sale")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)

                Spacer()

                // Countdown Timer
                HStack(spacing: 4) {
                    FlashSaleCountdownBox(value: viewModel.hours, label: "H")
                    Text(":")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.black)
                    FlashSaleCountdownBox(value: viewModel.minutes, label: "M")
                    Text(":")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.black)
                    FlashSaleCountdownBox(value: viewModel.seconds, label: "S")
                }
            }

            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                ForEach(viewModel.flashSaleProducts) { product in
                    FlashSaleCard(product: product)
                }
            }
        }
    }

    // MARK: - Most Popular Section
    private var mostPopularSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Most Popular")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(viewModel.popularProducts) { product in
                        ProductCardHorizontal(product: product)
                    }
                }
            }
        }
    }

    // MARK: - Just For You Section
    private var justForYou: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Just For You")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(viewModel.recommendedProducts) { product in
                    ProductCard(product: product)
                }
            }
        }
    }

    // MARK: - Bottom Navigation Bar
    private var bottomNavigationBar: some View {
        HStack {
            NavigationTabItem(
                icon: "house.fill",
                title: "Home",
                isSelected: selectedTab == .home
            ) {
                selectedTab = .home
            }

            NavigationTabItem(
                icon: "cart",
                title: "Cart",
                isSelected: selectedTab == .cart
            ) {
                selectedTab = .cart
            }

            NavigationTabItem(
                icon: "square.grid.2x2",
                title: "Categories",
                isSelected: selectedTab == .categories
            ) {
                selectedTab = .categories
            }

            NavigationTabItem(
                icon: "heart",
                title: "Wishlist",
                isSelected: selectedTab == .wishlist
            ) {
                selectedTab = .wishlist
            }

            NavigationTabItem(
                icon: "person",
                title: "Profile",
                isSelected: selectedTab == .profile
            ) {
                selectedTab = .profile
            }
        }
        .frame(height: 60)
        .padding(.horizontal, 8)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: -2)
    }
}

// MARK: - Subviews

struct CategoryCard: View {
    let category: CategoryModel

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(hex: category.color))
                    .frame(height: 100)

                Image(systemName: category.icon)
                    .font(.system(size: 32))
                    .foregroundColor(.white)
            }

            Text(category.name)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.black)

            Text("\(category.count) items")
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.gray.opacity(0.7))
        }
    }
}

struct ProductCard: View {
    let product: ProductModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(hex: product.color))
                    .frame(height: 140)

                Image(systemName: product.icon)
                    .font(.system(size: 40))
                    .foregroundColor(.white.opacity(0.8))
            }

            Text(product.name)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.black)
                .lineLimit(1)

            Text(product.price)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.black)
        }
    }
}

struct ProductCardHorizontal: View {
    let product: ProductModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(hex: product.color))
                    .frame(width: 140, height: 140)

                Image(systemName: product.icon)
                    .font(.system(size: 40))
                    .foregroundColor(.white.opacity(0.8))
            }

            Text(product.name)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.black)
                .lineLimit(1)

            HStack {
                Text(product.price)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)

                Spacer()

                if let rating = product.rating {
                    HStack(spacing: 2) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 10))
                        Text(String(format: "%.1f", rating))
                            .font(.system(size: 10, weight: .medium))
                    }
                    .foregroundColor(.orange)
                }
            }
        }
        .frame(width: 140)
    }
}

struct FlashSaleCard: View {
    let product: ProductModel

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(hex: product.color))
                    .frame(height: 120)

                Image(systemName: product.icon)
                    .font(.system(size: 32))
                    .foregroundColor(.white.opacity(0.8))

                // -20% Badge
                VStack {
                    Text("-20%")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.white)
                }
                .frame(width: 44, height: 24)
                .background(Color(hex: "#FF5757"))
                .cornerRadius(0)
                .position(x: 60, y: 20)
            }

            Text(product.name)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.black)
                .lineLimit(1)

            HStack(spacing: 4) {
                Text(product.price)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.black)

                Text(product.originalPrice)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.gray.opacity(0.5))
                    .strikethrough()
            }
        }
    }
}

struct FlashSaleCountdownBox: View {
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 2) {
            Text(value)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.white)

            Text(label)
                .font(.system(size: 8, weight: .medium))
                .foregroundColor(.white.opacity(0.8))
        }
        .frame(width: 32, height: 32)
        .background(Color.black)
        .cornerRadius(6)
    }
}

struct NavigationTabItem: View {
    let icon: String
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 22))

                Text(title)
                    .font(.system(size: 10, weight: .medium))
            }
            .foregroundColor(isSelected ? Color(hex: "#004CFF") : .gray.opacity(0.5))
            .frame(maxWidth: .infinity)
        }
    }
}

// MARK: - Preview
struct ShopPage_Previews: PreviewProvider {
    static var previews: some View {
        ShopPage()
    }
}
