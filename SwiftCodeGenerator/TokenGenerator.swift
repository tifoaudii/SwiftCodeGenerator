//
//  TokenGenerator.swift
//  SwiftCodeGenerator
//
//  Created by Tifo Audi Alif Putra on 16/06/23.
//

import Foundation

@main
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
        
        var tokenExtensionArray: [String] = []
        for tokenDictionary in dictionary {
            let tokenValue: [String : Any] = tokenDictionary.value as! [String : Any]
            let extensionContent = traverse(dictionary: tokenValue, parent: "")
            tokenExtensionArray.append(createExtension(from: TokenType(value: tokenDictionary.key.lowercased()), content: extensionContent))
        }
        let tokenExtension =
        """
        import UIKit
        
        \(tokenExtensionArray.joined(separator: "\n"))
        """
        
        let fileName: String = "TokenExtension.swift"
        let destinationUrl = "\(FileManager.default.currentDirectoryPath)/\(fileName)"
        
        do {
            try tokenExtension.write(toFile: destinationUrl, atomically: true, encoding: .utf8)
            print("Token Extension is successfully generated:\n \(destinationUrl)\n")
        } catch {
            print(error)
        }
    }
    
    
    private static func traverse(dictionary: [String : Any], parent: String) -> String {
        if dictionary.keys.contains("type") {
            let type = dictionary["type"] as! String
            let tokenType: TokenType = TokenType(value: type)
            switch tokenType {
            case .color:
                let value = dictionary["value"] as! String
                let variableValue =  "UIColor.hexColor(\"\(value)\") ?? .black"
                return createVariable(dataType: tokenType.dataType, variableName: parent.camelCased(with: "."), value: variableValue)
            case .typography:
                let fontName = dictionary["fontName"] as! String
                let size = dictionary["size"] as! String
                let value = "UIFont(name: \"\(fontName)\", size: \(size)) ?? .systemFont(ofSize: \(size))"
                return createVariable(dataType: tokenType.dataType, variableName: parent.camelCased(with: "."), value: value)
            case .any:
                return ""
            }
        }
        
        var contentArray: [String] = []
        for tokenDictionary in dictionary {
            let tokenValue: [String : Any] = tokenDictionary.value as! [String : Any]
            let childParent: String = tokenDictionary.key.appending(".")
            let parent: String = parent.appending(childParent)
            contentArray.append(traverse(dictionary: tokenValue, parent: parent))
        }
        
        return contentArray.joined(separator: "\n")
    }
    
    private static func createVariable(dataType: String, variableName: String, value: String) -> String {
        """
        static var \(variableName): \(dataType) {
        \(value.indent(with: "  "))
        }
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
}
