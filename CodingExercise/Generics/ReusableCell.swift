//
//  ReusableCell.swift
//  CodingExercise
//
//  Created by Raj Rathod on 18/05/22.
//  Copyright © 2022 Rise Buildings. All rights reserved.
//

import Foundation
import UIKit

// MARK:- Defining reusable identifier to tableview cell
protocol ReusableCell {
    static var identifier: String { get }
    static var nib: UINib { get }
}

extension ReusableCell where Self: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
