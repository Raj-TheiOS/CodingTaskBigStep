//
//  ViewController.swift
//  CodingExercise
//
//  Created by Bigstep Technologies on 6/8/20.
//  Copyright © 2020 Bigstep Technologies. All rights reserved.
//

import UIKit
import Kingfisher

class ContactListViewController: UIViewController {
        
    // MARK: Outlets
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UINib(nibName: "ContactTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactTableViewCell")
        return tableView
    }()
        
    var sortedContacts = [ContactDetails]()
    var datasourceTable = GenericDataSource()
    let emptyList = "No contacts found, Try Again!"

    let viewmodel = ContactsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDefault()
    }
    
    // MARK: Private Method
    func setDefault() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.frame = view.bounds
        
        viewmodel.GetDataFromJson() { cities in
            //Loading Datasource and refreshing tableview
            DispatchQueue.main.async {
            self.setUpTableCell(contacts: cities)
            }
        }
    }

    // MARK:- loading cities data in table cell
    func setUpTableCell(contacts: [ContactDetails]) {
        
        // Configuring the TableviewDataSource
        datasourceTable.emptyMessage = emptyList
        datasourceTable.array = contacts
        datasourceTable.identifier = ContactTableViewCell.identifier
        tableView.dataSource = datasourceTable
        tableView.delegate = datasourceTable
        tableView.tableFooterView = UIView()
        
        // Loading data and configuring the tableview cell
        datasourceTable.configure = {cell, index in
            guard let contactTableViewCell = cell as? ContactTableViewCell else { return }
            contactTableViewCell.object = contacts[index]
        }
        
        // Observing the scroll actions of of tableview cell
        datasourceTable.didScroll = {
            print("scrolling...")
        }
        
        // Selection of tableview cell
        datasourceTable.didSelect = {cell, index in
            print(contacts[index].first_name )
        }
    }
}
