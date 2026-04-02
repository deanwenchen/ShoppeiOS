import SwiftUI

struct WrongPasswordPage: View {
    @State private var password: String = ""
    @State private var showErrorState: Bool = true
    @FocusState private var isPasswordFocused: Bool

    var body: some View {
        ZStack {
            // Background
            Color.white

            // Decorative Bubbles
            decorativeBubbles

            VStack(spacing: 0) {
                // Status Bar Spacer
                Spacer().frame(height: 54)

                // Profile Image
                ZStack {
                    Circle()
                        .fill(Color(hex: "#F8F8F8"))
                        .frame(width: 110, height: 110)

                    Circle()
                        .stroke(Color.white, lineWidth: 4)
                        .frame(width: 100, height: 100)

                    // User Avatar
                    Image(systemName: "person.fill")
                        .font(.system(size: 50, weight: .regular))
                        .foregroundColor(Color(hex: "#FFB6C1"))
                        .background(Circle().fill(Color(hex: "#FFD1DC")))
                        .clipShape(Circle())
                }
                .padding(.top, 60)

                // Welcome Text
                Text("Hello, Romina!!")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(Color(hex: "#202020"))
                    .padding(.top, 24)

                // Instruction
                Text("Type your password")
                    .font(.system(size: 19, weight: .light))
                    .foregroundColor(.black)
                    .padding(.top, 8)

                Spacer().frame(height: 40)

                // Password Dots (8 dots - RED for error state)
                HStack(spacing: 12) {
                    ForEach(0..<8, id: \.self) { index in
                        Circle()
                            .fill(Color(hex: "#FF3B30"))
                            .frame(width: 17, height: 17)
                    }
                }
                .padding(.horizontal, 40)

                // Forgot Password Link
                Button(action: {
                    // Navigate to Password Recovery
                }) {
                    Text("Forgot your password?")
                        .font(.system(size: 15, weight: .light))
                        .foregroundColor(Color(hex: "#202020"))
                }
                .padding(.top, 16)

                Spacer()

                // Bottom spacing for keyboard
                Spacer().frame(height: 291)
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
                .offset(x: -150, y: -150)
                .rotationEffect(.degrees(158))

            // Bubble 02
            Image(systemName: "circle.fill")
                .resizable()
                .foregroundColor(Color(hex: "#004CFF").opacity(0.12))
                .frame(width: 350, height: 350)
                .offset(x: -100, y: -100)
                .rotationEffect(.degrees(108))
        }
    }
}

// MARK: - Preview
struct WrongPasswordPage_Previews: PreviewProvider {
    static var previews: some View {
        WrongPasswordPage()
    }
}
