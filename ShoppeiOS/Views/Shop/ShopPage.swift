import SwiftUI

struct ShopPage: View {
    @StateObject private var viewModel = ShopViewModel()
    @State private var selectedTab: Tab = .home

    enum Tab {
        case home, cart, categories, wishlist, profile
    }

    // Figma Design Assets - Decorative Bubbles
    private let bubble01URL = "https://www.figma.com/api/mcp/asset/bf599e97-9f08-4e8f-b400-c045b34f1e41"
    private let bubble02URL = "https://www.figma.com/api/mcp/asset/bf5e0e25-e4c1-4d4e-8154-6eec189478c1"
    private let bubble03URL = "https://www.figma.com/api/mcp/asset/7c3026b7-b34f-4af1-91e6-9ef17b35a5d5"
    private let bubble04URL = "https://www.figma.com/api/mcp/asset/d944b704-3181-4ca2-8e17-79a79b651bee"

    // Big Sale Banner
    private let bigSaleBannerURL = "https://www.figma.com/api/mcp/asset/7c5b023f-18d6-4dcc-b43b-095da0e5d3f5"

    // Category Images
    private let clothingCategoryURL = "https://www.figma.com/api/mcp/asset/515c7479-c460-43f8-9516-cdf902a718e7"
    private let bagsCategoryURL = "https://www.figma.com/api/mcp/asset/2c167bda-5e4f-4072-bcab-fa7a9dc33a97"
    private let shoesCategoryURL = "https://www.figma.com/api/mcp/asset/d0446272-3c77-45ac-95bf-9915af3c8748"
    private let lingerieCategoryURL = "https://www.figma.com/api/mcp/asset/502a4dff-fbd1-458c-8dbf-9cede5ebe3a6"
    private let watchCategoryURL = "https://www.figma.com/api/mcp/asset/f4fad135-50ee-40bf-b2ce-1f6b7c5f16af"
    private let hoodiesCategoryURL = "https://www.figma.com/api/mcp/asset/263d99d7-e666-4995-ae67-2f08597bac1a"

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
                ZStack {
                    // Remote Banner Image from Figma
                    AsyncImage(url: URL(string: bigSaleBannerURL)) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 18))
                    } placeholder: {
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color(hex: viewModel.banners[index].color))
                            .frame(height: 150)
                    }

                    // Banner Text Overlay
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Big Sale")
                            .font(.system(size: 29, weight: .bold))
                            .foregroundColor(.white)

                        Text("Up to 50%")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white)

                        Text("Happening\nNow")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .padding(.leading, 20)
                    .padding(.top, 20)

                    // Decorative Bubbles
                    ZStack {
                        AsyncImage(url: URL(string: bubble02URL)) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 187, height: 221)
                                .rotationEffect(.degrees(72))
                                .opacity(0.8)
                        } placeholder: { EmptyView() }

                        AsyncImage(url: URL(string: bubble03URL)) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 150, height: 150)
                                .opacity(0.6)
                        } placeholder: { EmptyView() }

                        AsyncImage(url: URL(string: bubble04URL)) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 120, height: 120)
                                .opacity(0.7)
                        } placeholder: { EmptyView() }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
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

    // Figma Category Images
    private let clothingImageURL = "https://www.figma.com/api/mcp/asset/515c7479-c460-43f8-9516-cdf902a718e7"
    private let shoesImageURL = "https://www.figma.com/api/mcp/asset/d0446272-3c77-45ac-95bf-9915af3c8748"
    private let bagsImageURL = "https://www.figma.com/api/mcp/asset/2c167bda-5e4f-4072-bcab-fa7a9dc33a97"
    private let lingerieImageURL = "https://www.figma.com/api/mcp/asset/502a4dff-fbd1-458c-8dbf-9cede5ebe3a6"
    private let watchImageURL = "https://www.figma.com/api/mcp/asset/f4fad135-50ee-40bf-b2ce-1f6b7c5f16af"
    private let hoodiesImageURL = "https://www.figma.com/api/mcp/asset/263d99d7-e666-4995-ae67-2f08597bac1a"

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                // Category Image from Figma
                AsyncImage(url: URL(string: getImageURLForCategory())) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                } placeholder: {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(hex: category.color))
                        .frame(height: 100)
                }

                // Fallback icon
                Image(systemName: category.icon)
                    .font(.system(size: 32))
                    .foregroundColor(.white)
                    .opacity(0.8)
            }

            Text(category.name)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.black)

            Text("\(category.count) items")
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.gray.opacity(0.7))
        }
    }

    private func getImageURLForCategory() -> String? {
        switch category.name.lowercased() {
        case "clothing": return clothingImageURL
        case "shoes": return shoesImageURL
        case "bags": return bagsImageURL
        case "lingerie": return lingerieImageURL
        case "watch": return watchImageURL
        case "hoodies": return hoodiesImageURL
        default: return nil
        }
    }
}

