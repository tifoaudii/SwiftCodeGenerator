//
//  TokenGenerator.swift
//  SwiftCodeGenerator
//
//  Created by Tifo Audi Alif Putra on 16/06/23.
//

import Foundation

struct TokenGenerator {
    
    private enum TokenType: String {
        case color
        case typography
        case any
        
        var dataType: String {
            switch self {
            case .color:
                return "UIColor"
            case .typography:
                return "UIFont"
            case .any:
                return "Any"
            }
        }
        
        init(value: String) {
            self = TokenType(rawValue: value) ?? .any
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
            let extensionContent = traverse(dictionary: tokenValue, parent: tokenDictionary.key)
            let tokenExtension = createExtension(from: TokenType(value: tokenDictionary.key), content: extensionContent)
        }
    }
    
    
    private static func traverse(dictionary: [String : Any], parent: String) -> String {
        if dictionary.keys.contains("type") {
            let type = dictionary["type"] as! String
            let tokenType: TokenType = TokenType(value: type)
            
            return createLet(dataType: tokenType.dataType, variableName: parent, value: <#T##String#>)
        }
        
        return ""
    }
    
    private static func createValue(from tokenType: TokenType, value: String) -> String {
        switch tokenType {
        case .color:
            return "UIColor.hexColor(\(value))"
        case .typography:
            return "UIFont(name"
        case .any:
            return ""
        }
    }
    
    private static func createLet(dataType: String, variableName: String, value: String) -> String {
        """
        let \(variableName): \(dataType) = \(value)\n
        """
    }
    
    private static func createExtension(from tokenType: TokenType, content: String) -> String {
        """
        extension \(tokenType.dataType) {
        \(content.indent(with: "    "))
        }\n
        """
    }
}

extension String {
    func getFirstWord(separator: Character) -> String {
        String(describing: self.split(separator: ".").first ?? "")
    }
    
    func indent(with indentation: String) -> String {
        return self
            .components(separatedBy: "\n")
            .map { line in line .isEmpty ? "" : "\(indentation)\(line)" }
            .joined(separator: "\n")
    }
    
    func camelCased(with separator: Character) -> String {
        return self.lowercased()
            .split(separator: separator)
            .enumerated()
            .map { $0.offset > 0 ? $0.element.capitalized : $0.element.lowercased() }
            .joined()
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
