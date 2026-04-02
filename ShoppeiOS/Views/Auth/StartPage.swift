import SwiftUI

struct StartPage: View {
    var body: some View {
        ZStack {
            // Background
            Color.white

            VStack(spacing: 0) {
                // Status Bar Spacer
                Spacer().frame(height: 54)

                // Logo
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 4)
                        .frame(width: 160, height: 160)

                    Image(systemName: "shopping.bag.fill")
                        .font(.system(size: 80, weight: .regular))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color(hex: "#4D8AFF"), Color(hex: "#004CFF")],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                }
                .padding(.top, 60)

                // Title
                Text("Shoppe")
                    .font(.system(size: 52, weight: .bold))
                    .foregroundColor(Color(hex: "#202020"))
                    .padding(.top, 40)

                // Subtitle
                Text("Beautiful eCommerce UI Kit for your online store")
                    .font(.system(size: 19, weight: .light))
                    .foregroundColor(Color(hex: "#202020"))
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .padding(.horizontal, 40)
                    .padding(.top, 16)

                Spacer()

                // Main Button
                Button(action: {
                    // Navigate to Create Account
                }) {
                    Text("Let's get started")
                        .font(.system(size: 22, weight: .light))
                        .foregroundColor(Color(hex: "#F3F3F3"))
                        .frame(height: 61)
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#004CFF"))
                        .cornerRadius(16)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)

                // I already have an account
                Button(action: {
                    // Navigate to Login
                }) {
                    HStack(spacing: 12) {
                        Text("I already have an account")
                            .font(.system(size: 15, weight: .light))
                            .foregroundColor(Color(hex: "#202020").opacity(0.9))

                        ZStack {
                            Circle()
                                .fill(Color(hex: "#004CFF"))
                                .frame(width: 30, height: 30)

                            Image(systemName: "arrow.right")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.bottom, 24)
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Preview
struct StartPage_Previews: PreviewProvider {
    static var previews: some View {
        StartPage()
    }
}
