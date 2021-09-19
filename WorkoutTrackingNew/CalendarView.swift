//
//  CalendarView.swift
//  WorkoutTrackingNew
//
//  Created by Divy Gobiraj on 9/16/21.
//

import SwiftUI

struct CalendarView: View {
    @Environment(\.calendar) var calendar
   
    var dates: [Date]
   
    var body: some View {
        Text("Calendar View")
        
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(dates: [Date(),Date()])
    }
}
