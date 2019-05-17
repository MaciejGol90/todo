//
//  ViewController.swift
//  Todo
//
//  Created by Maciej Golianek on 15/05/2019.
//  Copyright © 2019 Maciej Golianek. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var todoTableView: UITableView!

    var todos: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        todoTableView.delegate = self
        todoTableView.dataSource = self
        todoTableView.rowHeight = 80
    }
    var category: [String] = ["Praca" , "Zakupy", "Inne"]
    
    
    @IBAction func addTodo(_ sender: Any) {
        
        
        let todoAlert = UIAlertController(title: "Add todo", message: "/ wydarzenie / czas / kategoria /", preferredStyle: .alert)

        todoAlert.addTextField()
        let addTodoAction = UIAlertAction(title: "Dodaj", style: .default) { (action) in
            let newTodo = todoAlert.textFields![0]
            self.todos.append(newTodo.text!)
            self.todoTableView.reloadData()

        }
        let cancelAction = UIAlertAction(title: "Anuluj", style: .default)

        todoAlert.addAction(addTodoAction)
        todoAlert.addAction(cancelAction)

        present(todoAlert, animated: true, completion: nil)

//
//
        // MARK: - UIPopoverPresentationControllerDelegate method
        
        func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
            
            // Force popover style
            return UIModalPresentationStyle.none
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoCell
        cell.todoLabel.text = todos[indexPath.row]
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TodoCell
        if cell.isChecked == false{
        cell.checkImage.image = UIImage(named:"checkmark.png")
        cell.isChecked = true
        } else {
            cell.checkImage.image = nil
            cell.isChecked = false
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            todoTableView.reloadData()
            
        }
    }


}

