//
//  ConnectionViewCell.swift
//  SafeConnect
//
//  Created by Michelle Katz on 11/19/20.
//  Copyright © 2020 Michelle Katz. All rights reserved.
//

import UIKit

class ConnectionViewCell: UICollectionViewCell {
    var cName: UILabel!
    var cDescription: UITextView!
    var clickViewMore: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let nameFrame = CGRect(x: 4, y: 10, width: 345, height: 25)
        cName = UILabel(frame: nameFrame)
        cName.textColor = UIColor.black
        cName.font = UIFont(name: "Avenir Next", size: 14)
        contentView.addSubview(cName)
        let descFrame = CGRect(x: 0, y: 33, width: 345, height: 64)
        cDescription = UITextView(frame: descFrame)
        cDescription.textColor = UIColor.black
        cDescription.font = UIFont(name: "Avenir Next", size: 14)
        cDescription.isEditable = false
        contentView.addSubview(cDescription)
        let cvmFrame = CGRect(x: 4, y: 94, width: 345, height: 25)
        clickViewMore = UILabel(frame: cvmFrame)
        contentView.addSubview(clickViewMore)
        clickViewMore.textColor = UIColor.black
        clickViewMore.font = UIFont(name: "Avenir Next", size: 12)
    }
    
    func setCell(name: String, description: String) {
        cName.text = name
        cDescription.text = description
        clickViewMore.text = "Click to view details"
    }
}
