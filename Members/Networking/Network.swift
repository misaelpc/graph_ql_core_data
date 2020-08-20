//
//  Network.swift
//  Members
//
//  Created by Misael Pérez Chamorro on 19/08/20.
//  Copyright © 2020 Misael Pérez Chamorro. All rights reserved.
//

import Foundation
import Apollo

class Network {
  static let shared = Network()
    
  private(set) lazy var apollo = ApolloClient(url: URL(string: "http://localhost:4000/api/")!)
}
