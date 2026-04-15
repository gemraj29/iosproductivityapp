package com.example.iosproductivity.calendar

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.iosproductivity.ui.theme.IosProductivityTheme
import java.time.LocalDate
import java.time.YearMonth
import java.time.format.DateTimeFormatter

@Composable
fun CalendarView() {
    var selectedDate by remember { mutableStateOf(LocalDate.now()) }
    val yearMonth = YearMonth.from(selectedDate)

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        // Month and Year Header
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {
            Text(
                text = yearMonth.format(DateTimeFormatter.ofPattern("MMMM yyyy")),
                style = MaterialTheme.typography.headlineMedium,
                color = MaterialTheme.colorScheme.onPrimary
            )
            Row {
                IconButton(onClick = { selectedDate = selectedDate.minusMonths(1) }) {
                    Icon(
                        imageVector = Icons.Default.ArrowBack,
                        contentDescription = "Previous Month",
                        tint = MaterialTheme.colorScheme.onPrimary
                    )
                }
                IconButton(onClick = { selectedDate = selectedDate.plusMonths(1) }) {
                    Icon(
                        imageVector = Icons.Default.ArrowForward,
                        contentDescription = "Next Month",
                        tint = MaterialTheme.colorScheme.onPrimary
                    )
                }
            }
        }

        Spacer(modifier = Modifier.height(16.dp))

        // Day of Week Header
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceAround
        ) {
            DayOfWeekHeader("Sun")
            DayOfWeekHeader("Mon")
            DayOfWeekHeader("Tue")
            DayOfWeekHeader("Wed")
            DayOfWeekHeader("Thu")
            DayOfWeekHeader("Fri")
            DayOfWeekHeader("Sat")
        }

        Spacer(modifier = Modifier.height(8.dp))

        // Calendar Grid
        Column(
            modifier = Modifier.fillMaxWidth()
        ) {
            val daysInMonth = yearMonth.lengthOfMonth()
            val firstDayOfMonth = yearMonth.atDay(1)
            val dayOfWeekOfFirstDay = firstDayOfMonth.dayOfWeek.value % 7 // 0 for Sunday, 1 for Monday, etc.

            var dayCounter = 1
            for (week in 0 until 6) { // Max 6 weeks to display a month
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceAround
                ) {
                    for (dayOfWeek in 0 until 7) {
                        if ((week == 0 && dayOfWeek < dayOfWeekOfFirstDay) || dayCounter > daysInMonth) {
                            // Empty cell for days before the first day of the month or after the last day
                            Box(modifier = Modifier.size(40.dp))
                        } else {
                            val currentDate = yearMonth.atDay(dayCounter)
                            DayCell(
                                day = dayCounter.toString(),
                                isSelected = currentDate == selectedDate,
                                onClick = { selectedDate = currentDate }
                            )
                            dayCounter++
                        }
                    }
                }
                Spacer(modifier = Modifier.height(8.dp))
            }
        }

        Spacer(modifier = Modifier.weight(1f)) // Pushes content to the top

        // Selected Date Display
        Text(
            text = "Selected: ${selectedDate.format(DateTimeFormatter.ofPattern("MMM dd, yyyy"))}",
            style = MaterialTheme.typography.bodyLarge,
            color = MaterialTheme.colorScheme.onPrimary
        )
    }
}

@Composable
fun DayOfWeekHeader(day: String) {
    Text(
        text = day,
        fontWeight = FontWeight.Bold,
        fontSize = 12.sp,
        color = MaterialTheme.colorScheme.onPrimary.copy(alpha = 0.7f)
    )
}

@Composable
fun DayCell(day: String, isSelected: Boolean, onClick: () -> Unit) {
    val backgroundColor = if (isSelected) MaterialTheme.colorScheme.primary else Color.Transparent
    val textColor = if (isSelected) MaterialTheme.colorScheme.onPrimary else MaterialTheme.colorScheme.onPrimary

    Box(
        modifier = Modifier
            .size(40.dp)
            .clickable(onClick = onClick),
        contentAlignment = Alignment.Center
    ) {
        Surface(
            shape = CircleShape,
            color = backgroundColor,
            modifier = Modifier.fillMaxSize()
        ) {
            Text(
                text = day,
                color = textColor,
                fontSize = 14.sp,
                fontWeight = if (isSelected) FontWeight.Bold else FontWeight.Normal
            )
        }
    }
}

// Preview function
@Composable
fun PreviewCalendarView() {
    IosProductivityTheme {
        Surface(modifier = Modifier.fillMaxSize(), color = MaterialTheme.colorScheme.background) {
            CalendarView()
        }
    }
}
// Add necessary imports for Icons.Default
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ArrowBack
import androidx.compose.material.icons.filled.ArrowForward
import androidx.compose.foundation.clickable
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.ui.graphics.vector.ImageVector
