//
//  Data+Strings.swift
//
//  Created by Jeffrey Thompson on 9/16/22.
//

import Foundation

extension Data {
    var hexString: String {
        let format = "%02hhX"
        return map { String(format: format, $0) }.joined()
    }
}
