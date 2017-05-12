//
//  ViewController.swift
//  firefun
//
//  Created by Adrian McDaniel on 5/12/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var myTextField: UITextField!
    
    @IBOutlet weak var myTableView: UITableView!
    
    var myList: [String] = []
    
    var handle: FIRDatabaseHandle?
    
    var ref: FIRDatabaseReference?
    
    @IBAction func saveButton(_ sender: Any) {
        
        ref = FIRDatabase.database().reference()
        
        //creates a child reference if it doesn't exist and creating a auto id for the item and set the value as the entered text and saving item to database
        if myTextField.text != "" {
            ref?.child("list").childByAutoId().setValue(myTextField.text)
            myTextField.text = ""
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = myList[indexPath.row]
        
        return cell
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ref = FIRDatabase.database().reference()
        
        //our handle is looking for if ther was a child item added
        handle = ref?.child("list").observe(.childAdded, with: { (snapshot) in
            
            // if value is not nil then convert to string and append it to the myList
            if let item = snapshot.value as? String {
                self.myList.append(item)
                self.myTableView.reloadData()
            }
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

