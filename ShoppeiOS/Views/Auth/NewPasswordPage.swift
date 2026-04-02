import SwiftUI

struct NewPasswordPage: View {
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var isNewPasswordVisible: Bool = false
    @State private var isConfirmPasswordVisible: Bool = false

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
                Text("Setup New Password")
                    .font(.system(size: 21, weight: .bold))
                    .foregroundColor(Color(hex: "#202020"))
                    .padding(.top, 24)

                // Subtitle
                Text("Please, setup a new password for your account")
                    .font(.system(size: 19, weight: .light))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .padding(.horizontal, 40)
                    .padding(.top, 8)

                Spacer().frame(height: 40)

                // New Password Field
                PasswordInputField(
                    placeholder: "New Password",
                    password: $newPassword,
                    isPasswordVisible: $isNewPasswordVisible
                )
                .padding(.horizontal, 20)

                // Confirm Password Field
                PasswordInputField(
                    placeholder: "Repeat Password",
                    password: $confirmPassword,
                    isPasswordVisible: $isConfirmPasswordVisible
                )
                .padding(.horizontal, 20)

                Spacer()

                // Save Button
                Button(action: {
                    // Handle save new password
                }) {
                    Text("Save")
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

// MARK: - Password Input Field
struct PasswordInputField: View {
    let placeholder: String
    @Binding var password: String
    @Binding var isPasswordVisible: Bool

    var body: some View {
        HStack {
            if isPasswordVisible {
                TextField(placeholder, text: $password)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.black)
            } else {
                SecureField(placeholder, text: $password)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.black)
            }

            Spacer()

            Button(action: {
                isPasswordVisible.toggle()
            }) {
                Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(Color(hex: "#DCDCDC"))
                    .frame(width: 24, height: 24)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 15)
        .background(Color(hex: "#F8F8F8"))
        .cornerRadius(9)
    }
}

// MARK: - Preview
struct NewPasswordPage_Previews: PreviewProvider {
    static var previews: some View {
        NewPasswordPage()
    }
}
