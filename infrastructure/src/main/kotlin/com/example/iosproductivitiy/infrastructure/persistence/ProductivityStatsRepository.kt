package com.example.iosproductivitiy.infrastructure.persistence

import com.example.iosproductivitiy.domain.model.ProductivityStats

interface ProductivityStatsRepository {
    suspend fun getStatsByUserId(userId: String): ProductivityStats?
    suspend fun addStats(stats: ProductivityStats)
    suspend fun updateStats(stats: ProductivityStats)
}
