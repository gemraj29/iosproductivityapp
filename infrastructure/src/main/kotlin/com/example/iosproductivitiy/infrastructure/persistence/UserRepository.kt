package com.example.iosproductivitiy.infrastructure.persistence

import com.example.iosproductivitiy.domain.model.User

interface UserRepository {
    suspend fun getUserById(userId: String): User?
    suspend fun getUserByEmail(email: String): User?
    suspend fun addUser(user: User)
    suspend fun updateUser(user: User)
}
