//
//  KeychainCredential.swift
//  KeychainKit
//
//  Created by Leo Ho on 2024/1/6.
//

import Foundation

public struct KeychainCredential {
    
    public let service: String
    
    public let account: String
    
    public let password: Data
    
    public let isSyncCloud: Bool
    
    public init(service: String,
                account: String,
                password: Data,
                isSyncCloud: Bool) {
        self.service = service
        self.account = account
        self.password = password
        self.isSyncCloud = isSyncCloud
    }
}