struct ProductCard: View {
    let product: ProductModel

    // Figma Product Images for New Items and Just For You
    private let newItemImage1URL = "https://www.figma.com/api/mcp/asset/cb290394-8d14-439a-bee1-a79a86d72bee"
    private let newItemImage2URL = "https://www.figma.com/api/mcp/asset/32bbbac4-6f1b-42ff-9ca4-507a0373407e"
    private let newItemImage3URL = "https://www.figma.com/api/mcp/asset/06cc4f83-9f70-474a-a7b9-e3159576f3c9"

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(hex: product.color))
                    .frame(height: 140)

                // Product Image from Figma
                AsyncImage(url: URL(string: getImageURLForProduct())) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 140)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } placeholder: {
                    Image(systemName: product.icon)
                        .font(.system(size: 40))
                        .foregroundColor(.white.opacity(0.8))
                }
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

    private func getImageURLForProduct() -> String? {
        // Map product colors to Figma images
        if product.color == "#C4D9FF" { return newItemImage1URL } // Blue dress
        if product.color == "#FFE5D9" { return newItemImage2URL } // Orange shoes
        if product.color == "#E8F5E9" { return newItemImage3URL } // Blue bag
        return nil
    }
}

struct TopProductsCircle: View {
    let product: ProductModel

    // Figma Top Products Circular Images
    private let dressesImageURL = "https://www.figma.com/api/mcp/asset/6d40c5af-8db8-49a5-9086-467dbe983d1e"
    private let tshirtsImageURL = "https://www.figma.com/api/mcp/asset/49450d4b-6eef-48d1-ada3-c58bfb01b5ad"
    private let skirtsImageURL = "https://www.figma.com/api/mcp/asset/dd5c57e5-a033-4e29-bfc1-4e4d419f918a"
    private let shoesTopImageURL = "https://www.figma.com/api/mcp/asset/32bbbac4-6f1b-42ff-9ca4-507a0373407e"
    private let bagsTopImageURL = "https://www.figma.com/api/mcp/asset/13b67041-e65f-43b0-8d6c-0a780e83c2e8"

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                // Ellipse background
                Image(systemName: "circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .foregroundColor(Color(hex: product.color).opacity(0.2))

                // Category Image from Figma
                AsyncImage(url: URL(string: getImageURLForProduct())) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                } placeholder: {
                    Image(systemName: product.icon)
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                }
            }

            Text(product.name)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
        }
    }

    private func getImageURLForProduct() -> String? {
        switch product.name.lowercased() {
        case "dresses": return dressesImageURL
        case "t-shirts": return tshirtsImageURL
        case "skirts": return skirtsImageURL
        case "shoes": return shoesTopImageURL
        case "bags": return bagsTopImageURL
        default: return nil
        }
    }
}

struct ProductCardHorizontal: View {
    let product: ProductModel

    // Figma Product Images
    private let productImage1URL = "https://www.figma.com/api/mcp/asset/dc6393f8-a85f-475b-bb60-2237636fa5cd"
    private let productImage2URL = "https://www.figma.com/api/mcp/asset/32b61747-b21e-46a0-8e34-66285a5c34ef"
    private let productImage3URL = "https://www.figma.com/api/mcp/asset/28648f25-2e50-41df-ab64-47a01604e177"
    private let productImage4URL = "https://www.figma.com/api/mcp/asset/e8d306ac-6951-4859-bc21-a97cb0b9f0a1"
    private let productImage5URL = "https://www.figma.com/api/mcp/asset/d0a76a4c-82ac-4b50-820f-f905a089aedd"

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(hex: product.color))
                    .frame(width: 140, height: 140)

                // Product Image from Figma
                AsyncImage(url: URL(string: getImageURLForProduct())) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 140, height: 140)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } placeholder: {
                    Image(systemName: product.icon)
                        .font(.system(size: 40))
                        .foregroundColor(.white.opacity(0.8))
                }
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

    private func getImageURLForProduct() -> String? {
        // Map product names/colors to Figma images
        if product.color == "#FFB6C1" { return productImage1URL }
        if product.color == "#FFD1DC" { return productImage2URL }
        if product.color == "#E8F5E9" { return productImage3URL }
        if product.color == "#FFF3E0" { return productImage4URL }
        if product.color == "#F3E5F5" { return productImage5URL }
        return nil
    }
}

