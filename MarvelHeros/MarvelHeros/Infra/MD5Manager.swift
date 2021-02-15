//
//  MD5Manager.swift
//  MarvelHeros
//
//  Created by Geovanni Oliveira de Jesus on 14/02/21.
//  Copyright © 2021 Geovanni Oliveira de Jesus. All rights reserved.
//

import Foundation
import Foundation
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

class MD5Manager{

    func MD5(string: String) -> Data {
            let length = Int(CC_MD5_DIGEST_LENGTH)
            let messageData = string.data(using:.utf8)!
            var digestData = Data(count: length)

            _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
                messageData.withUnsafeBytes { messageBytes -> UInt8 in
                    if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                        let messageLength = CC_LONG(messageData.count)
                        CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                    }
                    return 0
                }
            }
            return digestData
        }

    //Test usage:
//    let md5Data = MD5(string:"13651d395ae9b0cd14cc9130ebacc47dc3f6488e54aedd955fbdad2c757b38f4b1f6e0d12")
//
//    let md5Hex =  md5Data.map { String(format: "%02hhx", $0) }.joined()
}
