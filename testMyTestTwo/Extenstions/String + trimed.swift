//
//  String + trimed.swift
//  testMyTestTwo
//
//  Created by KhaleD HuSsien on 27/10/2021.
//

import Foundation
//
extension String {
    var trimed: String {
        return self.trimmingCharacters(in: .whitespaces)
    }
}
