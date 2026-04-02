import SwiftUI

struct HelloCardPage: View {
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

                            // Woman with shopping bags image
                            Image(systemName: "person.2.fill")
                                .font(.system(size: 150, weight: .regular))
                                .foregroundColor(Color(hex: "#FFB6C1"))
                                .frame(width: 200, height: 300)
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

// MARK: - Preview
struct HelloCardPage_Previews: PreviewProvider {
    static var previews: some View {
        HelloCardPage()
    }
}
