//
//  EventViewCell.swift
//  SafeConnect
//
//  Created by Michelle Katz on 11/19/20.
//  Copyright © 2020 Michelle Katz. All rights reserved.
//

import UIKit

class EventViewCell: UICollectionViewCell {
    
    var eventName: UILabel!
    var eventDescription: UITextView!
    var clickViewMore: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let eventNameFrame = CGRect(x: 4, y: 10, width: 345, height: 25)
        eventName = UILabel(frame: eventNameFrame)
        eventName.textColor = UIColor.black
        eventName.font = UIFont(name: "Avenir Next", size: 14)
        contentView.addSubview(eventName)
        let eventDescFrame = CGRect(x: 0, y: 33, width: 345, height: 64)
        eventDescription = UITextView(frame: eventDescFrame)
        eventDescription.textColor = UIColor.black
        eventDescription.font = UIFont(name: "Avenir Next", size: 14)
        eventDescription.isEditable = false
        contentView.addSubview(eventDescription)
        let cvmFrame = CGRect(x: 4, y: 94, width: 345, height: 25)
        clickViewMore = UILabel(frame: cvmFrame)
        contentView.addSubview(clickViewMore)
        clickViewMore.textColor = UIColor.black
        clickViewMore.font = UIFont(name: "Avenir Next", size: 12)
    }
    
    func setCell(name: String, description: String) {
        eventName.text = name
        eventDescription.text = description
        clickViewMore.text = "Click to view details"
    }
}
