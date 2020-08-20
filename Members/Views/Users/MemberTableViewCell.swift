//
//  MemberTableViewCell.swift
//  Members
//
//  Created by Misael Pérez Chamorro on 19/08/20.
//  Copyright © 2020 Misael Pérez Chamorro. All rights reserved.
//

import UIKit

class MemberTableViewCell: UITableViewCell {
  @IBOutlet weak var idlabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
  func bindWithUser(user: User) {
    idlabel.text = "\(user.id)"
    nameLabel.text = user.name
  }
}
