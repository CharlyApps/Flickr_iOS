//
//  Extensions.swift
//  Flickr
//
//  Created by Carlos Bastida on 21/09/21.
//

import Foundation

extension String {
    ///Extends String to parse content from HTML 
    var HTMLString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return HTMLString?.string ?? ""
    }
}
