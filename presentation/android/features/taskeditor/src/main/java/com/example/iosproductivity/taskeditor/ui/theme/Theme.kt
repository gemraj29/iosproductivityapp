```kotlin
package com.example.iosproductivity.ui.theme

import android.app.Activity
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.darkColorScheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.SideEffect
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.toArgb
import androidx.compose.ui.platform.LocalView
import androidx.compose.ui.platform.LocalWindowInfo
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.tooling.preview.Preview

// Define your color schemes based on the provided design tokens
private val LightColors = lightColorScheme(
    primary = md_theme_light_primary,
    onPrimary = md_theme_light_onPrimary,
    primaryContainer = md_theme_light_primaryContainer,
    onPrimaryContainer = md_theme_light_onPrimaryContainer,
    secondary = md_theme_light_secondary,
    onSecondary = md_theme_light_onSecondary,
    secondaryContainer = md_theme_light_secondaryContainer,
    onSecondaryContainer = md_theme_light_onSecondaryContainer,
    tertiary = md_theme_light_tertiary,
    onTertiary = md_theme_light_onTertiary,
    tertiaryContainer = md_theme_light_tertiaryContainer,
    onTertiaryContainer = md_theme_light_onTertiaryContainer,
    error = md_theme_light_error,
    onError = md_theme_light_onError,
    errorContainer = md_theme_light_errorContainer,
    onErrorContainer = md_theme_light_onErrorContainer,
    background = md_theme_light_background,
    onBackground = md_theme_light_onBackground,
    surface = md_theme_light_surface,
    onSurface = md_theme_light_onSurface,
    surfaceVariant = md_theme_light_surfaceVariant,
    onSurfaceVariant = md_theme_light_onSurfaceVariant,
    outline = md_theme_light_outline,
    outlineVariant = md_theme_light_outlineVariant,
    scrim = md_theme_light_scrim,
)

// Add a DarkColors scheme if needed, mapping to dark theme design tokens
private val DarkColors = darkColorScheme(
    primary = Color(0xFF90CAF9), // Example dark primary color
    onPrimary = Color(0xFF000000),
    primaryContainer = Color(0xFF2196F3),
    onPrimaryContainer = Color(0xFFFFFFFF),
    secondary = Color(0xFF90CAF9), // Example dark secondary color
    onSecondary = Color(0xFF000000),
    secondaryContainer = Color(0xFF1976D2),
    onSecondaryContainer = Color(0xFFFFFFFF),
    background = Color(0xFF121212), // Dark background
    onBackground = Color(0xFFFFFFFF),
    surface = Color(0xFF1E1E1E), // Dark surface
    onSurface = Color(0xFFFFFFFF),
    // ... map other dark theme colors as needed
)

@Composable
fun IOSProductivityTheme(
    darkTheme: Boolean = isSystemInDarkTheme(),
    content: @Composable () -> Unit
) {
    val colorScheme = when {
        darkTheme -> DarkColors
        else -> LightColors
    }
    val view = LocalView.current
    if (!view.isInEditMode) {
        SideEffect {
            val activity = view.context as Activity
            activity.window.statusBarColor = colorScheme.primary.toArgb()
            // You can also set navigation bar color here if needed
            // activity.window.navigationBarColor = colorScheme.background.toArgb()
            // Set status bar text/icon color based on background
            // This requires checking the contrast ratio or using a helper function
            // For simplicity, assuming light status bar icons for dark primary color
            // and dark status bar icons for light primary color.
            // A more robust solution would involve checking color brightness.
            if (darkTheme) {
                 // For dark theme, primary color might be light, so use dark icons
                 // Or if primary is dark, use light icons.
                 // This part is complex and depends on your specific dark theme primary color.
                 // For now, let's assume default behavior or set explicitly if needed.
            } else {
                // For light theme, primary color is dark, so use light icons
                // activity.window.decorView.systemUiVisibility = (view.systemUiVisibility or View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR.inv())
            }
        }
    }

    MaterialTheme(
        colorScheme = colorScheme,
        typography = Typography, // Assuming Typography is defined in Typography.kt
        content = content
    )
}

@Preview(showBackground = true)
@Composable
fun ThemePreview() {
    IOSProductivityTheme {
        // Example content to show the theme
        Column(
            modifier = Modifier
                .fillMaxSize()
                .background(MaterialTheme.colorScheme.background)
                .padding(16.dp),
            verticalArrangement = Arrangement.spacedBy(8.dp)
        ) {
            Text("Primary Color", color = MaterialTheme.colorScheme.primary)
            Text("Secondary Color", color = MaterialTheme.colorScheme.secondary)
            Text("Surface Color", color = MaterialTheme.colorScheme.surface)
            Text("Background Color", color = MaterialTheme.colorScheme.background)
            Button(onClick = { /*TODO*/ }) {
                Text("Sample Button")
            }
        }
    }
}
```
