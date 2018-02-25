//
//  CalendarViewController.swift
//  CostumeParty
//
//  Created by Lane Faison on 2/25/18.
//  Copyright © 2018 Lane Faison. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController {
    
    fileprivate weak var calendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: 320, height: 300))
        calendar.delegate = self
        calendar.dataSource = self
        view.addSubview(calendar)
        self.calendar = calendar

    }
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    
}
