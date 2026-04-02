import SwiftUI

struct PasswordRecoveryCodePage: View {
    @State private var code: String = ""
    @FocusState private var isCodeFocused: Bool

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

                // Title
                Text("Password Recovery")
                    .font(.system(size: 21, weight: .bold))
                    .foregroundColor(Color(hex: "#202020"))
                    .padding(.top, 24)

                // Subtitle
                Text("Enter 4-digits code we sent you on your phone number")
                    .font(.system(size: 19, weight: .light))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .padding(.horizontal, 40)
                    .padding(.top, 8)

                // Phone Number
                Text("+98*******00")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                    .tracking(1.6)
                    .padding(.top, 16)

                Spacer().frame(height: 32)

                // 4-Digit Code Input
                HStack(spacing: 29) {
                    ForEach(0..<4, id: \.self) { index in
                        CodeInputDot(isFilled: index < code.count)
                    }
                }
                .padding(.horizontal, 40)
                .overlay(
                    // Hidden text field for actual input
                    TextField("", text: $code)
                        .keyboardType(.numberPad)
                        .foregroundColor(.clear)
                        .focused($isCodeFocused)
                        .onChange(of: code) { newValue in
                            if newValue.count > 4 {
                                code = String(newValue.prefix(4))
                            }
                        }
                )

                Spacer()

                // Send Again Button
                Button(action: {
                    // Re-send verification code
                }) {
                    Text("Send Again")
                        .font(.system(size: 22, weight: .light))
                        .foregroundColor(Color(hex: "#F3F3F3"))
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#FF5790"))
                        .cornerRadius(16)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)

                // Cancel Link
                Button(action: {
                    // Navigate back to Login
                }) {
                    Text("Cancel")
                        .font(.system(size: 15, weight: .light))
                        .foregroundColor(Color(hex: "#202020").opacity(0.9))
                }
                .padding(.bottom, 24)
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            isCodeFocused = true
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

// MARK: - Code Input Dot
struct CodeInputDot: View {
    let isFilled: Bool

    var body: some View {
        Circle()
            .fill(isFilled ? Color(hex: "#004CFF") : Color(hex: "#E0E0E0"))
            .frame(width: 17, height: 17)
    }
}

// MARK: - Preview
struct PasswordRecoveryCodePage_Previews: PreviewProvider {
    static var previews: some View {
        PasswordRecoveryCodePage()
    }
}
