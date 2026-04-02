import SwiftUI

struct ReadyCardPage: View {
    // Figma Design Assets
    private let heroImageURL = "https://www.figma.com/api/mcp/asset/28737776-dbf1-405e-9a30-5fd7efc8c1d3"
    private let bubble01URL = "https://www.figma.com/api/mcp/asset/6a54f1a5-362c-4ba3-94ee-6b6408090fd9"
    private let bubble02URL = "https://www.figma.com/api/mcp/asset/04ab5c04-a9dd-4dd4-a291-887de2732411"
    private let dotInactiveURL = "https://www.figma.com/api/mcp/asset/67292634-f293-4c54-a5dd-6bbbda2f8b1a"
    private let dotActiveURL = "https://www.figma.com/api/mcp/asset/4e3a9432-33f1-454b-89a1-edd5b7403927"
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
                    // Card Background with shadow
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.16), radius: 10, x: 0, y: 10)
                        .frame(width: 377, height: 654)

                    VStack(spacing: 0) {
                        // Hero Image
                        ZStack {
                            // Image of women with shopping bags from Figma
                            AsyncImage(url: URL(string: heroImageURL)) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 377, height: 220)
                                    .clipShape(RoundedRectangle(cornerRadius: 30))
                            } placeholder: {
                                Image(systemName: "person.2.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 377, height: 220)
                            }
                        }
                        .cornerRadius(30)
                        .frame(width: 377, height: 220)

                        // Content Section
                        VStack(spacing: 0) {
                            // Title
                            Text("Ready?")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(Color(hex: "#202020"))
                                .padding(.top, 24)

                            // Description
                            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                                .font(.system(size: 19, weight: .light))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .lineSpacing(4)
                                .padding(.horizontal, 40)
                                .padding(.top, 12)

                            Spacer()

                            // Let's Start Button
                            Button(action: {
                                // Navigate to app
                            }) {
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

                            // Pagination Dots
                            HStack(spacing: 10) {
                                // Inactive dots (gray)
                                ForEach(0..<3, id: \.self) { _ in
                                    Circle()
                                        .fill(Color(hex: "#E0E0E0"))
                                        .frame(width: 20, height: 20)
                                }

                                // Active dot (blue)
                                Circle()
                                    .fill(Color(hex: "#004CFF"))
                                    .frame(width: 20, height: 20)
                            }
                            .padding(.bottom, 20)
                        }
                        .frame(width: 377)
                    }
                }

                // Home Indicator
                Spacer().frame(height: 24)

                // Bottom Bar (Home Indicator)
                Capsule()
                    .fill(Color.black)
                    .frame(width: 134, height: 5)
                    .padding(.bottom, 8)
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
struct ReadyCardPage_Previews: PreviewProvider {
    static var previews: some View {
        ReadyCardPage()
    }
}
