package com.example.iosproductivitiy.infrastructure.persistence

import com.example.iosproductivitiy.domain.model.Task

interface TaskRepository {
    suspend fun getTaskById(taskId: String): Task?
    suspend fun getAllTasks(): List<Task>
    suspend fun addTask(task: Task)
    suspend fun updateTask(task: Task)
    suspend fun deleteTask(taskId: String)
}
