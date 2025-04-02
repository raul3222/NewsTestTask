//
//  Extension + UIString.swift
//  SebbiaTestTask
//
//  Created by Raul Shafigin on 02.04.2025.
//
import Foundation

extension String {
    func htmlToAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            )
        } catch {
            print("Error decoding: \(error)")
            return nil
        }
    }
}
