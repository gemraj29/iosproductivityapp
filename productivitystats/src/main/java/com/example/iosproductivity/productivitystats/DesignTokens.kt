```kotlin
package com.example.iosproductivity.productivitystats

import androidx.compose.ui.graphics.Color

// Mock Design Tokens - Replace with actual implementation from core.design.theme
object MockDesignTokens {
    val primary = Color(0xFF00334d) // #00334d
    val onPrimary = Color(0xFFFFFFFF) // #ffffff
    val primaryContainer = Color(0xFF004B6E) // #004b6e
    val onPrimaryContainer = Color(0xFFFFFFFF) // Assuming on-primary-fixed-variant is similar to on-primary

    val secondary = Color(0xFF53606B) // #53606B
    val onSecondary = Color(0xFFFFFFFF) // Assuming on-secondary is similar to on-primary
    val secondaryContainer = Color(0xFFBBC8D5) // #bbc8d5
    val onSecondaryContainer = Color(0xFF101D26) // #101d26

    val tertiary = Color(0xFF8D4E4C) // Example tertiary color
    val onTertiary = Color(0xFFFFFFFF)
    val tertiaryContainer = Color(0xFFFFDBD2) // #ffdbd2
    val onTertiaryContainer = Color(0xFF8D4E4C) // Assuming on-tertiary-fixed-variant is similar to tertiary

    val error = Color(0xFFBA1A1A) // Standard error color
    val onError = Color(0xFFFFFFFF)
    val errorContainer = Color(0xFFFFDAD6) // #ffdad6
    val onErrorContainer = Color(0xFF410002)

    val surface = Color(0xFFF7F9FC) // #f7f9fc
    val onSurface = Color(0xFF1A1C1E) // Dark text on light surface
    val surfaceVariant = Color(0xFFDDE3EA) // Example surface variant
    val onSurfaceVariant = Color(0xFF41484D) // #71787f (outline)

    val outline = Color(0xFF71787F) // #71787f

    // Spacing
    val spacingExtraSmall = 2.dp
    val spacingSmall = 4.dp
    val spacingMedium = 8.dp
    val spacingLarge = 16.dp
    val spacingExtraLarge = 32.dp

    // Font sizes (example)
    val fontSizeSmall = 12.sp
    val fontSizeMedium = 14.sp
    val fontSizeLarge = 16.sp
    val fontSizeHeadlineSmall = 24.sp
    val fontSizeHeadlineMedium = 28.sp
    val fontSizeHeadlineLarge = 32.sp
}
```
