import SwiftUI

struct CreateAccount: View {
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
                    // Handle registration
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

// MARK: - Email Form Field
struct FormField: View {
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        HStack {
            Text(placeholder)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(Color(hex: "#D2D2D2"))

            Spacer()

            TextField("", text: $text)
                .keyboardType(keyboardType)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.black)
                .multilineTextAlignment(.trailing)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color(hex: "#F8F8F8"))
        .cornerRadius(60)
    }
}

// MARK: - Password Field
struct PasswordField: View {
    @Binding var password: String
    @Binding var isPasswordVisible: Bool

    var body: some View {
        HStack(spacing: 12) {
            if isPasswordVisible {
                TextField("Password", text: $password)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
            } else {
                SecureField("Password", text: $password)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
            }

            Spacer()

            Button(action: {
                isPasswordVisible.toggle()
            }) {
                Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(Color(hex: "#D2D2D2"))
                    .frame(width: 24, height: 24)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color(hex: "#F8F8F8"))
        .cornerRadius(60)
    }
}

// MARK: - Phone Number Field
struct PhoneNumberField: View {
    @Binding var phoneNumber: String
    @Binding var countryCode: String
    @Binding var showingCountryPicker: Bool

    var body: some View {
        HStack(spacing: 16) {
            // Country Code Selector
            Button(action: {
                showingCountryPicker = true
            }) {
                HStack(spacing: 8) {
                    // Flag Icon
                    ZStack {
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color(hex: "#F0F0F0"))
                            .frame(width: 24, height: 18)

                        Image(systemName: "flag.fill")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.gray)
                    }

                    Image(systemName: "chevron.down")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color(hex: "#D2D2D2"))
                }
                .frame(height: 24)
            }

            Divider()
                .frame(height: 24)

            Text(countryCode)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(Color(hex: "#202020"))

            Divider()
                .frame(height: 16)

            TextField("Your number", text: $phoneNumber)
                .keyboardType(.phonePad)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.black)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color(hex: "#F8F8F8"))
        .cornerRadius(60)
    }
}

// MARK: - Country Picker View
struct CountryPickerView: View {
    @Binding var selectedCode: String
    @Environment(\.presentationMode) var presentationMode

    let countries: [(code: String, name: String, flag: String)] = [
        ("+1", "United States", "🇺🇸"),
        ("+44", "United Kingdom", "🇬🇧"),
        ("+86", "China", "🇨🇳"),
        ("+91", "India", "🇮"),
        ("+81", "Japan", "🇯🇵"),
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach(countries, id: \.code) { country in
                    Button(action: {
                        selectedCode = country.code
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Text(country.flag)
                                .font(.system(size: 24))
                            Text(country.name)
                                .font(.system(size: 16, weight: .regular))
                            Spacer()
                            if selectedCode == country.code {
                                Image(systemName: "checkmark")
                                    .foregroundColor(Color(hex: "#004CFF"))
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .navigationTitle("Select Country")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - Preview
struct CreateAccount_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccount()
    }
}
