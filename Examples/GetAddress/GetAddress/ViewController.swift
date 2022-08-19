//
//  ViewController.swift
//  GetAddress
//
//  Created by Dave Duprey on 15/08/2022.
//

import UIKit
import W3WSwiftAddressValidators


class ViewController: UITableViewController {

  // MARK: Vars
  
  
  let service   = W3WAddressValidatorSwiftComplete(key: "YourSwiftCompleteApiKey")
  //let service   = W3WAddressValidatorData8(key: "YourData8Key")

  // address store for this view
  var addresses = [W3WValidatorNode]()
  
  
  // MARK: Init
  
  
  /// Called when the storyboard lanches, we then set up the first call with a
  /// three word address using `search()`
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    let words = "filled.count.soap"
    
    title = words
    
    // search for a three word address on start up
    service.search(near: words) { list, error in
      self.resultsArrived(list: list, error: error)
    }
  }
  

  /// Inits ths tableview with a node from the previous one
  /// Each subview is programaticaally instantiated
  /// Called from `didSelectRowatIndexPath`
  init(node: W3WValidatorNode? = nil) {
    super.init(nibName: nil, bundle: nil)

    // given a node in the address tree, get a list of sub nodes
    if let n = node as? W3WValidatorNodeList {
      service.list(from: n) { list, error in
        self.resultsArrived(list: list, error: error)
      }

    // if this is a leaf node, make the money call and get the details
    } else if let n = node as? W3WValidatorNodeLeaf {
      service.info(for: n) { info, error in
        self.alert(title: "Result", message: info?.address?.description ?? "?")
      }
    }
  }
  
  
  // MARK: Manage the data
  
  
  /// shows the results, or an error if something went wrong
  func resultsArrived(list: [W3WValidatorNode], error: W3WAddressValidatorError?) {
    // check for error
    if let e = error {
      self.alert(title: "Error", message: e.description)
      
      // if no error then show the returned data
    } else {
      self.loadRows(with: list)
    }
  }
  
  
  /// given an array of nodes, put them inthe table data and reload the table
  func loadRows(with: [W3WValidatorNode]) {
    self.addresses = with
    
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
  
  
  // MARK: UITableViewDelegate stuff
  
  
  /// get a cell coresponding to the values in the addressses data
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
    
    // set the textual values of the cell
    cell.textLabel?.text       = addresses[indexPath.row].name
    cell.detailTextLabel?.text = addresses[indexPath.row].nearestPlace
    
    return cell
  }

  
  /// When a user selects a row, we make a new tableView with it's node and present it
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let node = addresses[indexPath.row]
    
    let childVC = ViewController(node: node)
    show(childVC, sender: self)
  }
  
  
  /// Only ever one section
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  
  /// The number of addresses
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return addresses.count
  }
  
  
  // MARK: Utility
  
  
  /// display an error using a UIAlertController, error messages conform to CustomStringConvertible
  func alert(title: String, message: String) {
    DispatchQueue.main.async {
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
      self.present(alert, animated: true)
    }
  }

  
  
}

