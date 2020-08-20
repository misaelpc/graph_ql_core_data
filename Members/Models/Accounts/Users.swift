//
//  Users.swift
//  Members
//
//  Created by Misael Pérez Chamorro on 19/08/20.
//  Copyright © 2020 Misael Pérez Chamorro. All rights reserved.
//

import Foundation

struct Users {
  static func fetchUsers(completion: @escaping () -> Void) {
    Network.shared.apollo
      .fetch(query: AllusersQuery(),
             cachePolicy: .fetchIgnoringCacheCompletely) {result in

      switch result {
      case .success(let graphQLResult):
        if let users = graphQLResult.data?.users {
          User.createFromPayload(usersPayload: users) {
            completion()
          }
        }
      case .failure(let error):
        debugPrint(error.localizedDescription)
        completion()
      }
    }
  }
}
