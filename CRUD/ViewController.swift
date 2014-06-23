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
		let newItem = "ToNew"
	}
	
                            
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "Booklist"

		CRUDlist()
		
	}
	func CRUDlist() {
		booklist.append(Book(bookName: "Mahabharata"))
		booklist.append(Book(bookName: "Pride and Prejudice"))
		booklist.append(Book(bookName: "Tractatus Logico Philosophicus"))
		booklist.append(Book(bookName: "The Last of the Mohicans"))
		booklist.append(Book(bookName: "Javascript Ninja"))
		booklist.append(Book(bookName: "Twentieth Century Music"))
		booklist.append(Book(bookName: "Tao Te Ching"))

		
//		for book in booklist {
//			println("\(book.title)")
//		}
		
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
	//	#pragma mark - Sending data to delegate
//	@optional func tableView(_ tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
//		var object = booklist[indexPath.row]
////		self.delegate.book = object
//	}
//	@optional func tableView(_ tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
//		
//	}
	

//	#pragma mark - TableView functions
//	Use this function until you find out how to make a VC that you can used with segues.
	@IBAction func addCell(sender: AnyObject) {
		var book = Book(bookName: "\"Placeholder\"")
		booklist.append(book)
		booklistTableView.reloadData()
	}
	
//	#pragma mark - Editing
	@IBAction func editList(sender: AnyObject) {
		
//		This needs to work within an update block....
		booklistTableView.setEditing(!booklistTableView.editing, animated: true)
	}
	override func setEditing(editing: Bool, animated: Bool) {
		super.setEditing(editing, animated: animated)
		booklistTableView.setEditing(editing, animated: true)
//		Needed?
//		if editing {
//			
//		} esle {
//			
//		}
	}
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
	
	func addItem( editItemViewController: EditViewController, item: Book, indexPath: Int? ) {
		
		if indexPath {
			booklist.removeAtIndex(indexPath!)
			booklist.insert(item, atIndex: indexPath!)
		} else {
			booklist.append(item)
		}
		
		self.dismissViewControllerAnimated(true, completion: nil)
		booklistTableView.reloadData()
	}
	func cancel(editItemViewController: EditViewController) {
		self.dismissViewControllerAnimated(true, completion: nil)
	}
	
}

