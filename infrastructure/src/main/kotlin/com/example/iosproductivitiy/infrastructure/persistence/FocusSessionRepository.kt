package com.example.iosproductivitiy.infrastructure.persistence

import com.example.iosproductivitiy.domain.model.FocusSession

interface FocusSessionRepository {
    suspend fun getFocusSessionById(sessionId: String): FocusSession?
    suspend fun getAllFocusSessions(): List<FocusSession>
    suspend fun addFocusSession(session: FocusSession)
    suspend fun updateFocusSession(session: FocusSession)
    suspend fun deleteFocusSession(sessionId: String)
}
