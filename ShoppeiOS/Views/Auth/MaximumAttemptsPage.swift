import SwiftUI

struct MaximumAttemptsPage: View {
    @State private var code: String = ""
    @State private var showingAlert: Bool = true
    @FocusState private var isCodeFocused: Bool

    // Figma Design Assets
    private let avatarImageURL = "https://www.figma.com/api/mcp/asset/6d62c92d-cd49-48bf-b759-173dff14b786"
    private let bubble01URL = "https://www.figma.com/api/mcp/asset/9ae0212c-4225-464e-8138-5820fde9e4bc"
    private let bubble02URL = "https://www.figma.com/api/mcp/asset/0659f65d-d1a0-4dea-9ed8-d98269a3cf9c"
    private let warningIconURL = "https://www.figma.com/api/mcp/asset/5338e7b5-8384-470a-a223-9b5321266453"

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
                Text("+84*******00")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.top, 16)

                Spacer().frame(height: 32)

                // 4-Digit Code Input (empty dots)
                HStack(spacing: 29) {
                    ForEach(0..<4, id: \.self) { index in
                        Circle()
                            .fill(Color(hex: "#E0E0E0"))
                            .frame(width: 17, height: 17)
                    }
                }
                .padding(.horizontal, 40)

                Spacer()

                // Send Again Button (disabled style)
                Button(action: {
                    // Disabled - show alert
                }) {
                    Text("Send Again")
                        .font(.system(size: 22, weight: .light))
                        .foregroundColor(Color(hex: "#F3F3F3").opacity(0.5))
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#202020"))
                        .cornerRadius(16)
                }
                .disabled(true)
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

            // Dark Overlay
            Color.black.opacity(0.78)

            // Alert Popup
            alertPopup
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

    // MARK: - Alert Popup
    private var alertPopup: some View {
        ZStack {
            // Background
            RoundedRectangle(cornerRadius: 19)
                .fill(Color(hex: "#F8F8F8"))
                .frame(width: 347, height: 225)

            VStack(spacing: 0) {
                // Warning Icon from Figma
                AsyncImage(url: URL(string: warningIconURL)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .offset(y: -45)
                } placeholder: {
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
                }

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

// MARK: - Preview
struct MaximumAttemptsPage_Previews: PreviewProvider {
    static var previews: some View {
        MaximumAttemptsPage()
    }
}
