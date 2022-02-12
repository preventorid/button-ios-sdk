//
//  String+Extensions.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 15/12/21.
//

import Foundation
import Combine

extension String {
    
    func appendToURL(_ fileURL: URL) throws {
        let data = self.data(using: String.Encoding.utf8)!
        try data.append(fileURL: fileURL)
    }
    
    func parseRichTextElements() -> [PSDKStringBold.Element] {
        var elements: [PSDKStringBold.Element] = []
        do {
            let regex = try NSRegularExpression(pattern: "\\*{1}(.*?)\\*{1}",
                                                options: [.caseInsensitive])
            let range = NSRange(location: 0, length: count)
            let matches: [NSTextCheckingResult] = regex.matches(in: self,
                                                                options: [],
                                                                range: range)
            let matchingRanges = matches.compactMap { Range<Int>($0.range) }

            let firstRange = 0..<(matchingRanges.isEmpty ? count : matchingRanges[0].lowerBound)

            self[firstRange].components(separatedBy: " ").forEach { (word) in
                guard !word.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
                elements.append(PSDKStringBold.Element(content: String(word), isBold: false))
            }
            for (index, matchingRange) in matchingRanges.enumerated() {
                let isLast = matchingRange == matchingRanges.last
                let matchContent = self[matchingRange]
                elements.append(PSDKStringBold.Element(content: matchContent, isBold: true))
                let endLocation = isLast ? count : matchingRanges[index + 1].lowerBound
                let range = matchingRange.upperBound..<endLocation
                self[range].components(separatedBy: " ").forEach { (word) in
                    guard !word.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
                    elements.append(PSDKStringBold.Element(content: String(word), isBold: false))
                }
            }
            return elements
        } catch {
            return elements
        }

    }
    
    subscript(range: Range<Int>) -> String {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        let endIndex = index(self.startIndex, offsetBy: range.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
    func with(_ text: String) -> String {
        return self.replacingOccurrences(of: "(%@)", with: text)
    }
    
    func isValidWithRegex(_ regex: String) -> Bool {
        let range = NSRange(location: 0, length: self.utf16.count)
        guard let regex = try? NSRegularExpression(pattern: regex) else { return true }
        let result = regex.firstMatch(in: self, options: [], range: range) != nil
        return result
    }
    
    func removeCharacters(_ regexPattern: String) -> String {
        do {
            let regex = try NSRegularExpression(pattern: regexPattern, options: .caseInsensitive)
            let newString = regex.stringByReplacingMatches(in: self,
                                                           options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                                           range: NSRange(location: 0, length: self.count),
                                                           withTemplate: "")
            return newString
        } catch {
            return ""
        }
    }
    
    func trimmingWhiteSpaces() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
}
