//
//  KeychainError.swift
//  KeychainKit
//
//  Created by Leo Ho on 2024/1/6.
//

import Foundation

public enum KeychainError: Error {
    
    case duplicate
    
    case notFound
    
    case unknown(OSStatus)
}
