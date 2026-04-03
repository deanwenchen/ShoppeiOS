import SwiftUI

// MARK: - Variation Pill Component
struct VariationPill: View {
    let title: String
    let isSelected: Bool

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.black)
        }
        .frame(width: 60, height: 32)
        .background(Color(hex: "#F9F9F9"))
        .cornerRadius(4)
    }
}

// MARK: - Variation Image Card Component (Simple color version)
struct VariationImageCard: View {
    let color: String
    let isSelected: Bool

    var body: some View {
        ZStack(alignment: .topTrailing) {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color(hex: color))
                .frame(width: 100, height: 100)

            if isSelected {
                Circle()
                    .fill(Color(hex: "#004CFF"))
                    .frame(width: 16, height: 16)
                    .overlay(
                        Image(systemName: "checkmark")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.white)
                    )
                    .offset(x: -4, y: 4)
            }
        }
    }
}

// MARK: - Variation Image Card Component (With Figma image)
struct VariationImageCardWithImage: View {
    let color: String
    let imageColor: String
    let isSelected: Bool

    var body: some View {
        ZStack(alignment: .topTrailing) {
            // Product Image from Figma
            AsyncImage(url: URL(string: ImageURLProvider.getVariationImageURL(for: imageColor))) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
            } placeholder: {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color(hex: imageColor))
                    .frame(width: 100, height: 100)
            }

            // Selection Indicator
            if isSelected {
                Circle()
                    .fill(Color(hex: "#004CFF"))
                    .frame(width: 16, height: 16)
                    .overlay(
                        Image(systemName: "checkmark")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.white)
                    )
                    .offset(x: -4, y: 4)
            }
        }
    }
}

// MARK: - Specification Chip Component
struct SpecificationChip: View {
    let title: String
    let color: String

    var body: some View {
        Text(title)
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(.black)
            .frame(height: 25)
            .padding(.horizontal, 12)
            .background(Color(hex: color))
            .cornerRadius(4)
    }
}

// MARK: - Rating Bar Component
struct RatingBar: View {
    let stars: Int
    let count: Int
    let totalCount: Int

    var body: some View {
        HStack(spacing: 8) {
            Text("\(stars)")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.black)
                .frame(width: 12)

            HStack(spacing: 2) {
                ForEach(0..<5, id: \.self) { index in
                    Image(systemName: index < stars ? "star.fill" : "star")
                        .font(.system(size: 8))
                        .foregroundColor(Color(hex: "#FFB800"))
                }
            }
            .frame(width: 60)

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color(hex: "#E5EBFC"))
                        .frame(height: 6)

                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color(hex: "#004CFF"))
                        .frame(width: geo.size.width * CGFloat(count) / max(totalCount, 1), height: 6)
                }
            }
            .frame(height: 6)

            Text("\(count)")
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.gray)
                .frame(width: 30)
        }
    }
}

// MARK: - Delivery Option Row Component
struct DeliveryOptionRow: View {
    let title: String
    let days: String
    let price: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)

                Spacer()

                Text(days)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.gray)

                Text(price)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.black)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isSelected ? Color(hex: "#004CFF") : Color(hex: "#E5EBFC"), lineWidth: 2)
            )
        }
    }
}
