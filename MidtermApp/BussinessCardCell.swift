//
//  BussinessCardCell.swift
//  MidtermApp
//

import UIKit

class BussinessCardCell: UITableViewCell {
    
    var link: ViewController?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let starButton = UIButton(type: .system)
        starButton.setImage(#imageLiteral(resourceName: "fav_star"), for: .normal)
        starButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        starButton.addTarget(self, action: #selector(handleFavoriteStart), for: .touchUpInside)
        accessoryView = starButton
        
    }
    
    @objc private func handleFavoriteStart() {
    
        link?.someMethodIwantToCall(cell: self)
    
    }
    
    // override the required init, otherwise the code will not compile
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
