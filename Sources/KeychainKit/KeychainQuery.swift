//
//  KeychainQuery.swift
//  KeychainKit
//
//  Created by Leo Ho on 2024/1/6.
//

import Foundation

public struct KeychainQuery {
    
    public enum Attribute {
        
        /// kSecAttrAccount
        case attrAccount(AnyObject)
        
        /// kSecAttrService
        case attrService(AnyObject)
        
        /// kSecAttrSynchronizable
        case attrSynchronizable(Bool)
        
        /// kSecClass
        case `class`
        
        /// kSecMatchLimit
        case matchLimit(AnyObject)
        
        /// kSecReturnData
        case returnData(AnyObject)
        
        /// kSecValueData
        case valueData(AnyObject)
        
        public var key: String {
            switch self {
            case .attrAccount(_): return kSecAttrAccount as String
            case .attrService(_): return kSecAttrService as String
            case .attrSynchronizable(_): return kSecAttrSynchronizable as String
            case .class: return kSecClass as String
            case .matchLimit(_): return kSecMatchLimit as String
            case .returnData(_): return kSecReturnData as String
            case .valueData(_): return kSecValueData as String
            }
        }
        
        public var value: AnyObject {
            switch self {
            case .attrAccount(let account): return account
            case .attrService(let service): return service
            case .attrSynchronizable(let isSyncCloud): return isSyncCloud ? kCFBooleanTrue : kCFBooleanFalse
            case .class: return kSecClassGenericPassword
            case .matchLimit(let matchLimit): return matchLimit
            case .returnData(let returnData): return returnData
            case .valueData(let valueData): return valueData
            }
        }
    }
    
    /// Build Keychain item search query
    /// - Parameters:
    ///   - attributes: Array of ``Attribute``
    /// - Returns: Keychain item search query
    public static func build(with attributes: [Attribute]) -> CFDictionary {
        var query: [String : AnyObject] = [:]
        
        attributes.forEach { attr in
            query.updateValue(attr.value, forKey: attr.key)
        }
        
        return query as CFDictionary
    }
}
