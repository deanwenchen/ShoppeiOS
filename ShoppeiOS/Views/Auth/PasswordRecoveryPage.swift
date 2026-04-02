import SwiftUI

struct PasswordRecoveryPage: View {
    @State private var selectedMethod: RecoveryMethod = .sms

    enum RecoveryMethod {
        case sms
        case email
    }

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
                Text("How you would like to restore your password?")
                    .font(.system(size: 19, weight: .light))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .padding(.horizontal, 40)
                    .padding(.top, 8)

                Spacer().frame(height: 40)

                // SMS Option
                RecoveryOptionButton(
                    title: "SMS",
                    isSelected: selectedMethod == .sms,
                    action: {
                        selectedMethod = .sms
                    }
                )

                // Email Option
                RecoveryOptionButton(
                    title: "Email",
                    isSelected: selectedMethod == .email,
                    action: {
                        selectedMethod = .email
                    }
                )

                Spacer()

                // Next Button
                Button(action: {
                    // Navigate to verification code page
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

// MARK: - Recovery Option Button
struct RecoveryOptionButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()

                Text(title)
                    .font(.system(size: 15, weight: isSelected ? .bold : .medium))
                    .foregroundColor(isSelected ? Color(hex: "#004CFF") : .black)

                Spacer()

                // Checkmark indicator
                ZStack {
                    Circle()
                        .fill(isSelected ? Color(hex: "#004CFF") : Color(hex: "#FFE5E5"))
                        .frame(width: 24, height: 24)

                    if isSelected {
                        Image(systemName: "checkmark")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white)
                    } else {
                        Circle()
                            .stroke(Color(hex: "#FFD1D1"), lineWidth: 2)
                            .frame(width: 16, height: 16)
                    }
                }
            }
            .padding(.vertical, 12)
            .frame(height: 40)
            .background(isSelected ? Color(hex: "#E5EBFC") : Color(hex: "#FFE5E5"))
            .cornerRadius(18)
        }
        .padding(.horizontal, 20)
    }
}

// MARK: - Preview
struct PasswordRecoveryPage_Previews: PreviewProvider {
    static var previews: some View {
        PasswordRecoveryPage()
    }
}
