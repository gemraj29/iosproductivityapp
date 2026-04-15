package com.example.iosproductiv.designsystem.components

import androidx.compose.foundation.layout.Column
import androidx.compose.material3.Text
import androidx.compose.ui.test.junit4.createComposeRule
import androidx.compose.ui.test.onNodeWithText
import com.example.iosproductiv.designsystem.theme.IosProductivTheme
import org.junit.Rule
import org.junit.Test

class CardTest {

    @get:Rule
    val composeTestRule = createComposeRule()

    @Test
    fun card_displaysContentCorrectly() {
        val cardTitle = "Card Title"
        val cardText = "This is the content of the card."

        composeTestRule.setContent {
            IosProductivTheme {
                Card(title = cardTitle) {
                    Text(text = cardText)
                }
            }
        }

        composeTestRule.onNodeWithText(cardTitle).assertExists()
        composeTestRule.onNodeWithText(cardText).assertExists()
    }

    @Test
    fun card_withNoTitleDisplaysContent() {
        val cardText = "Content without a title."

        composeTestRule.setContent {
            IosProductivTheme {
                Card(title = null) {
                    Text(text = cardText)
                }
            }
        }

        composeTestRule.onNodeWithText(cardText).assertExists()
        // Ensure title is not present
        composeTestRule.onNodeWithText("").assertDoesNotExist() // Assuming no default title
    }

    @Test
    fun card_withCustomContent() {
        composeTestRule.setContent {
            IosProductivTheme {
                Card(title = "Custom Card") {
                    Column {
                        Text("Line 1")
                        Text("Line 2")
                    }
                }
            }
        }

        composeTestRule.onNodeWithText("Custom Card").assertExists()
        composeTestRule.onNodeWithText("Line 1").assertExists()
        composeTestRule.onNodeWithText("Line 2").assertExists()
    }
}
