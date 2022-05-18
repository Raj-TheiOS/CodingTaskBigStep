//
//  GenericTableView.swift
//  CodingExercise
//
//  Created by Raj Rathod on 18/05/22.
//  Copyright © 2022 Rise Buildings. All rights reserved.
//

import Foundation
import UIKit

class GenericDataSource<T: UITableViewCell>: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var didSelect: (T, Int) -> Void = { _, _ in }
    let screenSize: CGRect = UIScreen.main.bounds
    var didScroll: () -> Void = { }
    var configure : ((T, Int) -> Void)?
    var identifier = String()
    var nib = UINib()
    var isScrolled = Bool()
    var array: [Any] = []
    var emptyMessage = String()

    // MARK:- To register tableview cell with reuse identifier
    func registerCells(forTableView tableView: UITableView) {
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }
    
    // MARK:- To load tableview cell in a tableview
    func loadCell(atIndexPath indexPath: IndexPath, forTableView tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        configure?(cell as! T, indexPath.row)
        return cell
    }
    
    // MARK:- Number of headers in a tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK:- DefiningNumber Of Rows In Section based on array count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if array.count == 0 {
            tableView.setEmptyMessage(emptyMessage, table: tableView)
         }else {
             tableView.restore()
         }
        return array.count
    }
    
    // MARK:- Loading data into the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.loadCell(atIndexPath: indexPath, forTableView: tableView)
    }
    
    // MARK:- To Auto-resize tableview cell
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // MARK:- To Auto-resize tableview cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // MARK:- To handle tap actions on tableview cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        didSelect(cell as! T, indexPath.row)
    }
    
    // MARK:- To Indicate the scroll actions of tableview cell
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height && !isScrolled {
            didScroll()
            isScrolled = true
        }
    }
    
}

// MARK:- Empty Message to the tableview when datasource is empty
extension UITableView {
    
    func setEmptyMessage(_ message: String, table: UITableView) {
       let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = .boldSystemFont(ofSize: 16)
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel
        self.separatorStyle = .none
        
    }
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

extension UITableView {
    
    // MARK:- To Auto-resize tableview cell by using content size
    var contentSizeHeight: CGFloat {
        var height = CGFloat(0)
        for section in 0..<numberOfSections {
            height = height + rectForHeader(inSection: section).height
            let rows = numberOfRows(inSection: section)
            for row in 0..<rows {
                height = height + rectForRow(at: IndexPath(row: row, section: section)).height
            }
        }
        return height
    }
}

