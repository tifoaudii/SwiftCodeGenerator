//
//  TokenGenerator.swift
//  SwiftCodeGenerator
//
//  Created by Tifo Audi Alif Putra on 16/06/23.
//

import Foundation

struct TokenGenerator {
    
    private enum TokenType {
        case color
        case typography
        
        var dataType: String {
            switch self {
            case .color:
                return "UIColor"
            case .typography:
                return "UIFont"
            }
        }
    }
    
    static func main() {
        loadJsonToken()
    }
    
    private static func loadJsonToken() {
        guard let fileUrl = Bundle.main.url(forResource: "Token", withExtension: "json") else {
            return
        }
        
        guard let jsonData = try? Data(contentsOf: fileUrl) else {
            return
        }
        
        guard let object = try? JSONSerialization.jsonObject(with: jsonData, options: .fragmentsAllowed), let dictionary = object as? [String : Any] else {
            return
        }
        
        
        for tokenDictionary in dictionary {
            let tokenValue: [String : Any] = tokenDictionary.value as! [String : Any]
            
        }
    }
    
    
    private static func traverse(dictionary: [String : Any]) -> String {
        
    }
}
