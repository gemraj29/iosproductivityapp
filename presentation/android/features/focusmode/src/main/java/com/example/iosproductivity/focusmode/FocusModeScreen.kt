```kotlin
package com.example.iosproductivity.focusmode

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.iosproductivity.ui.theme.IOSProductivityTheme
import com.example.iosproductivity.ui.theme.interFontFamily

// Design Tokens (extracted from project DNA)
private val primaryColor = Color(0xFF00334D) // #00334d
private val secondaryColor = Color(0xFF53606B) // #53606b
private val backgroundColor = Color(0xFFF7F9FC) // #f7f9fc
private val surfaceColor = Color(0xFFF7F9FC) // #f7f7f9fc
private val onPrimaryColor = Color(0xFFFFFFFF) // #ffffff
private val primaryContainerColor = Color(0xFF004B6E) // #004b6e
private val secondaryFixedDimColor = Color(0xFFBBC8D5) // #bbc8d5
private val tertiaryFixedDimColor = Color(0xFFFFB4A1) // #ffb4a1
private val radius = 0.25f // Corresponds to 4.dp with a base spacing of 4px

// Spacing (extracted from project DNA)
private val spacingSmall = 4.dp
private val spacingMedium = 8.dp
private val spacingLarge = 16.dp
private val spacingExtraLarge = 32.dp

@Composable
fun FocusModeScreen(
    modifier: Modifier = Modifier,
    focusDurationMinutes: Int = 25,
    onStartFocus: () -> Unit,
    onStopFocus: () -> Unit,
    isFocusActive: Boolean = false
) {
    var remainingTime by remember { mutableStateOf(focusDurationMinutes * 60) }
    var isTimerRunning by remember { mutableStateOf(false) }

    // Effect to update timer when isTimerRunning changes
    LaunchedEffect(isTimerRunning, remainingTime) {
        if (isTimerRunning && remainingTime > 0) {
            kotlinx.coroutines.delay(1000L)
            remainingTime--
        } else if (remainingTime == 0) {
            isTimerRunning = false
            // Optionally trigger an event when timer ends
        }
    }

    // Reset timer when focus duration changes or focus is stopped
    LaunchedEffect(focusDurationMinutes, isFocusActive) {
        if (!isFocusActive) {
            remainingTime = focusDurationMinutes * 60
            isTimerRunning = false
        }
    }

    Column(
        modifier = modifier
            .fillMaxSize()
            .background(backgroundColor)
            .padding(spacingLarge),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.SpaceBetween
    ) {
        // Header
        Text(
            text = "Focus Mode",
            style = MaterialTheme.typography.headlineMedium.copy(
                fontFamily = interFontFamily,
                fontWeight = FontWeight.Bold,
                color = primaryColor
            ),
            modifier = Modifier.padding(bottom = spacingExtraLarge)
        )

        // Timer Display
        Column(
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.Center
        ) {
            Text(
                text = formatTime(remainingTime),
                style = MaterialTheme.typography.displayLarge.copy(
                    fontFamily = interFontFamily,
                    fontWeight = FontWeight.Bold,
                    color = primaryColor
                )
            )
            Text(
                text = "Remaining",
                style = MaterialTheme.typography.titleMedium.copy(
                    fontFamily = interFontFamily,
                    color = secondaryColor
                ),
                modifier = Modifier.padding(top = spacingSmall)
            )
        }

        // Action Buttons
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceEvenly,
            verticalAlignment = Alignment.CenterVertically
        ) {
            Button(
                onClick = {
                    if (isTimerRunning) {
                        onStopFocus()
                        isTimerRunning = false
                    } else {
                        onStartFocus()
                        isTimerRunning = true
                    }
                },
                shape = RoundedCornerShape(radius.dp),
                colors = ButtonDefaults.buttonColors(
                    containerColor = if (isTimerRunning) tertiaryFixedDimColor else primaryContainerColor, // Use different colors for start/stop
                    contentColor = onPrimaryColor
                ),
                modifier = Modifier.height(56.dp).weight(1f).padding(horizontal = spacingSmall)
            ) {
                Text(
                    text = if (isTimerRunning) "Stop Focus" else "Start Focus",
                    style = MaterialTheme.typography.titleMedium.copy(
                        fontFamily = interFontFamily,
                        fontWeight = FontWeight.SemiBold
                    )
                )
            }
        }
    }
}

// Helper function to format time in MM:SS
fun formatTime(seconds: Int): String {
    val minutes = seconds / 60
    val remainingSeconds = seconds % 60
    return String.format("%02d:%02d", minutes, remainingSeconds)
}

@Preview(showBackground = true)
@Composable
fun PreviewFocusModeScreen() {
    IOSProductivityTheme {
        FocusModeScreen(
            onStartFocus = { /*TODO*/ },
            onStopFocus = { /*TODO*/ },
            isFocusActive = false
        )
    }
}

@Preview(showBackground = true)
@Composable
fun PreviewFocusModeScreenActive() {
    IOSProductivityTheme {
        FocusModeScreen(
            onStartFocus = { /*TODO*/ },
            onStopFocus = { /*TODO*/ },
            isFocusActive = true,
            focusDurationMinutes = 1 // Shorter duration for preview
        )
    }
}
```
