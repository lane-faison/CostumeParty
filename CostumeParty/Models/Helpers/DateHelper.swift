import Foundation

public struct DateHelper {
    
    static func convertDateToString(date: Date?) -> String? {
        guard let date = date else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let stringDate: String = formatter.string(from: date)
        return stringDate
    }
    
    static func convertStringToDate(string: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        guard let date: Date = formatter.date(from: string) else { return nil }
        return date
    }
    
    static func convertDateToStringForDisplay(date: Date?) -> String? {
        guard let date = date else { return nil }
        let dateString = DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .none)
        return dateString
    }
}
