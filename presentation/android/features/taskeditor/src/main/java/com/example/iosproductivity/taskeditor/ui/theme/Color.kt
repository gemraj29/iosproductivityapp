```kotlin
package com.example.iosproductivity.ui.theme

import androidx.compose.ui.graphics.Color

// Project DNA Colors
val Primary = Color(0xFF00334d)
val Secondary = Color(0xFF53606b)
val Background = Color(0xFFF7F9FC)
val Surface = Color(0xFFF7F9FC)

// Design Tokens
val OnPrimary = Color(0xFFFFFFFF)
val Outline = Color(0xFF71787F)
val TertiaryFixed = Color(0xFFFFDBD2)
val ErrorContainer = Color(0xFFFFDAD6)
val OnSecondaryFixed = Color(0xFF101D26)
val OnError = Color(0xFFFFFFFF)
val PrimaryContainer = Color(0xFF004B6E)
val OnPrimaryFixedVariant = Color(0xFF014B6E)
val SecondaryFixedDim = Color(0xFFBBC8D5)
val TertiaryFixedDim = Color(0xFFFFB4A1)

// Custom Theme Colors (mapping to Material 3)
val LightColorScheme = darkColors( // Using darkColors to map to Material 3's dark theme structure for clarity, but it's for light mode
    primary = Primary,
    onPrimary = OnPrimary,
    primaryContainer = PrimaryContainer,
    onPrimaryContainer = OnPrimary, // Assuming onPrimaryContainer is same as onPrimary for simplicity
    secondary = Secondary,
    onSecondary = OnPrimary, // Assuming onSecondary is same as onPrimary
    secondaryContainer = SecondaryFixedDim, // Mapping secondaryContainer to a dim variant
    onSecondaryContainer = OnSecondaryFixed,
    tertiary = TertiaryFixed,
    onTertiary = OnError, // Mapping onTertiary to OnError
    tertiaryContainer = TertiaryFixedDim, // Mapping tertiaryContainer to a dim variant
    onTertiaryContainer = OnPrimary, // Assuming onTertiaryContainer is same as onPrimary
    error = ErrorContainer, // Mapping error to ErrorContainer
    onError = OnError,
    errorContainer = ErrorContainer,
    onErrorContainer = OnError,
    background = Background,
    onBackground = Color.Black, // Default onBackground
    surface = Surface,
    onSurface = Color.Black, // Default onSurface
    surfaceVariant = Secondary, // Mapping surfaceVariant to secondary for example
    onSurfaceVariant = SecondaryFixedDim // Mapping onSurfaceVariant to a dim variant of secondary
)

// You might want to define a dark theme as well if needed
// val DarkColorScheme = lightColors(...)

// For the purpose of this example, we'll use a simplified mapping for demonstration.
// In a real app, you'd carefully map all Material 3 color roles.

// Example mapping for TaskEditorScreen's OutlinedTextField and Button colors
val md_theme_light_primary = Primary
val md_theme_light_onPrimary = OnPrimary
val md_theme_light_primaryContainer = PrimaryContainer
val md_theme_light_onPrimaryContainer = OnPrimary
val md_theme_light_secondary = Secondary
val md_theme_light_onSecondary = OnPrimary
val md_theme_light_secondaryContainer = SecondaryFixedDim
val md_theme_light_onSecondaryContainer = OnSecondaryFixed
val md_theme_light_tertiary = TertiaryFixed
val md_theme_light_onTertiary = OnError
val md_theme_light_tertiaryContainer = TertiaryFixedDim
val md_theme_light_onTertiaryContainer = OnPrimary
val md_theme_light_error = ErrorContainer
val md_theme_light_onError = OnError
val md_theme_light_errorContainer = ErrorContainer
val md_theme_light_onErrorContainer = OnError
val md_theme_light_background = Background
val md_theme_light_onBackground = Color.Black
val md_theme_light_surface = Surface
val md_theme_light_onSurface = Color.Black
val md_theme_light_surfaceVariant = Secondary
val md_theme_light_onSurfaceVariant = SecondaryFixedDim
val md_theme_light_outline = Outline
val md_theme_light_outlineVariant = Color.Gray // Example
val md_theme_light_scrim = Color.Black // Example
```
