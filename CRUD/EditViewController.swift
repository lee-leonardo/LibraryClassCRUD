//
//  EditViewController.swift
//  CRUD
//
//  Created by Leonardo Lee on 6/21/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

import UIKit

protocol EditViewDelegate {
	func addItem ( editItemViewController: EditViewController, item: Book, indexPath: Int? )
	func cancel( editItemViewController: EditViewController )
}

class EditViewController: UIViewController {
	
	@IBOutlet var textField: UITextField
	@IBOutlet var doneButton: UIButton
	
	var book: Book?
	var indexPath: Int?
	var delegate: EditViewDelegate?

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
	
	@IBAction func finishEditing(sender: AnyObject) {
		var newBook = Book(bookName: textField.text)
		
		if indexPath {
			self.delegate?.addItem(self, item: newBook, indexPath: indexPath!)
		} else {
			self.delegate?.addItem(self, item: newBook, indexPath:nil)
		}
	}
	@IBAction func cancel(sender: AnyObject) {
		self.delegate?.cancel(self)
	}
	
	
	
	
	
}