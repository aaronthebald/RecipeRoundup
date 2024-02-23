//
//  ProAccessManager.swift
//  Cake
//
//  Created by Aaron Wilson on 2/23/24.
//

import Foundation

class ProAccessManager: ObservableObject {
    @Published var isProAccess = false
    init(isProAccess: Bool = false) {
        print("Observable Object created")
        self.isProAccess = isProAccess
    }
}