struct FlashSaleCard: View {
    let product: ProductModel

    // Figma Flash Sale Product Images
    private let flashSaleImage1URL = "https://www.figma.com/api/mcp/asset/ef4be338-182e-4849-b34e-083e91f79a10"
    private let flashSaleImage2URL = "https://www.figma.com/api/mcp/asset/7bb3c83f-38e6-424d-9ac7-733081ad914d"
    private let flashSaleImage3URL = "https://www.figma.com/api/mcp/asset/b097aa94-ecfc-4036-91b9-a7c184cfd8a3"
    private let flashSaleImage4URL = "https://www.figma.com/api/mcp/asset/671da4b3-5bab-4c53-a4b1-62de943c0987"
    private let flashSaleImage5URL = "https://www.figma.com/api/mcp/asset/4299926c-9ffe-4e8c-904e-7cf1a9dc4a01"
    private let flashSaleImage6URL = "https://www.figma.com/api/mcp/asset/c07b363e-2aae-48bf-b544-40a0063615b4"

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(hex: product.color))
                    .frame(height: 120)

                // Product Image from Figma
                AsyncImage(url: URL(string: getImageURLForProduct())) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } placeholder: {
                    Image(systemName: product.icon)
                        .font(.system(size: 32))
                        .foregroundColor(.white.opacity(0.8))
                }

                // -20% Badge
                VStack {
                    Text("-20%")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.white)
                }
                .frame(width: 44, height: 24)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color(hex: "#FF5790"), Color(hex: "#F81140")]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
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

    private func getImageURLForProduct() -> String? {
        // Map product colors to Figma flash sale images
        if product.color == "#FFB6C1" { return flashSaleImage1URL }
        if product.color == "#FFD1DC" { return flashSaleImage2URL }
        if product.color == "#C4D9FF" { return flashSaleImage3URL }
        if product.color == "#FFE5D9" { return flashSaleImage4URL }
        if product.color == "#E8F5E9" { return flashSaleImage5URL }
        if product.color == "#FFF3E0" { return flashSaleImage6URL }
        return nil
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

    // Figma Navigation Icons
    private let homeImageURL = "https://www.figma.com/api/mcp/asset/d0446272-3c77-45ac-95bf-9915af3c8748"
    private let cartImageURL = "https://www.figma.com/api/mcp/asset/5530134b-5581-4e7c-bd44-e510764a72df"
    private let categoriesImageURL = "https://www.figma.com/api/mcp/asset/2c167bda-5e4f-4072-bcab-fa7a9dc33a97"
    private let wishlistImageURL = "https://www.figma.com/api/mcp/asset/502a4dff-fbd1-458c-8dbf-9cede5ebe3a6"
    private let profileImageURL = "https://www.figma.com/api/mcp/asset/f4fad135-50ee-40bf-b2ce-1f6b7c5f16af"

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                // Figma Icon Image
                AsyncImage(url: URL(string: getImageURLForIcon())) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 22, height: 22)
                        .foregroundColor(isSelected ? Color(hex: "#004CFF") : .gray.opacity(0.5))
                } placeholder: {
                    Image(systemName: icon)
                        .font(.system(size: 22))
                }

                Text(title)
                    .font(.system(size: 10, weight: .medium))
            }
            .foregroundColor(isSelected ? Color(hex: "#004CFF") : .gray.opacity(0.5))
            .frame(maxWidth: .infinity)
        }
    }

    private func getImageURLForIcon() -> String? {
        switch icon {
        case "house.fill": return homeImageURL
        case "cart": return cartImageURL
        case "square.grid.2x2": return categoriesImageURL
        case "heart": return wishlistImageURL
        case "person": return profileImageURL
        default: return nil
        }
    }
}

// MARK: - Preview
struct ShopPage_Previews: PreviewProvider {
    static var previews: some View {
        ShopPage()
    }
}
