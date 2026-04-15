package com.example.iosproductivity.ui.theme

import android.app.Activity
import android.os.Build
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.darkColorScheme
import androidx.compose.material3.dynamicDarkColorScheme
import androidx.compose.material3.dynamicLightColorScheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.SideEffect
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.toArgb
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.platform.LocalView
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.googleFont
import androidx.compose.ui.text.googleFontFamily

// Define custom colors based on the project DNA
private val Primary = Color(0xFF00334d) // #00334d
private val Secondary = Color(0xFF53606b) // #53606b
private val Background = Color(0xFFF7F9FC) // #f7f9fb
private val Surface = Color(0xFFF7F9FC) // #f7f9fb

private val OnPrimary = Color(0xFFFFFFFF) // #ffffff
private val Outline = Color(0xFF71787F) // #71787f
private val TertiaryFixed = Color(0xFFFFDBD2) // #ffdbd2
private val ErrorContainer = Color(0xFFFFDAD6) // #ffdad6
private val OnSecondaryFixed = Color(0xFF101D26) // #101d26
private val OnError = Color(0xFFFFFFFF) // #ffffff
private val PrimaryContainer = Color(0xFF004B6E) // #004b6e
private val OnPrimaryFixedVariant = Color(0xFF014B6E) // #014b6e
private val SecondaryFixedDim = Color(0xFFBBC8D5) // #bbc8d5
private val TertiaryFixedDim = Color(0xFFFFB4A1) // #ffb4a1

// Define font family
val InterFontFamily = FontFamily(
    googleFontFamily(
        name = "Inter",
        // You might need to add font weights here if you have them in your assets
        // e.g., fontProvider = GoogleFontProvider(
        //     weights = listOf(FontWeight.W400, FontWeight.W700)
        // )
    )
)

private val DarkColorScheme = darkColorScheme(
    primary = Primary,
    onPrimary = OnPrimary,
    primaryContainer = PrimaryContainer,
    onPrimaryContainer = Color.White, // Assuming white text on primary container
    secondary = Secondary,
    onSecondary = Color.White, // Assuming white text on secondary
    secondaryContainer = SecondaryFixedDim,
    onSecondaryContainer = OnSecondaryFixed,
    tertiary = TertiaryFixed,
    onTertiary = Color.Black, // Assuming black text on tertiary
    tertiaryContainer = TertiaryFixedDim,
    onTertiaryContainer = Color.Black, // Assuming black text on tertiary container
    error = Color.Red, // Default error color, adjust if needed
    onError = OnError,
    errorContainer = ErrorContainer,
    onErrorContainer = Color.Black, // Assuming black text on error container
    background = Background,
    onBackground = Color.Black, // Assuming black text on background
    surface = Surface,
    onSurface = Color.Black, // Assuming black text on surface
    surfaceVariant = Color.Gray, // Placeholder, adjust if needed
    onSurfaceVariant = Color.DarkGray, // Placeholder, adjust if needed
    outline = Outline,
    outlineVariant = Color.LightGray // Placeholder, adjust if needed
)

private val LightColorScheme = lightColorScheme(
    primary = Primary,
    onPrimary = OnPrimary,
    primaryContainer = PrimaryContainer,
    onPrimaryContainer = Color.White, // Assuming white text on primary container
    secondary = Secondary,
    onSecondary = Color.White, // Assuming white text on secondary
    secondaryContainer = SecondaryFixedDim,
    onSecondaryContainer = OnSecondaryFixed,
    tertiary = TertiaryFixed,
    onTertiary = Color.Black, // Assuming black text on tertiary
    tertiaryContainer = TertiaryFixedDim,
    onTertiaryContainer = Color.Black, // Assuming black text on tertiary container
    error = Color.Red, // Default error color, adjust if needed
    onError = OnError,
    errorContainer = ErrorContainer,
    onErrorContainer = Color.Black, // Assuming black text on error container
    background = Background,
    onBackground = Color.Black, // Assuming black text on background
    surface = Surface,
    onSurface = Color.Black, // Assuming black text on surface
    surfaceVariant = Color.Gray, // Placeholder, adjust if needed
    onSurfaceVariant = Color.DarkGray, // Placeholder, adjust if needed
    outline = Outline,
    outlineVariant = Color.LightGray // Placeholder, adjust if needed
)

@Composable
fun IOSProductivityTheme(
    darkTheme: Boolean = isSystemInDarkTheme(),
    // Dynamic color is available on Android 12+
    dynamicColor: Boolean = true,
    content: @Composable () -> Unit
) {
    val colorScheme = when {
        dynamicColor && Build.VERSION.SDK_INT >= Build.VERSION_CODES.S -> {
            val context = LocalContext.current
            if (darkTheme) dynamicDarkColorScheme(context) else dynamicLightColorScheme(context)
        }

        darkTheme -> DarkColorScheme
        else -> LightColorScheme
    }
    val view = LocalView.current
    if (!view.isInEditMode) {
        SideEffect {
            val window = (view.context as Activity).window
            window.statusBarColor = colorScheme.primary.toArgb()
            window.navigationBarColor = colorScheme.background.toArgb() // Match background for navigation bar
            // Set system UI visibility flags for edge-to-edge display if needed
            // WindowCompat.getInsetsController().isAppearanceLightStatusBars = darkTheme
        }
    }

    MaterialTheme(
        colorScheme = colorScheme,
        typography = Typography(fontFamily = InterFontFamily), // Apply custom font family
        content = content
    )
}
