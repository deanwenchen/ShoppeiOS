import SwiftUI

struct AddVoucherSheet: View {
    @StateObject private var viewModel = AddVoucherViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var appliedVoucherId: Int?

    var body: some View {
        ZStack {
            // Background overlay
            Color.black
                .opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    dismiss()
                }

            // Bottom Sheet
            VStack(spacing: 0) {
                // Header
                HStack {
                    Text("Active Vouchers")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.black)

                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .background(Color(hex: "#F8FAFF"))
                .cornerRadius(9, corners: [.topLeft, .topRight])

                // Voucher List
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(viewModel.vouchers) { voucher in
                            VoucherCard(
                                voucher: voucher,
                                isApplied: appliedVoucherId == voucher.id,
                                onApply: {
                                    appliedVoucherId = voucher.id
                                }
                            )
                        }
                    }
                    .padding(.horizontal, 9)
                    .padding(.vertical, 16)
                }

                Spacer()
            }
            .background(Color.white)
            .cornerRadius(9, corners: [.topLeft, .topRight])
            .frame(maxWidth: .infinity)
            .offset(y: 0)
        }
    }
}

// MARK: - Voucher Card
struct VoucherCard: View {
    let voucher: Voucher
    let isApplied: Bool
    let onApply: () -> Void

    var body: some View {
        ZStack {
            // Ticket shape background
            TicketShape()
                .fill(Color.white)
                .overlay(
                    TicketShape()
                        .stroke(Color(hex: "#004CFF"), lineWidth: 1)
                )

            VStack(alignment: .leading, spacing: 0) {
                // Top section
                HStack {
                    Text("Voucher")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color(hex: "#004CFF"))

                    Spacer()

                    // Valid until badge
                    Text("Valid Until \(voucher.validUntil)")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.black)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color(hex: "#FFECEC"))
                        .cornerRadius(4)
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)

                // Divider line
                DashedLine()
                    .stroke(Color(hex: "#004CFF"), lineWidth: 0.5)
                    .frame(height: 1)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)

                // Middle section
                HStack(spacing: 12) {
                    // Icon
                    Image(systemName: voucher.icon)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(Color(hex: "#004CFF"))
                        .frame(width: 20)

                    // Title and description
                    VStack(alignment: .leading, spacing: 4) {
                        Text(voucher.title)
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(Color(hex: "#202020"))

                        Text(voucher.description)
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.black)
                    }

                    Spacer()

                    // Apply button
                    Button(action: onApply) {
                        Text(isApplied ? "Applied" : "Apply")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(isApplied ? Color.gray : Color(hex: "#004CFF"))
                            .cornerRadius(6)
                    }
                    .disabled(isApplied)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 12)

                // Bottom validity badge
                HStack {
                    Spacer()

                    Text("Valid Until \(voucher.validUntil)")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.black)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color(hex: "#FFECEC"))
                        .cornerRadius(4)

                    Spacer()
                }
                .padding(.bottom, 8)
            }
        }
        .frame(height: 100)
        .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 2)
    }
}

// MARK: - Ticket Shape
struct TicketShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let radius: CGFloat = 8
        let notchRadius: CGFloat = 12

        // Top left corner
        path.addArc(center: CGPoint(x: radius, y: radius), radius: radius, startAngle: .degrees(180), endAngle: .degrees(270), clockwise: false)

        // Top edge
        path.addLine(to: CGPoint(x: rect.width - radius, y: radius))

        // Top right corner
        path.addArc(center: CGPoint(x: rect.width - radius, y: radius), radius: radius, startAngle: .degrees(270), endAngle: .degrees(360), clockwise: false)

        // Right edge with notch
        path.addLine(to: CGPoint(x: rect.width, y: rect.height * 0.5 - notchRadius))
        path.addArc(center: CGPoint(x: rect.width, y: rect.height * 0.5), radius: notchRadius, startAngle: .degrees(90), endAngle: .degrees(270), clockwise: true)
        path.addLine(to: CGPoint(x: rect.width, y: rect.height - radius))

        // Bottom right corner
        path.addArc(center: CGPoint(x: rect.width - radius, y: rect.height - radius), radius: radius, startAngle: .degrees(0), endAngle: .degrees(90), clockwise: false)

        // Bottom edge
        path.addLine(to: CGPoint(x: radius, y: rect.height))

        // Bottom left corner
        path.addArc(center: CGPoint(x: radius, y: rect.height - radius), radius: radius, startAngle: .degrees(90), endAngle: .degrees(180), clockwise: false)

        // Left edge with notch
        path.addLine(to: CGPoint(x: 0, y: rect.height * 0.5 + notchRadius))
        path.addArc(center: CGPoint(x: 0, y: rect.height * 0.5), radius: notchRadius, startAngle: .degrees(270), endAngle: .degrees(450), clockwise: true)
        path.addLine(to: CGPoint(x: 0, y: radius))

        path.closeSubpath()

        return path
    }
}

// MARK: - Dashed Line
struct DashedLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

// MARK: - Corner Radius Helper
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// MARK: - Preview
struct AddVoucherSheet_Previews: PreviewProvider {
    static var previews: some View {
        AddVoucherSheet()
    }
}
