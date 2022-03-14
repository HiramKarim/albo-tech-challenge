//
//  Extensions.swift
//  AlboMapLocation
//
//  Created by Hiram Castro on 13/03/22.
//

import UIKit

enum LabelType {
    case title
    case tag
    case askedDate
    case insights
    case textbody
    case normal
}

enum ImageType {
    case reputationType
    case commentType
    case viewType
}

extension UILabel {
    
    static func makeLabel(for labelType:LabelType,
                          withText text: String,
                          withTextColor textColor: UIColor,
                          andTextsize fontSize: CGFloat) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        switch labelType {
        case .title:
            label.text = text
            label.textColor = textColor
            label.numberOfLines = 10
            label.font = UIFont.boldSystemFont(ofSize: fontSize)
            break
        case .tag:
            label.text = text
            label.textColor = textColor
            label.numberOfLines = 3
            label.font = UIFont.systemFont(ofSize: fontSize)
            break
        case .askedDate:
            label.text = text
            label.textColor = textColor
            label.font = UIFont.systemFont(ofSize: fontSize)
            break
        case .insights:
            label.text = text
            label.textColor = textColor
            label.font = UIFont.systemFont(ofSize: fontSize)
            break
        case .textbody:
            label.text = text
            label.textColor = textColor
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: fontSize)
            break
        case .normal:
            label.text = text
            label.textColor = textColor
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: fontSize)
            break
        }
        
        return label
    }
    
}

extension UIImageView {
    static func makeImage(for imageType:ImageType) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        switch imageType {
        case .reputationType:
            imageView.image = UIImage(systemName: "arrowtriangle.up.circle")
            break
        case .commentType:
            imageView.image = UIImage(systemName: "text.bubble")
            break
        case .viewType:
            imageView.image = UIImage(systemName: "eye")
            break
        }
        
        
        return imageView
    }
}

extension Date {
    static func convertToFormattedDate(from timeInterval:Double) -> String {
        
        if timeInterval <= 0 {
            return ""
        }
        
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "PST")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}

extension Double {
    func reduceScale(to places: Int) -> Double {
        let multiplier = pow(10, Double(places))
        let newDecimal = multiplier * self
        let truncated = Double(Int(newDecimal))
        let originalDecimal = truncated / multiplier
        return originalDecimal
    }
}

extension Int {
    func formatNumber() -> String {
        let n = self
        let num = abs(Double(n))
        let sign = (n < 0) ? "-" : ""

        switch num {
        case 1_000_000_000...:
            var formatted = num / 1_000_000_000
            formatted = formatted.reduceScale(to: 1)
            return "\(sign)\(formatted)B"

        case 1_000_000...:
            var formatted = num / 1_000_000
            formatted = formatted.reduceScale(to: 1)
            return "\(sign)\(formatted)M"

        case 1_000...:
            var formatted = num / 1_000
            formatted = formatted.reduceScale(to: 1)
            return "\(sign)\(formatted)K"

        case 0...:
            return "\(n)"

        default:
            return "\(sign)\(n)"
        }
    }
}

extension String {
    func htmlAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }

        return try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil
        )
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
