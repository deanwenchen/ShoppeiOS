import SwiftUI

struct PasswordRecoveryCodePage: View {
    @State private var code: String = ""
    @State private var showErrorState: Bool = false
    @State private var errorCount: Int = 0
    @State private var showingMaximumAttemptsAlert: Bool = false
    @State private var navigateToNewPassword: Bool = false
    @FocusState private var isCodeFocused: Bool

    let maxAttempts = 3
    let correctCode = "1234" // Simulated correct verification code

    // Figma Design Assets
    private let avatarImageURL = "https://www.figma.com/api/mcp/asset/34c181ae-660c-41bd-a8e4-8746dfbadca8"
    private let bubble01URL = "https://www.figma.com/api/mcp/asset/b789cd98-34fb-45dc-a553-ed34c3a7bd55"
    private let bubble02URL = "https://www.figma.com/api/mcp/asset/cb8bd147-baaa-43cd-b3ec-9b34cb7b1732"

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

                    // User Avatar from Figma
                    AsyncImage(url: URL(string: avatarImageURL)) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    } placeholder: {
                        Image(systemName: "person.fill")
                            .font(.system(size: 50, weight: .regular))
                            .foregroundColor(Color(hex: "#FFB6C1"))
                            .background(Circle().fill(Color(hex: "#FFD1DC")))
                            .clipShape(Circle())
                    }
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
                        CodeInputDot(
                            isFilled: index < code.count,
                            isError: showErrorState
                        )
                    }
                }
                .padding(.horizontal, 40)
                .overlay(
                    // Hidden text field for actual input with improved accessibility
                    TextField("", text: $code)
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                        .foregroundColor(.clear)
                        .opacity(0)
                        .focused($isCodeFocused)
                        .onChange(of: code) { newValue in
                            if newValue.count > 4 {
                                code = String(newValue.prefix(4))
                            }
                            // Validate when 4 digits entered
                            if newValue.count == 4 {
                                validateCode()
                            }
                        }
                )

                Spacer()

                // Send Again Button
                Button(action: {
                    // Re-send verification code
                    code = ""
                    showErrorState = false
                }) {
                    Text("Send Again")
                        .font(.system(size: 22, weight: .light))
                        .foregroundColor(errorCount >= maxAttempts ? Color(hex: "#F3F3F3").opacity(0.5) : Color(hex: "#F3F3F3"))
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#FF5790"))
                        .cornerRadius(16)
                }
                .disabled(errorCount >= maxAttempts)
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

            // Maximum Attempts Alert Overlay
            if showingMaximumAttemptsAlert {
                ZStack {
                    Color.black.opacity(0.78)

                    alertPopup
                }
                .transition(.opacity)
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            isCodeFocused = true
        }
        .animation(.easeInOut, value: showingMaximumAttemptsAlert)
        .navigationDestination(isPresented: $navigateToNewPassword) {
            NewPasswordPage()
        }
    }

    // MARK: - Code Validation
    private func validateCode() {
        if code == correctCode {
            // Code correct - navigate to new password page
            showErrorState = false
            withAnimation {
                navigateToNewPassword = true
            }
        } else {
            // Code incorrect
            showErrorState = true
            errorCount += 1

            if errorCount >= maxAttempts {
                // Show maximum attempts alert after delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation {
                        showingMaximumAttemptsAlert = true
                    }
                }
            } else {
                // Clear code and error state after delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation {
                        code = ""
                        showErrorState = false
                    }
                }
            }
        }
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

    // MARK: - Alert Popup
    private var alertPopup: some View {
        ZStack {
            // Background
            RoundedRectangle(cornerRadius: 19)
                .fill(Color(hex: "#F8F8F8"))
                .frame(width: 347, height: 225)

            VStack(spacing: 0) {
                // Icon
                ZStack {
                    Circle()
                        .fill(Color(hex: "#FFB6C1"))
                        .frame(width: 80, height: 80)

                    Circle()
                        .fill(Color.white)
                        .frame(width: 50, height: 50)

                    Image(systemName: "exclamationmark")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color(hex: "#FFB6C1"))
                }
                .offset(y: -45)

                // Message
                Text("You reached out maximum amount of attempts. Please, try later.")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(Color(hex: "#202020"))
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .padding(.horizontal, 40)
                    .padding(.top, 16)

                Spacer()

                // Okay Button
                Button(action: {
                    // Navigate back to Login
                }) {
                    Text("Okay")
                        .font(.system(size: 22, weight: .light))
                        .foregroundColor(Color(hex: "#F3F3F3"))
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#202020"))
                        .cornerRadius(16)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
            }
        }
    }
}

// MARK: - Code Input Dot
struct CodeInputDot: View {
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
struct PasswordRecoveryCodePage_Previews: PreviewProvider {
    static var previews: some View {
        PasswordRecoveryCodePage()
    }
}
