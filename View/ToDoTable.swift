//
//  ToDoTable.swift
//  ToDoList
//
//  Created by Eugene on 24.03.2022.
//

import UIKit

class ToDoTable: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        estimatedRowHeight = 50
        rowHeight = UITableView.automaticDimension
        translatesAutoresizingMaskIntoConstraints = false
        register(ToDoTableCell.self, forCellReuseIdentifier: ToDoTableCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
