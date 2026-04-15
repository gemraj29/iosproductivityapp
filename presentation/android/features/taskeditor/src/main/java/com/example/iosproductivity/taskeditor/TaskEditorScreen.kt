```kotlin
package com.example.iosproductivity.taskeditor

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.iosproductivity.ui.theme.* // Assuming your theme is here

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun TaskEditorScreen(
    taskTitle: String = "",
    taskDescription: String = "",
    onTitleChange: (String) -> Unit = {},
    onDescriptionChange: (String) -> Unit = {},
    onSaveClick: () -> Unit = {},
    onCancelClick: () -> Unit = {}
) {
    var title by remember { mutableStateOf(taskTitle) }
    var description by remember { mutableStateOf(taskDescription) }

    // Update state if initial values change (e.g., when editing an existing task)
    LaunchedEffect(taskTitle) {
        title = taskTitle
    }
    LaunchedEffect(taskDescription) {
        description = taskDescription
    }

    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Task Editor", color = MaterialTheme.colorScheme.onPrimary) },
                colors = TopAppBarDefaults.topAppBarColors(
                    containerColor = MaterialTheme.colorScheme.primary,
                    titleContentColor = MaterialTheme.colorScheme.onPrimary
                )
            )
        },
        containerColor = MaterialTheme.colorScheme.surface // Use surface color for background
    ) { paddingValues ->
        Column(
            modifier = Modifier
                .padding(paddingValues)
                .padding(16.dp)
                .fillMaxSize(),
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.spacedBy(16.dp)
        ) {
            // Task Title Input
            OutlinedTextField(
                value = title,
                onValueChange = {
                    title = it
                    onTitleChange(it)
                },
                label = { Text("Task Title") },
                modifier = Modifier.fillMaxWidth(),
                shape = RoundedCornerShape(8.dp), // Apply radius
                colors = OutlinedTextFieldDefaults.colors(
                    focusedBorderColor = MaterialTheme.colorScheme.primary,
                    unfocusedBorderColor = MaterialTheme.colorScheme.outline,
                    focusedLabelColor = MaterialTheme.colorScheme.primary,
                    unfocusedLabelColor = MaterialTheme.colorScheme.onSurfaceVariant,
                    cursorColor = MaterialTheme.colorScheme.primary,
                    focusedContainerColor = MaterialTheme.colorScheme.surface,
                    unfocusedContainerColor = MaterialTheme.colorScheme.surface
                )
            )

            // Task Description Input
            OutlinedTextField(
                value = description,
                onValueChange = {
                    description = it
                    onDescriptionChange(it)
                },
                label = { Text("Description") },
                modifier = Modifier
                    .fillMaxWidth()
                    .weight(1f), // Allow description to take available space
                shape = RoundedCornerShape(8.dp), // Apply radius
                colors = OutlinedTextFieldDefaults.colors(
                    focusedBorderColor = MaterialTheme.colorScheme.primary,
                    unfocusedBorderColor = MaterialTheme.colorScheme.outline,
                    focusedLabelColor = MaterialTheme.colorScheme.primary,
                    unfocusedLabelColor = MaterialTheme.colorScheme.onSurfaceVariant,
                    cursorColor = MaterialTheme.colorScheme.primary,
                    focusedContainerColor = MaterialTheme.colorScheme.surface,
                    unfocusedContainerColor = MaterialTheme.colorScheme.surface
                )
            )

            // Action Buttons
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.spacedBy(16.dp, Alignment.CenterHorizontally),
                verticalAlignment = Alignment.CenterVertically
            ) {
                Button(
                    onClick = onCancelClick,
                    shape = RoundedCornerShape(8.dp), // Apply radius
                    colors = ButtonDefaults.buttonColors(
                        containerColor = MaterialTheme.colorScheme.secondary,
                        contentColor = MaterialTheme.colorScheme.onSecondary
                    ),
                    modifier = Modifier.weight(1f)
                ) {
                    Text("Cancel", fontWeight = FontWeight.SemiBold)
                }
                Button(
                    onClick = onSaveClick,
                    shape = RoundedCornerShape(8.dp), // Apply radius
                    colors = ButtonDefaults.buttonColors(
                        containerColor = MaterialTheme.colorScheme.primary,
                        contentColor = MaterialTheme.colorScheme.onPrimary
                    ),
                    modifier = Modifier.weight(1f)
                ) {
                    Text("Save", fontWeight = FontWeight.SemiBold)
                }
            }
        }
    }
}

@Preview(showBackground = true)
@Composable
fun TaskEditorScreenPreview() {
    IOSProductivityTheme { // Wrap with your theme
        TaskEditorScreen(
            taskTitle = "Example Task",
            taskDescription = "This is a sample description for the task editor screen."
        )
    }
}
```
