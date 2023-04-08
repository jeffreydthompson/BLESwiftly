//
//  BLEError.swift
//  BLESwiftly
//
//  Created by Jeffrey Thompson on 1/14/23.
//

import Foundation

public enum BLEError: Swift.Error {
    case bleIsUnauthorized
    case bleIsUnsupported
    case bleUnknownError
    case failedToConnect
    case disconnectError
}
