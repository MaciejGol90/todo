//
//  AddTodoViewController.swift
//  TodoApp
//
//  Created by Maciej Golianek on 16/05/2019.
//  Copyright © 2019 Maciej Golianek. All rights reserved.
//

import UIKit
import CoreData

class AddTodoViewController: UIViewController {
    // MARK: - Properties
    var managedContext: NSManagedObjectContext!
    var todo: Todo?
    
    //    MARK: Outlets

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var categoryControl: UISegmentedControl!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(with:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        textView.becomeFirstResponder()
        
        if let todo = todo {
            textView.text = todo.title
            textView.text = todo.title
        
            UIResponder.index(ofAccessibilityElement: todo.category)
        }
    }
    
    // MARK: Actions
    
    @objc func keyboardWillShow(with notification: Notification) {
        let key = "UIKeyboardFrameEndUserInfoKey"
        guard let keyboardFrame = notification.userInfo?[key] as? NSValue else { return }

        let keyboardHeight = keyboardFrame.cgRectValue.height + 16
        bottomConstraint.constant = keyboardHeight
    
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    fileprivate func dismissAndResign() {
        dismiss(animated: true)
        textView.resignFirstResponder()
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismissAndResign()
    }
    
    @IBAction func addButton(_ sender: UIButton) {
        guard let title = textView.text, !title.isEmpty else {
            return
        }
        
        if let todo = self.todo {
            todo.title = title
            todo.category = Int16()
           todo.date = TimeInterval.init()
        } else {
            let todo = Todo(context: managedContext)
            todo.title = title
            todo.category = Int16()
            todo.date = TimeInterval.init()
        }
        
        do {
            try managedContext.save()
            dismissAndResign()
        } catch {
            print("Error saving todo: \(error)")
        }
    }
}

extension AddTodoViewController: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        if addButton.isHidden {
            textView.text.removeAll()
            textView.textColor = .white
            
            addButton.isHidden = false
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
