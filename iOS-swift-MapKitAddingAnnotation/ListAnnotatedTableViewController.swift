//
//  ListAnnotatedTableViewController.swift
//  iOS-swift-MapKitAddingAnnotation
//
//  Created by IMCS2 on 8/10/19.
//  Copyright © 2019 com.phani. All rights reserved.
//

import UIKit


class ListAnnotatedTableViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return text.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = text[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "segue"){
            let controller = segue.destination as? ViewController
            
            let blogIndex = tableView.indexPathForSelectedRow?.row
            controller!.LatCorrdinate = Names[blogIndex!]
            controller?.LongCoordinate = labels[blogIndex!]
            
        }
        
    }
    
    
    
}
