//
//  EditViewController.swift
//  CRUD
//
//  Created by Leonardo Lee on 6/21/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

import UIKit

protocol EditViewDelegate {
	func addItem ( editItemViewController: EditViewController, item: Book, indexPath: Int )
	func cancel( editItemViewController: EditViewController )
}

class EditViewController: UIViewController {
	
	@IBOutlet var textField: UITextField
	@IBOutlet var doneButton: UIButton
	
//Optionals to avoid initialization.
	var book: Book?
	var indexPath: Int?
	
//Delegate variable for the protocol.
	var delegate: EditViewDelegate?

//	These methods get the data based on, the fall through was some code that I thought about using.
	var viewControllerTitle: String {
	get {
		if book {
			return book!.title
		} else {
			return "New Book"
		}
	}
	}
	var textFieldPlaceholder: String {
	get {
		if book {
			return book!.title
		} else {
			return "Type here..."
		}
	}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = viewControllerTitle
		textField.text = textFieldPlaceholder

	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		self.textField.becomeFirstResponder()
	}
	
//	This is the implementation for the buttons, which are used to communicate with the delegate.
	@IBAction func finishEditing(sender: AnyObject) {
		var newBook = Book(bookName: textField.text)
		self.delegate?.addItem(self, item: newBook, indexPath: indexPath!)
		
	}
	@IBAction func cancel(sender: AnyObject) {
		self.delegate?.cancel(self)
	}
	
	
	
	
	
}