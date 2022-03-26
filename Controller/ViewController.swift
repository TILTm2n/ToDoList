//
//  ViewController.swift
//  ToDoList
//
//  Created by Eugene on 24.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var table = ToDoTable()
    var models = [ToDoListItem]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "To Do List"
        
        table = ToDoTable(frame: self.view.bounds)
        table.backgroundColor = .yellow
        table.delegate = self
        table.dataSource = self
        
        view.backgroundColor = .yellow
        view.addSubview(table)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: <#T##Selector?#>)
    }
    
    func getAllItems() {
        do {
            //получение всех сущностей ToDoListItem из контекста
            models = try context.fetch(ToDoListItem.fetchRequest())
        } catch let error {
            print(error)
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableCell.identifier, for: indexPath) as! ToDoTableCell
        return cell
    }
    
}



