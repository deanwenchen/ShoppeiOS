import SwiftUI

struct PasswordPage: View {
    @EnvironmentObject var appState: AppState
    @State private var password: String = ""
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

                // Password Input Boxes (4 boxes for 4-digit initial state)
                HStack(spacing: 5) {
                    ForEach(0..<4, id: \.self) { index in
                        PasswordBox(
                            character: getPasswordCharacter(at: index),
                            isActive: password.count == index
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
                        }
                )

                Spacer()

                // Not You? Button
                Button(action: {
                    appState.popToRoot()
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
        .onAppear {
            isPasswordFocused = true
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

    // MARK: - Helper Methods
    private func getPasswordCharacter(at index: Int) -> Character? {
        guard index < password.count else { return nil }
        return password[password.index(password.startIndex, offsetBy: index)]
    }
}

// MARK: - Password Box
struct PasswordBox: View {
    let character: Character?
    let isActive: Bool

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color(hex: "#F8F8F8"))
            .frame(width: 50, height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        isActive ? Color(hex: "#004CFF") : Color.clear,
                        lineWidth: 2
                    )
            )
            .overlay(
                Group {
                    if character != nil {
                        Circle()
                            .fill(Color(hex: "#004CFF"))
                            .frame(width: 12, height: 12)
                    }
                }
            )
    }
}

// MARK: - Preview
struct PasswordPage_Previews: PreviewProvider {
    static var previews: some View {
        PasswordPage()
    }
}
