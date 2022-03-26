//
//  ToDoTableCell.swift
//  ToDoList
//
//  Created by Eugene on 24.03.2022.
//

import UIKit

class ToDoTableCell: UITableViewCell {

    public static var identifier = "ToDoTableCell"
    
    private var title: UILabel = {
        var title = UILabel()
        title.numberOfLines = 0
        title.textColor = .yellow
        title.textAlignment = .left
        title.lineBreakMode = .byWordWrapping
        title.font = .systemFont(ofSize: 17, weight: .semibold)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private var amount: UILabel = {
        var amount = UILabel()
        amount.translatesAutoresizingMaskIntoConstraints = false
        return amount
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //self.contentView.translatesAutoresizingMaskIntoConstraints = true
        contentView.addSubview(title)
        contentView.addSubview(amount)
        contentView.backgroundColor = .blue
        
        titleConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func titleConstraints() {
        NSLayoutConstraint.activate([
            title.layoutMarginsGuide.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            title.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -55),
            title.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            amount.layoutMarginsGuide.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            amount.layoutMarginsGuide.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            amount.layoutMarginsGuide.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    func configureCell(with title: String, amount: Int) {
        self.title.text = title
        self.amount.text = "\(amount + 1)"
    }

}
