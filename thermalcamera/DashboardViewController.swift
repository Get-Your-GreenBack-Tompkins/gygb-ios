//
//  DashboardViewController.swift
//  thermalcamera
//
//  Created by Imani Chilongani on 16/04/2020.
//  Copyright © 2020 Get Your GreenBack Tompkins. All rights reserved.
//

import UIKit

class DashboardViewController: UITableViewController {
  var container: UIView!
  let cellId = "cellId"
  let actions = ["Thermal Camera", "Thermal Camera", "View and Share Pictures"]

  override func viewDidLoad() {
    super.viewDidLoad()
    container = UIView().background(Color(red:0.95686274509, green:0.95686274509, blue:0.95686274509,alpha: 1))
    let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44)) // Offset by 20 pixels vertically to take the status bar into account

    navigationBar.backgroundColor = UIColor.white

    // Create a navigation item with a title
    let navigationItem = UINavigationItem()
    navigationItem.title = "Powerhouse HotShot"

    // Create left and right button for navigation item

    let rightButton = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: nil)

    // Create two buttons for the navigation item
    navigationItem.rightBarButtonItem = rightButton

    // Assign the navigation item to the navigation bar
    navigationBar.items = [navigationItem]

    // Make the navigation bar a subview of the current view controller
    view.addSubview(navigationBar)
    setupTableView()
  }

  // MARK: - Table view data source

  override func numberOfSections(in _: UITableView) -> Int {
    return 1
  }

  override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
    return 3
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
    cell.textLabel?.text = actions[indexPath.row]

    return cell
  }

  func setupTableView() {
    // Registers a class for use in creating new table cells.
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
  }
}
