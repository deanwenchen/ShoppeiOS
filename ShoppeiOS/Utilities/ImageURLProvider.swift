import SwiftUI

/// Image URL Provider for Figma remote assets
/// Provides centralized management for all product image URLs
struct ImageURLProvider {
    /// Get product image URL by color
    /// - Parameter color: Hex color string (e.g., "#FFB6C1")
    /// - Returns: Figma CDN URL for the product image
    static func getProductImageURL(for color: String) -> String {
        switch color.uppercased().trimmingCharacters(in: .whitespaces) {
        case "#FFB6C1": // Pink
            return "https://www.figma.com/api/mcp/asset/ed3e9463-9a3b-43ba-90b9-da37bf20ccaa"
        case "#B6D4FF": // Blue
            return "https://www.figma.com/api/mcp/asset/e3719d83-504e-4f54-a3b0-1b4760a4d9cb"
        case "#FFF4B6": // Yellow
            return "https://www.figma.com/api/mcp/asset/95dc9ed1-944f-49ec-b9f6-43b9e090d3da"
        case "#FFD1DC": // Light Pink
            return "https://www.figma.com/api/mcp/asset/d80951b1-d8df-4011-b71e-8824a19e43f1"
        case "#E8F5E9": // Green
            return "https://www.figma.com/api/mcp/asset/c8d6c11f-0ac9-411e-9169-335a6e032f55"
        case "#FFD4C5": // Peach
            return "https://www.figma.com/api/mcp/asset/c8d6c11f-0ac9-411e-9169-335a6e032f55"
        case "#FF6B6B": // Coral
            return "https://www.figma.com/api/mcp/asset/ed3e9463-9a3b-43ba-90b9-da37bf20ccaa"
        case "#FFD700": // Gold
            return "https://www.figma.com/api/mcp/asset/95dc9ed1-944f-49ec-b9f6-43b9e090d3da"
        default:
            return "https://www.figma.com/api/mcp/asset/d80951b1-d8df-4011-b71e-8824a19e43f1"
        }
    }

    /// Get variation thumbnail image URL by color
    /// - Parameter color: Hex color string (e.g., "#FFB6C1")
    /// - Returns: Figma CDN URL for the variation thumbnail
    static func getVariationImageURL(for color: String) -> String {
        switch color.uppercased().trimmingCharacters(in: .whitespaces) {
        case "#FFB6C1": // Pink
            return "https://www.figma.com/api/mcp/asset/ed3e9463-9a3b-43ba-90b9-da37bf20ccaa"
        case "#B6D4FF": // Blue
            return "https://www.figma.com/api/mcp/asset/e3719d83-504e-4f54-a3b0-1b4760a4d9cb"
        case "#FFF4B6": // Yellow
            return "https://www.figma.com/api/mcp/asset/95dc9ed1-944f-49ec-b9f6-43b9e090d3da"
        default:
            return "https://www.figma.com/api/mcp/asset/ed3e9463-9a3b-43ba-90b9-da37bf20ccaa"
        }
    }

    /// Get decorative bubble image URL by ID
    /// - Parameter id: Bubble identifier (01-04)
    /// - Returns: Figma CDN URL for the decorative bubble
    static func getBubbleImageURL(id: String) -> String {
        switch id {
        case "01": return "https://www.figma.com/api/mcp/asset/519160aa-3a48-4b71-9e85-b0e06d486ccc"
        case "02": return "https://www.figma.com/api/mcp/asset/a43f07da-7d51-4897-add2-7141a47f82cc"
        case "03": return "https://www.figma.com/api/mcp/asset/7c3026b7-b34f-4af1-91e6-9ef17b35a5d5"
        case "04": return "https://www.figma.com/api/mcp/asset/d944b704-3181-4ca2-8e17-79a79b651bee"
        default: return "https://www.figma.com/api/mcp/asset/519160aa-3a48-4b71-9e85-b0e06d486ccc"
        }
    }

    /// Get onboarding hero image URL
    /// - Parameter page: Page identifier ("hello" or "ready")
    /// - Returns: Figma CDN URL for the hero image
    static func getOnboardingHeroImageURL(page: String) -> String {
        switch page.lowercased() {
        case "hello": return "https://www.figma.com/api/mcp/asset/2573f889-36e4-4317-ad75-a6b0c7cd4ed0"
        case "ready": return "https://www.figma.com/api/mcp/asset/28737776-dbf1-405e-9a30-5fd7efc8c1d3"
        default: return "https://www.figma.com/api/mcp/asset/2573f889-36e4-4317-ad75-a6b0c7cd4ed0"
        }
    }
}
