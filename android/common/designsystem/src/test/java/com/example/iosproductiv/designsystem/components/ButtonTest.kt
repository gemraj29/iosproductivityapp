package com.example.iosproductiv.designsystem.components

import androidx.compose.ui.test.junit4.createComposeRule
import androidx.compose.ui.test.onNodeWithText
import androidx.compose.ui.test.performClick
import com.example.iosproductiv.designsystem.theme.IosProductivTheme
import org.junit.Rule
import org.junit.Test

class ButtonTest {

    @get:Rule
    val composeTestRule = createComposeRule()

    @Test
    fun button_displaysCorrectLabelAndHandlesClick() {
        var clicked = false
        composeTestRule.setContent {
            IosProductivTheme {
                Button(
                    text = "Test Button",
                    onClick = { clicked = true }
                )
            }
        }

        composeTestRule.onNodeWithText("Test Button").assertExists()
        composeTestRule.onNodeWithText("Test Button").performClick()
        assert(clicked) { "Button click was not registered." }
    }

    @Test
    fun button_isDisabledWhenSpecified() {
        composeTestRule.setContent {
            IosProductivTheme {
                Button(
                    text = "Disabled Button",
                    onClick = {},
                    enabled = false
                )
            }
        }

        composeTestRule.onNodeWithText("Disabled Button").assertExists()
        // Note: Jetpack Compose doesn't have a direct 'isDisabled' assertion.
        // We infer it by checking if it's clickable. If it's not clickable, it's disabled.
        composeTestRule.onNodeWithText("Disabled Button").assertIsNotEnabled()
    }
}
