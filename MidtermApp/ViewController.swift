//
//  ViewController.swift
//  MidtermApp
//

import UIKit

class ViewController: UITableViewController {

    let cellId = "cellId"
    
    // custom delegation
    func someMethodIwantToCall(cell: UITableViewCell) {
        
        // saving the cell position
        let indexPathTapped = tableView.indexPath(for: cell)
        // saving the bubussiness card (string)
        let bussinessCard = bussinessCards[indexPathTapped!.section].bussinessCards[indexPathTapped!.row]
        
        let hasStart = bussinessCard.hasStart
        
        // hasStart -> !hasStart
        bussinessCards[indexPathTapped!.section].bussinessCards[indexPathTapped!.row].hasStart = !hasStart
        
        // kind of reload the view after clicking on the start
        cell.accessoryView?.tintColor = hasStart ? UIColor.orange : UIColor.lightGray
        
    }
    
    // two dimensional array
    var bussinessCards = [
        
        ExpandableSections(isExpanded: true, bussinessCards: ["Bussiness Card A1","Bussiness Card A2","Bussiness Card A3"].map{BussinessCard(name: $0, hasStart: false)}),
        ExpandableSections(isExpanded: true, bussinessCards: ["Bussiness Card B1","Bussiness Card B2","Bussiness Card B3"].map{BussinessCard(name: $0, hasStart: false)}),
        ExpandableSections(isExpanded: true, bussinessCards: ["Bussiness Card C1","Bussiness Card C2","Bussiness Card C3"].map{BussinessCard(name: $0, hasStart: false)}),
        ExpandableSections(isExpanded: true, bussinessCards: ["Bussiness Card D1","Bussiness Card D2","Bussiness Card D3"].map{BussinessCard(name: $0, hasStart: false)}),
        ExpandableSections(isExpanded: true, bussinessCards: ["Bussiness Card E1","Bussiness Card E2","Bussiness Card E3"].map{BussinessCard(name: $0, hasStart: false)})
        
    ]
    
    // to make the animation goes right and goes left
    var showDetails = false
    
    // add @objc to make it work
    @objc func handleShowDetails() {
        
        //build all the indexPaths we want to reload
        var indexPathsToReload = [IndexPath]()
        
        // nested loop to reload all the elements
        for section in bussinessCards.indices {
            if bussinessCards[section].isExpanded { // app crashed without this
                for row in bussinessCards[section].bussinessCards.indices {
                    let indexPath = IndexPath(row: row, section: section)
                    indexPathsToReload.append(indexPath)
                }
            }
        }
        
        // reverse the value
        showDetails = !showDetails
        
        // then the animation will be different every time the code is executed
        let animationStyle = showDetails ? UITableViewRowAnimation.left : UITableViewRowAnimation.right
        
        tableView.reloadRows(at: indexPathsToReload, with: animationStyle)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show Details", style: .plain, target: self, action: #selector(handleShowDetails))
        
        navigationItem.title = "Bussiness Cards"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // dequeue process requires tableView register itself first!

        // change this method to have a custom cell
        // UITableViewCell.self -> BussinessCardCell.self
        tableView.register(BussinessCardCell.self, forCellReuseIdentifier: cellId)
        
    }
    
    // divider for different sections
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        
        // move the button to the right edge
        //button.frame.origin = CGPoint(x: , y: ) ?
        
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        
        // to specify the section inside handleExpandClose function
        button.tag = section
        
        return button
        
    }
    
    // add @objc to make it work
    @objc func handleExpandClose(button: UIButton) {

        // getting the section
        let section = button.tag
        
        var indexPaths = [IndexPath]()
        for row in bussinessCards[section].bussinessCards.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        let isExpanded = bussinessCards[section].isExpanded
        // reverse the value
        bussinessCards[section].isExpanded = !isExpanded
        
        button.setTitle(isExpanded ? "Open" : "Close", for: .normal)
        
        if isExpanded {
            tableView.deleteRows(at: indexPaths, with: .fade)
        }
        else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
        
    }
    
    // height for the divider
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    // number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
         return bussinessCards.count
    }
    
    // number of rows in section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !bussinessCards[section].isExpanded {
            return 0 //return 0 when is close
        }
        return bussinessCards[section].bussinessCards.count
    }
    
    // cell for row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BussinessCardCell
        cell.link = self
        
        let bussinessCards = self.bussinessCards[indexPath.section].bussinessCards[indexPath.row]
        
        // change the start color
        cell.accessoryView?.tintColor = bussinessCards.hasStart ? UIColor.orange : UIColor.lightGray
        
        if showDetails {
            cell.textLabel?.text = "\(bussinessCards.name) with details..." // details
        }
        else{
            cell.textLabel?.text = bussinessCards.name // no details
        }
        
        return cell
        
    }

}
