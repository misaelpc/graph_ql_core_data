//
//  ViewController.swift
//  Members
//
//  Created by Misael Pérez Chamorro on 19/08/20.
//  Copyright © 2020 Misael Pérez Chamorro. All rights reserved.
//

import UIKit
import CoreData

class MembersViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  private let refreshControl = UIRefreshControl()
  var resulsController: NSFetchedResultsController<NSFetchRequestResult>?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    updateData()
  }
  
  func updateData() {
    resulsController = User.resultsController()
    resulsController?.delegate = self
    Users.fetchUsers {}
  }
  
  func setupTableView() {
    tableView.refreshControl = refreshControl
    refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
    self.tableView.register(UINib(nibName: "MemberTableViewCell",
                                bundle: nil), forCellReuseIdentifier: "MemberTableViewCell")
  }
  
  @objc private func refreshWeatherData(_ sender: Any) {
    Users.fetchUsers {
      self.refreshControl.endRefreshing()
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let memberController = segue.destination as? MemberViewController {
      memberController.user = sender as? User
    }
  }
}

extension MembersViewController: NSFetchedResultsControllerDelegate {
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.reloadData()
  }
}

extension MembersViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let sections = self.resulsController?.sections else {
        fatalError("No sections in fetchedResultsController")
    }
    let sectionInfo = sections[section]
    return sectionInfo.numberOfObjects
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let user = self.resulsController?.object(at: indexPath) as? User else {
        fatalError("Attempt to configure cell without a managed object")
    }
    let cell = tableView.dequeueReusableCell(withIdentifier: "MemberTableViewCell",
    for: indexPath) as? MemberTableViewCell
    cell?.bindWithUser(user: user)
    return cell!
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let user = self.resulsController?.object(at: indexPath) as? User else {
        fatalError("Attempt to configure cell without a managed object")
    }
    self.performSegue(withIdentifier: "showDetail", sender: user)
  }
}
