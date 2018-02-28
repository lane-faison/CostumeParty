import UIKit
import FSCalendar

class CalendarView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var effectView: UIVisualEffectView!
    @IBOutlet weak var calendar: FSCalendar!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
}

extension CalendarView {
    private func commonInit() {
        Bundle.main.loadNibNamed("CalendarView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        
        setupCalendar()
    }
    private func setupCalendar() {
        calendar.delegate = self
        calendar.dataSource = self
    }
}

extension CalendarView: FSCalendarDelegate, FSCalendarDataSource {
    
}
