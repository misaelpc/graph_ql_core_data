//
//  MemberViewController.swift
//  Members
//
//  Created by Misael Pérez Chamorro on 19/08/20.
//  Copyright © 2020 Misael Pérez Chamorro. All rights reserved.
//

import UIKit

class MemberViewController: UIViewController {
  @IBOutlet weak var idLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  var user: User?
  var viewModel: UserViewModel?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel = UserViewModel(user: user!)
    bindWithUser()
  }
  
  func bindWithUser() {
    idLabel.text = viewModel?.userId()
    nameLabel.text = viewModel?.name()
    emailLabel.text = viewModel?.email()
  }
}
