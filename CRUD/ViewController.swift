//
//  ViewController.swift
//  CRUD
//
//  Created by Leonardo Lee on 6/20/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, EditViewDelegate {
	
	@IBOutlet var booklistTableView: UITableView
	var booklist = Book[]()
	
	struct segueID {
		let edit: String = "ToEdit"
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "Booklist"

		buildBooklist()
		
	}
	func buildBooklist() {
		booklist.append(Book(bookName: "Mahabharata"))
		booklist.append(Book(bookName: "Pride and Prejudice"))
		booklist.append(Book(bookName: "Tractatus Logico Philosophicus"))
		booklist.append(Book(bookName: "The Last of the Mohicans"))
		booklist.append(Book(bookName: "Javascript Ninja"))
		booklist.append(Book(bookName: "Twentieth Century Music"))
		booklist.append(Book(bookName: "Tao Te Ching"))
		
		/* //Primarily just for testing.
		for book in booklist {
			println("\(book.title)")
		}
		*/
		
	}
	
//	#pragma mark - UITableViewDataSource
	func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!  {
		var cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
		var item = booklist[indexPath.row]
		cell.textLabel.text = item.title
		
		return cell
	}
	func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
		return booklist.count
	}

//	#pragma mark - Function to add Cells.
	@IBAction func addCell(sender: AnyObject) {
		var book = Book()
		booklist.append(book)
		booklistTableView.reloadData()
	}
	
//	#pragma mark - Editing the TableView
	@IBAction func editList(sender: AnyObject) {
		//This needs to work within an update block....
		booklistTableView.setEditing(!booklistTableView.editing, animated: true)
	}
	override func setEditing(editing: Bool, animated: Bool) {
		super.setEditing(editing, animated: animated)
		booklistTableView.setEditing(editing, animated: true)

	}
	
//	Disclaimer: A bit confused why these didn't work with the @optional in front of them...
	func tableView(tableView: UITableView!, editingStyleForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCellEditingStyle {
			return UITableViewCellEditingStyle.Delete
	}
	
	func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
		if editingStyle == UITableViewCellEditingStyle.Delete {
			booklist.removeAtIndex(indexPath.row)
			booklistTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
		}
	}
	
	
//	#pragma mark - segues
	override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
		if (segue.identifier == "ToEdit") {
			let editViewController: EditViewController = segue.destinationViewController as EditViewController
			let indexPath = self.booklistTableView.indexPathForSelectedRow()
			var itemSent = booklist[indexPath.row]
			editViewController.book = itemSent
			editViewController.indexPath = indexPath.row
			editViewController.delegate = self
		}
	}
	
//EditViewDelegate functions, cancel, just dismisses the view. addItem actually replaces the item at the index.
	func addItem( editItemViewController: EditViewController, item: Book, indexPath: Int ) {
		booklist[indexPath] = item
		
		self.dismissViewControllerAnimated(true, completion: nil)
		booklistTableView.reloadData()
	}
	
	func cancel(editItemViewController: EditViewController) {
		self.dismissViewControllerAnimated(true, completion: nil)
	}
	
}

