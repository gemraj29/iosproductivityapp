package com.example.iosproductivitiy.infrastructure.persistence

import com.example.iosproductivitiy.domain.model.Project

interface ProjectRepository {
    suspend fun getProjectById(projectId: String): Project?
    suspend fun getAllProjects(): List<Project>
    suspend fun addProject(project: Project)
    suspend fun updateProject(project: Project)
    suspend fun deleteProject(projectId: String)
}
