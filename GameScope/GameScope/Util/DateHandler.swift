//
//  DateHandler.swift
//  GameScope
//
//  Created by DONGWOOK SEO on 2023/07/15.
//

import Foundation

final class DateHandler {
    // MARK: - Constants

    // MARK: - Properties
    private let dateFormatter = DateFormatter()

    // MARK: - Public
    func dayCount(from startDateString: String? = nil, to endDateString: String) -> Int? {

        var date = convertDateToString(date: Date())

        if let startDateString {
            date = startDateString
        }

        guard let startDate = convertStringToDate(dateString: date),
              let endDate = convertStringToDate(dateString: endDateString) else { return nil }

        let calendar = Calendar.current
        let terms = calendar.dateComponents([.day], from: startDate, to: endDate)
        let days = terms.day

        return days
    }

    // MARK: - Private
    private func convertStringToDate(dateString: String) -> Date? {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: dateString) else { return nil }

        return date
    }

    private func convertDateToString(date: Date) -> String {
        let calendar = Calendar.current

        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)

        return "\(year)-\(month)-\(day)"
    }

}
