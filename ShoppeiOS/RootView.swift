import SwiftUI

/// Main Root View using NavigationStack for the entire app
struct RootView: View {
    @StateObject private var appState = AppState()

    var body: some View {
        NavigationStack(path: $appState.navigationPath) {
            StartPage()
                .navigationBarHidden(true)
                .navigationDestination(for: AppDestination.self) { destination in
                    destination.view
                }
        }
        .environmentObject(appState)
    }
}

// MARK: - App State Manager
@MainActor
class AppState: ObservableObject {
    @Published var navigationPath = NavigationPath()
    @Published var isLoggedIn: Bool = false
    @Published var userEmail: String = ""

    func navigateTo(_ destination: AppDestination) {
        navigationPath.append(destination)
    }

    func popToRoot() {
        navigationPath = NavigationPath()
    }

    func logout() {
        isLoggedIn = false
        userEmail = ""
        popToRoot()
    }
}

// MARK: - App Destinations
enum AppDestination: Hashable {
    case createAccount
    case login
    case password
    case passwordTyping
    case wrongPassword
    case passwordRecovery
    case passwordRecoveryCode
    case newPassword
    case maximumAttempts
    case onboarding
    case shop
    case productDetail
    case cart
    case payment
    case productVariations
    case reviews

    @ViewBuilder
    var view: some View {
        switch self {
        case .createAccount:
            CreateAccount()
        case .login:
            LoginPage()
        case .password:
            PasswordPage()
        case .passwordTyping:
            PasswordTypingPage()
        case .wrongPassword:
            WrongPasswordPage()
        case .passwordRecovery:
            PasswordRecoveryPage()
        case .passwordRecoveryCode:
            PasswordRecoveryCodePage()
        case .newPassword:
            NewPasswordPage()
        case .maximumAttempts:
            MaximumAttemptsPage()
        case .onboarding:
            OnboardingView()
        case .shop:
            ShopPage()
        case .productDetail:
            ProductDetailPage()
        case .cart:
            CartPage()
        case .payment:
            PaymentPage()
        case .productVariations:
            ProductVariationsPage()
        case .reviews:
            ReviewsSheet()
        }
    }
}

// MARK: - Preview
#Preview {
    RootView()
}
