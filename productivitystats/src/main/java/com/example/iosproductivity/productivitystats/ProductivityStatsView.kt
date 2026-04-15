```kotlin
package com.example.iosproductivity.productivitystats

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.iosproductivity.core.design.theme.IosProductivityTheme
import com.example.iosproductivity.core.design.theme.LocalDesignTokens

@Composable
fun ProductivityStatsView() {
    val designTokens = LocalDesignTokens.current
    val scrollState = rememberScrollState()

    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(designTokens.surface)
            .padding(designTokens.spacingMedium)
            .verticalScroll(scrollState),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Text(
            text = "Productivity Stats",
            style = MaterialTheme.typography.headlineMedium,
            fontWeight = FontWeight.Bold,
            color = designTokens.onSurface,
            modifier = Modifier.padding(bottom = designTokens.spacingLarge)
        )

        // Example Stat Card: Tasks Completed
        StatCard(
            title = "Tasks Completed",
            value = "125",
            description = "This week",
            icon = "✅", // Placeholder for actual icon
            designTokens = designTokens
        )

        Spacer(modifier = Modifier.height(designTokens.spacingMedium))

        // Example Stat Card: Focus Time
        StatCard(
            title = "Focus Time",
            value = "45",
            description = "Hours this month",
            icon = "⏱️", // Placeholder for actual icon
            designTokens = designTokens
        )

        Spacer(modifier = Modifier.height(designTokens.spacingMedium))

        // Example Stat Card: Projects Completed
        StatCard(
            title = "Projects Completed",
            value = "5",
            description = "This quarter",
            icon = "🚀", // Placeholder for actual icon
            designTokens = designTokens
        )

        Spacer(modifier = Modifier.height(designTokens.spacingMedium))

        // Add more stat cards as needed based on stitch/productivity_stats/code.html
    }
}

@Composable
fun StatCard(
    title: String,
    value: String,
    description: String,
    icon: String, // Placeholder for actual icon Composable
    designTokens: com.example.iosproductivity.core.design.theme.DesignTokens
) {
    Card(
        modifier = Modifier
            .fillMaxWidth()
            .padding(designTokens.spacingSmall),
        colors = CardDefaults.cardColors(containerColor = designTokens.surface),
        elevation = CardDefaults.elevatedCardElevation(defaultElevation = 2.dp) // Subtle elevation
    ) {
        Row(
            modifier = Modifier
                .padding(designTokens.spacingMedium)
                .fillMaxWidth(),
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            Column(
                modifier = Modifier.weight(1f) // Take available space
            ) {
                Text(
                    text = title,
                    style = MaterialTheme.typography.titleMedium,
                    color = designTokens.onSurface,
                    fontWeight = FontWeight.SemiBold
                )
                Text(
                    text = description,
                    style = MaterialTheme.typography.bodySmall,
                    color = designTokens.onSurfaceVariant
                )
            }
            Spacer(modifier = Modifier.width(designTokens.spacingMedium))
            Column(
                horizontalAlignment = Alignment.End
            ) {
                Text(
                    text = icon, // Displaying icon as text for now
                    fontSize = 32.sp,
                    fontWeight = FontWeight.Bold,
                    color = designTokens.primary
                )
                Text(
                    text = value,
                    style = MaterialTheme.typography.headlineLarge,
                    fontWeight = FontWeight.Bold,
                    color = designTokens.onSurface
                )
            }
        }
    }
}

// Preview function
@Preview(showBackground = true)
@Composable
fun ProductivityStatsViewPreview() {
    IosProductivityTheme {
        ProductivityStatsView()
    }
}
```
