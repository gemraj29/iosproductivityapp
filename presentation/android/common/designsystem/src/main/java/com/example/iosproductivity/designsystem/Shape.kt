package com.example.iosproductivity.designsystem

import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.ui.unit.dp

// Design Tokens from Project DNA
val CornerRadius = 0.25f // This is a relative value, typically converted to dp

// Convert relative radius to dp, assuming a base unit or a reasonable default
// For example, if 0.25f means 25% of a standard spacing unit (4px), then it's 1px.
// However, design systems often use fixed dp values. Let's assume 0.25rem which is roughly 4dp.
val ShapeRadiusSmall = 4.dp
val ShapeRadiusMedium = 8.dp
val ShapeRadiusLarge = 16.dp

val AppShape = RoundedCornerShape(ShapeRadiusSmall)
