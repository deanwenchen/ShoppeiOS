import SwiftUI

struct HelloCardPage: View {
    // Figma Design Assets
    private let heroImageURL = "https://www.figma.com/api/mcp/asset/2573f889-36e4-4317-ad75-a6b0c7cd4ed0"
    private let bubble01URL = "https://www.figma.com/api/mcp/asset/519160aa-3a48-4b71-9e85-b0e06d486ccc"
    private let bubble02URL = "https://www.figma.com/api/mcp/asset/a43f07da-7d51-4897-add2-7141a47f82cc"
    private let dotInactiveURL = "https://www.figma.com/api/mcp/asset/af888051-ebcf-4abb-b055-bb6a49f058a2"
    private let dotActiveURL = "https://www.figma.com/api/mcp/asset/e1a3cc67-c083-4419-88bd-ff0acc1c24ed"
    var body: some View {
        ZStack {
            // Background
            Color.white

            // Decorative Bubbles
            decorativeBubbles

            VStack(spacing: 0) {
                // Status Bar Spacer
                Spacer().frame(height: 54)

                // Card Container
                ZStack {
                    // Card Background
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.white)
                        .frame(width: 377, height: 654)

                    VStack(spacing: 0) {
                        // Hero Image
                        ZStack {
                            // Pink background
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color(hex: "#FFD1DC"))
                                .frame(width: 377, height: 421)

                            // Woman with shopping bags image from Figma
                            AsyncImage(url: URL(string: heroImageURL)) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 377, height: 421)
                                    .clipShape(RoundedRectangle(cornerRadius: 30))
                            } placeholder: {
                                Image(systemName: "person.2.fill")
                                    .font(.system(size: 150, weight: .regular))
                                    .foregroundColor(Color(hex: "#FFB6C1"))
                                    .frame(width: 200, height: 300)
                            }
                        }
                        .cornerRadius(30)

                        // Content Section
                        VStack(spacing: 0) {
                            // Title
                            Text("Hello")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(Color(hex: "#202020"))
                                .padding(.top, 24)

                            // Description
                            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                                .font(.system(size: 16, weight: .light))
                                .foregroundColor(Color(hex: "#202020"))
                                .multilineTextAlignment(.center)
                                .lineSpacing(4)
                                .padding(.horizontal, 40)
                                .padding(.top, 12)

                            Spacer()

                            // Pagination Dots
                            HStack(spacing: 8) {
                                // Active dot (blue)
                                Circle()
                                    .fill(Color(hex: "#004CFF"))
                                    .frame(width: 8, height: 8)

                                // Inactive dots (gray)
                                ForEach(1..<4, id: \.self) { _ in
                                    Circle()
                                        .fill(Color(hex: "#E0E0E0"))
                                        .frame(width: 8, height: 8)
                                }
                            }
                            .padding(.bottom, 24)
                        }
                        .frame(width: 377)
                    }
                }

                Spacer()
            }
        }
        .navigationBarHidden(true)
    }

    // MARK: - Decorative Bubbles
    private var decorativeBubbles: some View {
        ZStack {
            // Bubble 01
            AsyncImage(url: URL(string: bubble01URL)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 400, height: 400)
                    .offset(x: -100, y: -200)
                    .rotationEffect(.degrees(92))
                    .opacity(0.1)
            } placeholder: {
                Circle()
                    .fill(Color(hex: "#004CFF").opacity(0.1))
                    .frame(width: 400, height: 400)
                    .offset(x: -100, y: -200)
                    .rotationEffect(.degrees(92))
            }

            // Bubble 02
            AsyncImage(url: URL(string: bubble02URL)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 350, height: 350)
                    .offset(x: 100, y: -150)
                    .rotationEffect(.degrees(-110))
                    .opacity(0.12)
            } placeholder: {
                Circle()
                    .fill(Color(hex: "#004CFF").opacity(0.12))
                    .frame(width: 350, height: 350)
                    .offset(x: 100, y: -150)
                    .rotationEffect(.degrees(-110))
            }
        }
    }
}

// MARK: - Preview
struct HelloCardPage_Previews: PreviewProvider {
    static var previews: some View {
        HelloCardPage()
    }
}
