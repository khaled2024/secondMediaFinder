//
//  MediaResponse.swift
//  testMyTestTwo
//
//  Created by KhaleD HuSsien on 22/11/2021.
//

import Foundation

struct MediaResponse: Decodable{
    var resultCount: Int
    var results : [Media]
}
