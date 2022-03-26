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
                                                            action: #selector(didTapAdd))
        getAllItems()
    }
    
    @objc func didTapAdd() {
        let alert = UIAlertController(title: "New Task", message: "Add new Task", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Create", style: .cancel, handler: { [weak self] _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                return
            }
            self?.createItem(with: text)
        }))
        present(alert, animated: true)
    }
    
    func getAllItems() {
        do {
            //получение всех сущностей ToDoListItem из контекста
            models = try context.fetch(ToDoListItem.fetchRequest())
            
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        } catch let error {
            let errorAlert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
            present(errorAlert, animated: true)
        }
    }
    
    func createItem(with name: String) {
        let newItem = ToDoListItem(context: context)
        newItem.name = name
        newItem.createdAt = Date()
        
        do {
            try context.save()
            getAllItems()
        } catch let error {
            let errorAlert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
            present(errorAlert, animated: true)
        }
    }
    
    func deleteItem(_ item: ToDoListItem) {
        context.delete(item)
        
        do {
            try context.save()
            getAllItems()
        } catch let error {
            let errorAlert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
            present(errorAlert, animated: true)
        }
    }
    
    func updateItem(item: ToDoListItem, newName: String) {
        item.name = newName
        
        do {
            try context.save()
            getAllItems()
        } catch let error {
            let errorAlert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
            present(errorAlert, animated: true)
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableCell.identifier, for: indexPath) as! ToDoTableCell
        cell.configureCell(with: model.name!, amount: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        let item = models[indexPath.row]
        let sheet = UIAlertController(title: "Edit", message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil ))
        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { [weak self] _ in
            
            let alert = UIAlertController(title: "New Task", message: "Edit your Task", preferredStyle: .alert)
             
            alert.addTextField(configurationHandler: nil)
            alert.textFields?.first?.text = item.name
            alert.addAction(UIAlertAction(title: "Save changes", style: .cancel, handler: { [weak self] _ in
                guard let field = alert.textFields?.first, let newName = field.text, !newName.isEmpty else {
                    return
                }
                self?.updateItem(item: item, newName: newName)
            }))
            
            self?.present(alert, animated: true)
        }))
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.deleteItem(item)
        }))
        
        present(sheet, animated: true)
    }
    
}



