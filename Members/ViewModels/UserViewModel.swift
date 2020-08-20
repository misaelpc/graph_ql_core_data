//
//  UserViewModel.swift
//  Members
//
//  Created by Misael Pérez Chamorro on 19/08/20.
//  Copyright © 2020 Misael Pérez Chamorro. All rights reserved.
//

import Foundation

public class UserViewModel {

  private let user: User

  public init(user: User) {
    self.user = user
  }
  
  func userId() -> String {
    return "\(user.id)"
  }
  
  func name() -> String {
    return user.name!
  }
  
  func email() -> String {
    return user.email!
  }
}
