import SwiftUI

struct CreateAccount: View {
    @EnvironmentObject var appState: AppState
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var phoneNumber: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var showingCountryPicker: Bool = false
    @State private var selectedCountryCode: String = "+44"

    var body: some View {
        ZStack {
            // Background
            Color.white

            // Decorative Bubbles
            decorativeBubbles

            VStack(spacing: 0) {
                // Status Bar Spacer
                Spacer().frame(height: 54)

                // Title
                VStack(spacing: 0) {
                    Text("Create")
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(Color(hex: "#202020"))

                    Text("Account")
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(Color(hex: "#202020"))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 30)
                .padding(.top, 14)

                Spacer().frame(height: 60)

                // Upload Photo
                uploadPhotoSection

                Spacer().frame(height: 32)

                // Form Fields
                formFields

                Spacer()

                // Done Button
                Button(action: {
                    // Handle registration - navigate to onboarding
                    appState.navigateTo(.onboarding)
                }) {
                    Text("Done")
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
                    appState.popToRoot()
                }) {
                    Text("Cancel")
                        .font(.system(size: 15, weight: .light))
                        .foregroundColor(Color(hex: "#202020").opacity(0.9))
                }
                .padding(.bottom, 24)
            }
        }
        .sheet(isPresented: $showingCountryPicker) {
            CountryPickerView(selectedCode: $selectedCountryCode)
        }
    }

    // MARK: - Decorative Bubbles
    private var decorativeBubbles: some View {
        Image(systemName: "circle.fill")
            .resizable()
            .foregroundColor(Color(hex: "#004CFF"))
            .opacity(0.1)
            .frame(width: 300, height: 300)
            .offset(x: 150, y: -100)
    }

    // MARK: - Upload Photo Section
    private var uploadPhotoSection: some View {
        ZStack {
            Circle()
                .stroke(Color(hex: "#004CFF"), lineWidth: 2)
                .fill(Color.white)
                .frame(width: 90, height: 90)
                .overlay(
                    Circle()
                        .stroke(Color(hex: "#004CFF"), lineWidth: 2)
                        .strokeStyle(dash: [8, 4])
                )

            Image(systemName: "camera.fill")
                .font(.system(size: 34, weight: .regular))
                .foregroundColor(Color(hex: "#004CFF"))
        }
        .padding(.horizontal, 30)
    }

    // MARK: - Form Fields
    private var formFields: some View {
        VStack(spacing: 8) {
            // Email Field
            FormField(
                placeholder: "Email",
                text: $email,
                keyboardType: .emailAddress
            )

            // Password Field
            PasswordField(
                password: $password,
                isPasswordVisible: $isPasswordVisible
            )

            // Phone Number Field
            PhoneNumberField(
                phoneNumber: $phoneNumber,
                countryCode: $selectedCountryCode,
                showingCountryPicker: $showingCountryPicker
            )
        }
        .padding(.horizontal, 20)
    }
}

// MARK: - Preview
struct CreateAccount_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccount()
    }
}
