import SwiftUI

struct CalendarView: View {
    @State private var selectedDate = Date()
    @State private var eventsForDate: [String] = [] // Placeholder for events

    // Mock data for demonstration
    let mockEvents = [
        Calendar.current.date(byAdding: .day, value: 0, to: Date())!: ["Meeting with team", "Plan sprint"],
        Calendar.current.date(byAdding: .day, value: 2, to: Date())!: ["Code review", "Update documentation"],
        Calendar.current.date(byAdding: .day, value: 5, to: Date())!: ["Client call"]
    ]

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Calendar Header (Month/Year)
                HStack {
                    Text(formattedMonthYear(date: selectedDate))
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(Color(hex: "#00334d")) // primary
                    Spacer()
                    Button {
                        // Action to go to previous month
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color(hex: "#53606b")) // secondary
                    }
                    Button {
                        // Action to go to next month
                    } label: {
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color(hex: "#53606b")) // secondary
                    }
                }
                .padding(.horizontal)
                .padding(.top)

                // Calendar Grid
                CalendarGridView(selectedDate: $selectedDate)
                    .padding(.horizontal)
                    .padding(.vertical, 8)

                Divider()
                    .background(Color(hex: "#53606b").opacity(0.3)) // secondary with opacity

                // Events List for Selected Date
                VStack(alignment: .leading) {
                    Text("Events for \(formattedDate(date: selectedDate))")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(Color(hex: "#00334d")) // primary
                        .padding(.horizontal)
                        .padding(.top)

                    if eventsForDate.isEmpty {
                        Text("No events for this day.")
                            .font(.system(size: 16, design: .rounded))
                            .foregroundColor(Color(hex: "#53606b")) // secondary
                            .padding(.horizontal)
                            .padding(.top, 2)
                    } else {
                        List(eventsForDate, id: \.self) { event in
                            Text(event)
                                .font(.system(size: 16, design: .rounded))
                                .foregroundColor(Color(hex: "#00334d")) // primary
                        }
                        .listStyle(.plain)
                        .background(Color(hex: "#f7f9fc")) // bg
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .background(Color(hex: "#f7f9fc")) // bg
            }
            .background(Color(hex: "#f7f7f7").ignoresSafeArea()) // Slightly different background for the whole view
            .onAppear {
                updateEventsForSelectedDate()
            }
            .onChange(of: selectedDate) { _ in
                updateEventsForSelectedDate()
            }
            .navigationTitle("Calendar")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func formattedMonthYear(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }

    private func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
        return formatter.string(from: date)
    }

    private func updateEventsForSelectedDate() {
        // In a real app, this would fetch data from your application layer
        // For now, we use mock data
        let today = Calendar.current.startOfDay(for: selectedDate)
        eventsForDate = mockEvents.first(where: { Calendar.current.isDate($0.key, inSameDayAs: today) })?.value ?? []
    }
}

struct CalendarGridView: View {
    @Binding var selectedDate: Date
    @State private var daysInMonth: [[Date]] = []

    private let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    private let gridColumns = Array(repeating: GridItem(.flexible()), count: 7)

    var body: some View {
        VStack {
            // Days of the week header
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundColor(Color(hex: "#53606b")) // secondary
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.bottom, 4)

            // Calendar grid
            LazyVGrid(columns: gridColumns, spacing: 8) {
                ForEach(daysInMonth.flatMap { $0 }, id: \.self) { date in
                    Text("\(Calendar.current.component(.day, from: date))")
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .frame(maxWidth: .infinity, minHeight: 30)
                        .padding(4)
                        .background(
                            Circle()
                                .fill(isSameDay(date, selectedDate) ? Color(hex: "#004b6e") : Color.clear) // primary-container for selected
                        )
                        .foregroundColor(isSameDay(date, selectedDate) ? Color(hex: "#ffffff") : Color(hex: "#00334d")) // on-primary for selected, primary for others
                        .clipShape(Circle())
                        .onTapGesture {
                            selectedDate = date
                        }
                }
            }
        }
        .onAppear {
            generateDaysInMonth()
        }
        .onChange(of: selectedDate) { _ in
            generateDaysInMonth() // Regenerate if selected date changes month
        }
    }

    private func generateDaysInMonth() {
        let calendar = Calendar.current
        let month = calendar.dateInterval(of: .month, for: selectedDate)!
        var days = month.start
        var datesInMonth: [[Date]] = []
        var week: [Date] = []

        // Add days from previous month to fill the first week
        let firstWeekdayOfMonth = calendar.component(.weekday, from: month.start)
        let daysBeforeFirst = firstWeekdayOfMonth - 1 // Assuming Sunday is 1
        if daysBeforeFirst > 0 {
            for i in (1...daysBeforeFirst).reversed() {
                if let prevDay = calendar.date(byAdding: .day, value: -i, to: month.start) {
                    week.insert(prevDay, at: 0)
                }
            }
        }

        // Add days of the current month
        while days <= month.end {
            week.append(days)
            if week.count == 7 {
                datesInMonth.append(week)
                week = []
            }
            days = calendar.date(byAdding: .day, value: 1, to: days)!
        }

        // Add remaining days to complete the last week
        if !week.isEmpty {
            while week.count < 7 {
                if let nextDay = calendar.date(byAdding: .day, value: 1, to: days.addingTimeInterval(-1)) {
                    week.append(nextDay)
                }
            }
            datesInMonth.append(week)
        }
        self.daysInMonth = datesInMonth
    }

    private func isSameDay(_ date1: Date, _ date2: Date) -> Bool {
        return Calendar.current.isDate(date1, inSameDayAs: date2)
    }
}

// Helper extension for Hex Colors
extension Color {
    init(hex: String, alpha: Double = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var rgb: UInt64 = 0

        Scanner(string: hexFormatted).scanU
        Int64(&rgb)

        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
