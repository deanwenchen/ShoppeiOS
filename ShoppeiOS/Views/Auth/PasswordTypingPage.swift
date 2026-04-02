import SwiftUI

struct PasswordTypingPage: View {
    @State private var password: String = ""
    @State private var isPasswordCompleted: Bool = false
    @State private var showErrorState: Bool = false
    @State private var navigateToOnboarding: Bool = false
    @FocusState private var isPasswordFocused: Bool

    // Default test account credentials
    let testAccountEmail = "test@gmail.com"
    let testAccountPassword = "12345678"

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

                // Password Dots (8 dots)
                HStack(spacing: 12) {
                    ForEach(0..<8, id: \.self) { index in
                        PasswordDot(
                            isFilled: index < password.count,
                            isError: showErrorState
                        )
                    }
                }
                .padding(.horizontal, 40)
                .overlay(
                    // Hidden text field for actual input
                    TextField("", text: $password)
                        .foregroundColor(.clear)
                        .keyboardType(.asciiCapable)
                        .focused($isPasswordFocused)
                        .onChange(of: password) { newValue in
                            if newValue.count > 8 {
                                password = String(newValue.prefix(8))
                            }
                            // Check if password is completed
                            if newValue.count == 8 {
                                validatePassword()
                            }
                        }
                )

                // Forgot Password Link (shown on error state)
                if showErrorState {
                    Button(action: {
                        // Navigate to Password Recovery
                    }) {
                        Text("Forgot your password?")
                            .font(.system(size: 15, weight: .light))
                            .foregroundColor(Color(hex: "#202020"))
                    }
                    .padding(.top, 16)
                }

                Spacer()

                // Not You? Button
                Button(action: {
                    // Navigate back to Login
                }) {
                    HStack(spacing: 8) {
                        Text("Not you?")
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
                .padding(.bottom, 40)
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            isPasswordFocused = true
        }
        .navigationDestination(isPresented: $navigateToOnboarding) {
            OnboardingView()
        }
    }

    // MARK: - Password Validation
    private func validatePassword() {
        // Simulate password validation with test account
        if password == testAccountPassword {
            // Password correct - navigate to onboarding
            showErrorState = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation {
                    navigateToOnboarding = true
                }
            }
        } else {
            // Password incorrect - show error
            showErrorState = true
            // Clear password after delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation {
                    password = ""
                    showErrorState = false
                }
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

// MARK: - Password Dot
struct PasswordDot: View {
    let isFilled: Bool
    var isError: Bool = false

    var body: some View {
        Circle()
            .fill(getDotColor())
            .frame(width: 17, height: 17)
    }

    private func getDotColor() -> Color {
        if isError {
            return Color(hex: "#FF3B30") // Red for error
        } else if isFilled {
            return Color(hex: "#004CFF") // Blue for filled
        } else {
            return Color(hex: "#E0E0E0") // Gray for empty
        }
    }
}

// MARK: - Preview
struct PasswordTypingPage_Previews: PreviewProvider {
    static var previews: some View {
        PasswordTypingPage()
    }
}
