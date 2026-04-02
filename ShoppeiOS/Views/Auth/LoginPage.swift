import SwiftUI

struct LoginPage: View {
    @State private var email: String = ""

    var body: some View {
        ZStack {
            // Background
            Color.white

            // Decorative Bubbles
            decorativeBubbles

            VStack(spacing: 0) {
                // Status Bar Spacer
                Spacer().frame(height: 54)

                // Title Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Login")
                        .font(.system(size: 52, weight: .bold))
                        .foregroundColor(Color(hex: "#202020"))

                    HStack(spacing: 8) {
                        Text("Good to see you back!")
                            .font(.system(size: 19, weight: .light))
                            .foregroundColor(Color(hex: "#202020"))

                        Image(systemName: "heart.fill")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(Color(hex: "#202020"))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 68)

                Spacer().frame(height: 40)

                // Email Field
                FormField(
                    placeholder: "Email",
                    text: $email,
                    keyboardType: .emailAddress
                )
                .padding(.horizontal, 20)

                Spacer()

                // Next Button
                Button(action: {
                    // Handle login step 1 - verify email
                }) {
                    Text("Next")
                        .font(.system(size: 22, weight: .light))
                        .foregroundColor(Color(hex: "#F3F3F3"))
                        .frame(height: 61)
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#004CFF"))
                        .cornerRadius(16)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)

                // Cancel Link
                Button(action: {
                    // Navigate back to Start
                }) {
                    Text("Cancel")
                        .font(.system(size: 15, weight: .light))
                        .foregroundColor(Color(hex: "#202020").opacity(0.9))
                }
                .padding(.bottom, 24)
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
                .foregroundColor(Color(hex: "#004CFF").opacity(0.15))
                .frame(width: 400, height: 400)
                .offset(x: -100, y: -150)

            // Bubble 02
            Image(systemName: "circle.fill")
                .resizable()
                .foregroundColor(Color(hex: "#004CFF").opacity(0.1))
                .frame(width: 350, height: 350)
                .offset(x: 200, y: -100)
                .rotationEffect(.degrees(158))

            // Bubble 03
            Image(systemName: "circle.fill")
                .resizable()
                .foregroundColor(Color(hex: "#004CFF").opacity(0.12))
                .frame(width: 180, height: 180)
                .offset(x: 150, y: 50)
                .rotationEffect(.degrees(-156))

            // Bubble 04
            Image(systemName: "circle.fill")
                .resizable()
                .foregroundColor(Color(hex: "#004CFF").opacity(0.08))
                .frame(width: 300, height: 300)
                .offset(x: -50, y: 200)
                .rotationEffect(.degrees(108))
        }
    }
}

// MARK: - Preview
struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
