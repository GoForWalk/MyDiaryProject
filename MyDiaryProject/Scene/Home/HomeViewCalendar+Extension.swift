//
//  HomeViewCalendar+Extension.swift
//  MyDiaryProject
//
//  Created by sae hun chung on 2022/08/26.
//

import UIKit
import FSCalendar
import RealmSwift

extension HomeViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return repository.fetchFilterByDate(date: date).count
    }
    
//    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
//        return "SeSAC"
//    }
    
//    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
//        return UIImage(systemName: "star.fill")
//    }
    
//    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
//        <#code#>
//    }
    
    // date: yyyyMMdd hh:mm:ss => dateformatter
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        
        formatter.dateFormat = "yyMMdd"
        return formatter.string(from: date) == "220907" ? "오프라인 모임": nil
    }

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        isCalenderTapped = true
        calenderDate = date
        print(repository.fetchFilterByDate(date: date))
        tasks = repository.fetchFilterByDate(date: date)
    }
}
