//
//  CustomViews.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 18/12/21.
//

import SwiftUI

struct PSDKText: View {
    
    let text: String
    let textColor: Color
    let font: Font
    let alignment: TextAlignment
    
    var body: some View {
        Text(text)
            .font(font)
            .foregroundColor(textColor)
            .multilineTextAlignment(alignment)
            .fixedSize(horizontal: false, vertical: true)
    }
    
    init(_ text: String,
        textColor: Color = .psdkTextColorPrimaryLight,
        font: Font = .psdkH7,
        alignment: TextAlignment = .center) {
        self.text = text
        self.textColor = textColor
        self.font = font
        self.alignment = alignment
    }
    
}

struct CheckBoxView: View {
    
    @Binding var checked: Bool

    var body: some View {
        Image(systemName: checked ? "checkmark.square.fill" : "square")
            .resizable()
            .foregroundColor(checked ? Color(UIColor.systemBlue) : Color.secondary)
            .onTapGesture {
                self.checked.toggle()
            }
            .frame(width: 18, height: 18, alignment: .center)
            .padding(.all, 6)
    }
    
}

struct PSDKStringBold: View {
    
    let elements: [Element]
    let colorHighlighted: Color
    let isBold: Bool
    let colorUnHighlighted: Color
    
    init(_ content: String,
                colorHighlighted: Color,
                isBold: Bool = true,
                colorUnHighlighted: Color = .psdkTextColorPrimaryLight) {
        self.elements = content.parseRichTextElements()
        self.colorHighlighted = colorHighlighted
        self.isBold = isBold
        self.colorUnHighlighted = colorUnHighlighted
    }
    
    struct Element: Identifiable {
        let id = UUID()
        let content: String
        let isBold: Bool

        init(content: String, isBold: Bool ) {
            var content = content.trimmingCharacters(in: .whitespacesAndNewlines)
            if isBold {
                content = content.replacingOccurrences(of: "*", with: "")
            }
            self.content = content
            self.isBold = isBold
        }
    }
    
     var body: some View {
        var content = text(for: elements.first!) as Text
        self.elements.dropFirst().forEach { (element) in
            content = content as Text + (self.text(for: element)) as Text
        }
        return content as Text
  }
    
    private func text(for element: Element) -> Text {
        let postfix = shouldAddSpace(for: element) ? " " : ""
        if element.isBold {
            if self.isBold {
                return
                    Text(element.content + postfix)
                    .fontWeight(.bold)
                    .foregroundColor(self.colorHighlighted)
            } else {
                return
                    Text(element.content + postfix)
                    .foregroundColor(self.colorHighlighted)
            }
        } else {
            return Text(element.content + postfix)
                .foregroundColor(self.colorUnHighlighted)
        }
    }

    private func shouldAddSpace(for element: Element) -> Bool {
        return element.id != elements.last?.id
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }

}
