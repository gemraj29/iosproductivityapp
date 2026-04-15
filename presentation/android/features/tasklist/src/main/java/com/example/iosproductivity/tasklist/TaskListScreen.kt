package com.example.iosproductivity.tasklist

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.example.iosproductivity.ui.theme.* // Assuming your theme is defined here

data class Task(val id: Int, val title: String, val isCompleted: Boolean)

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun TaskListScreen(tasks: List<Task> = sampleTasks) {
    Scaffold(
        floatingActionButton = {
            FloatingActionButton(
                onClick = { /* TODO: Handle add task */ },
                containerColor = MaterialTheme.colorScheme.primary,
                contentColor = MaterialTheme.colorScheme.onPrimary
            ) {
                Icon(Icons.Filled.Add, contentDescription = "Add Task")
            }
        },
        topBar = {
            TopAppBar(
                title = { Text("Tasks") },
                colors = TopAppBarDefaults.topAppBarColors(
                    containerColor = MaterialTheme.colorScheme.surface,
                    titleContentColor = MaterialTheme.colorScheme.onSurface
                )
            )
        },
        containerColor = MaterialTheme.colorScheme.background
    ) { paddingValues ->
        LazyColumn(
            modifier = Modifier
                .fillMaxSize()
                .padding(paddingValues)
                .padding(horizontal = 16.dp, vertical = 8.dp),
            verticalArrangement = Arrangement.spacedBy(8.dp)
        ) {
            items(tasks, key = { it.id }) { task ->
                TaskItem(task = task)
            }
        }
    }
}

@Composable
fun TaskItem(task: Task) {
    Card(
        modifier = Modifier.fillMaxWidth(),
        colors = CardDefaults.cardColors(
            containerColor = MaterialTheme.colorScheme.surface,
            contentColor = MaterialTheme.colorScheme.onSurface
        ),
        elevation = CardDefaults.elevatedCardElevation(defaultElevation = 2.dp)
    ) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(16.dp),
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            Column(modifier = Modifier.weight(1f)) {
                Text(
                    text = task.title,
                    style = MaterialTheme.typography.bodyLarge,
                    color = if (task.isCompleted) MaterialTheme.colorScheme.onSurfaceVariant else MaterialTheme.colorScheme.onSurface
                )
                if (task.isCompleted) {
                    Divider(
                        color = MaterialTheme.colorScheme.onSurfaceVariant,
                        thickness = 1.dp,
                        modifier = Modifier.padding(vertical = 2.dp)
                    )
                }
            }
            Checkbox(
                checked = task.isCompleted,
                onCheckedChange = { /* TODO: Handle task completion toggle */ },
                colors = CheckboxDefaults.colors(
                    checkedColor = MaterialTheme.colorScheme.primary,
                    uncheckedColor = MaterialTheme.colorScheme.outline
                )
            )
        }
    }
}

val sampleTasks = listOf(
    Task(1, "Buy groceries", false),
    Task(2, "Schedule dentist appointment", false),
    Task(3, "Finish project report", true),
    Task(4, "Call mom", false),
    Task(5, "Plan weekend trip", false),
    Task(6, "Read chapter 5", true)
)

@Preview(showBackground = true)
@Composable
fun TaskListScreenPreview() {
    IOSProductivityTheme { // Apply your app's theme
        TaskListScreen()
    }
}

@Preview(showBackground = true)
@Composable
fun TaskItemPreview() {
    IOSProductivityTheme { // Apply your app's theme
        TaskItem(task = Task(1, "Sample Task", false))
    }
}

@Preview(showBackground = true)
@Composable
fun TaskItemCompletedPreview() {
    IOSProductivityTheme { // Apply your app's theme
        TaskItem(task = Task(2, "Completed Task", true))
    }
}
