//
//  ViewController.swift
//  MidtermApp
//

import UIKit

class ViewController: UITableViewController {

    let cellId = "cellId"
    
    // two dimensional array
    let bussinessCards = [
        ["Bussiness Card A1","Bussiness Card A2","Bussiness Card A3"],
        ["Bussiness Card B1","Bussiness Card B2","Bussiness Card B3"],
        ["Bussiness Card C1","Bussiness Card C2","Bussiness Card C3"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.title = "Bussiness Cards"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // dequeue process requires tableView register itself first
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
    }
    
    // divider for different sections
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Header"
        label.backgroundColor = UIColor.lightGray
        
        return label
    }
    
    // number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
         return bussinessCards.count
    }
    
    // number of rows in section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bussinessCards[section].count
    }
    
    // cell for row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let bussinessCards = self.bussinessCards[indexPath.section][indexPath.row]
        cell.textLabel?.text = bussinessCards
        
        return cell
        
    }

}
