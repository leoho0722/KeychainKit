//
//  Keychain.swift
//  KeychainKit
//
//  Created by Leo Ho on 2024/1/6.
//

import Foundation
import Security

public struct Keychain {
    
    public static func create(with credential: KeychainCredential) throws {
        let query = KeychainQuery.build(with: [
            .class,
            .attrService(credential.service as AnyObject),
            .attrAccount(credential.account as AnyObject),
            .valueData(credential.password as AnyObject),
            .attrSynchronizable(credential.isSyncCloud)
        ])
        
        let status = SecItemAdd(query, nil)
        
        guard status != errSecDuplicateItem else {
            throw KeychainError.duplicate
        }
        
        guard status == errSecSuccess else {
            throw KeychainError.unknown(status)
        }
    }
    
    public static func get(credential: KeychainCredential) throws -> KeychainCredential {
        let query = KeychainQuery.build(with: [
            .class,
            .attrService(credential.service as AnyObject),
            .attrAccount(credential.account as AnyObject),
            .returnData(kCFBooleanTrue),
            .matchLimit(kSecMatchLimitOne),
            .attrSynchronizable(credential.isSyncCloud)
        ])
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status != OSStatus(-25300) else {
            throw KeychainError.notFound
        }
        
        guard status == errSecSuccess else {
            throw KeychainError.unknown(status)
        }
        
        guard let password = result as? Data else {
            throw KeychainError.unknown(status)
        }
        
        return KeychainCredential(service: credential.service,
                                  account: credential.account,
                                  password: password,
                                  isSyncCloud: credential.isSyncCloud)
    }
    
    public static func update(from oldCredential: KeychainCredential,
                              to newCredential: KeychainCredential) throws {
        let query = KeychainQuery.build(with: [
            .class,
            .attrService(oldCredential.service as AnyObject),
            .attrAccount(oldCredential.account as AnyObject),
            .attrSynchronizable(oldCredential.isSyncCloud)
        ])
        
        let updateQuery = KeychainQuery.build(with: [
            .valueData(newCredential.password as AnyObject)
        ])

        let status = SecItemUpdate(query, updateQuery)
        
        guard status == errSecSuccess else {
            throw KeychainError.unknown(status)
        }
    }
    
    public static func delete(with credential: KeychainCredential) throws {
        let query = KeychainQuery.build(with: [
            .class,
            .attrService(credential.service as AnyObject),
            .attrAccount(credential.account as AnyObject),
            .returnData(kCFBooleanTrue),
            .attrSynchronizable(credential.isSyncCloud)
        ])
        
        let status = SecItemDelete(query)
        
        guard status == errSecSuccess else {
            throw KeychainError.unknown(status)
        }
    }
}
