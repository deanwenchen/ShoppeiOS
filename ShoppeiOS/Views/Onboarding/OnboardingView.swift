import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var appState: AppState
    @State private var currentPage: Int = 0

    let totalPages = 4

    var body: some View {
        ZStack {
            Color.white

            // Decorative Bubbles (always visible in background)
            decorativeBubbles

            VStack(spacing: 0) {
                // Status Bar Spacer
                Spacer().frame(height: 54)

                // TabView for swipeable cards
                TabView(selection: $currentPage) {
                    // Page 1: Hello
                    OnboardingCardView(
                        title: "Hello",
                        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                        imageColor: Color(hex: "#FFD1DC"),
                        imageSize: 421,
                        pageIndex: 0
                    )
                    .tag(0)

                    // Page 2: Explore
                    OnboardingCardView(
                        title: "Explore",
                        description: "Discover amazing products from thousands of categories. Find exactly what you're looking for.",
                        imageColor: Color(hex: "#C1E0FF"),
                        imageSize: 421,
                        pageIndex: 1
                    )
                    .tag(1)

                    // Page 3: Choose
                    OnboardingCardView(
                        title: "Choose",
                        description: "Select your favorite items and add them to your cart. Easy checkout process awaits.",
                        imageColor: Color(hex: "#FFE5CC"),
                        imageSize: 421,
                        pageIndex: 2
                    )
                    .tag(2)

                    // Page 4: Ready
                    OnboardingCardView(
                        title: "Ready?",
                        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        imageColor: Color(hex: "#FFD1DC"),
                        imageSize: 220,
                        pageIndex: 3,
                        showButton: true,
                        onButtonTap: {
                            appState.navigateTo(.shop)
                        }
                    )
                    .tag(3)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .animation(.easeInOut, value: currentPage)

                // Custom Pagination Dots
                HStack(spacing: 10) {
                    ForEach(0..<totalPages, id: \.self) { index in
                        Circle()
                            .fill(index == currentPage ? Color(hex: "#004CFF") : Color(hex: "#E0E0E0"))
                            .frame(width: 20, height: 20)
                            .onTapGesture {
                                withAnimation {
                                    currentPage = index
                                }
                            }
                    }
                }
                .padding(.bottom, 20)

                // Home Indicator
                Spacer().frame(height: 24)

                Capsule()
                    .fill(Color.black)
                    .frame(width: 134, height: 5)
                    .padding(.bottom, 8)
            }
        }
    }

    // MARK: - Decorative Bubbles
    private var decorativeBubbles: some View {
        ZStack {
            // Bubble 01
            Image(systemName: "circle.fill")
                .resizable()
                .foregroundColor(Color(hex: "#004CFF").opacity(0.1))
                .frame(width: 400, height: 400)
                .offset(x: -100, y: -200)
                .rotationEffect(.degrees(92))

            // Bubble 02
            Image(systemName: "circle.fill")
                .resizable()
                .foregroundColor(Color(hex: "#004CFF").opacity(0.12))
                .frame(width: 350, height: 350)
                .offset(x: 100, y: -150)
                .rotationEffect(.degrees(-110))
        }
    }
}

// MARK: - Onboarding Card View
struct OnboardingCardView: View {
    let title: String
    let description: String
    let imageColor: Color
    let imageSize: CGFloat
    let pageIndex: Int
    var showButton: Bool = false
    var onButtonTap: () -> Void = {}

    var body: some View {
        VStack(spacing: 0) {
            // Card Container
            ZStack {
                // Card Background with shadow
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.16), radius: 10, x: 0, y: 10)
                    .frame(width: 377, height: 654)

                VStack(spacing: 0) {
                    // Hero Image
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(imageColor)
                            .frame(width: 377, height: imageSize)

                        // Shopping bag icon based on card
                        Image(systemName: "shopping.bag.fill")
                            .font(.system(size: 80, weight: .regular))
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .cornerRadius(30)
                    .frame(width: 377, height: imageSize)

                    // Content Section
                    VStack(spacing: 0) {
                        // Title
                        Text(title)
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(Color(hex: "#202020"))
                            .padding(.top, 24)

                        // Description
                        Text(description)
                            .font(.system(size: 16, weight: .light))
                            .foregroundColor(Color(hex: "#202020"))
                            .multilineTextAlignment(.center)
                            .lineSpacing(4)
                            .padding(.horizontal, 40)
                            .padding(.top, 12)

                        Spacer()

                        // Let's Start Button (only on last page)
                        if showButton {
                            Button(action: onButtonTap) {
                                Text("Let's Start")
                                    .font(.system(size: 22, weight: .light))
                                    .foregroundColor(Color(hex: "#F3F3F3"))
                                    .frame(height: 61)
                                    .frame(maxWidth: .infinity)
                                    .background(Color(hex: "#004CFF"))
                                    .cornerRadius(16)
                            }
                            .padding(.horizontal, 20)
                            .padding(.bottom, 24)
                        }
                    }
                    .frame(width: 377)
                }
            }
        }
    }
}

// MARK: - Preview
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
