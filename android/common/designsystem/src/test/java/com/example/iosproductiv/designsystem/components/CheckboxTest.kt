package com.example.iosproductiv.designsystem.components

import androidx.compose.ui.test.junit4.createComposeRule
import androidx.compose.ui.test.onNodeWithContentDescription
import androidx.compose.ui.test.performClick
import com.example.iosproductiv.designsystem.theme.IosProductivTheme
import org.junit.Rule
import org.junit.Test

class CheckboxTest {

    @get:Rule
    val composeTestRule = createComposeRule()

    @Test
    fun checkbox_displaysCorrectlyAndHandlesClick() {
        var checkedState = false
        composeTestRule.setContent {
            IosProductivTheme {
                Checkbox(
                    checked = checkedState,
                    onCheckedChange = { newState -> checkedState = newState },
                    label = "Test Checkbox"
                )
            }
        }

        // Check initial state
        composeTestRule.onNodeWithContentDescription("Test Checkbox").assertExists()
        composeTestRule.onNodeWithContentDescription("Test Checkbox").assertIsOff()

        // Click to check
        composeTestRule.onNodeWithContentDescription("Test Checkbox").performClick()
        assert(checkedState) { "Checkbox did not become checked." }
        composeTestRule.onNodeWithContentDescription("Test Checkbox").assertIsOn()

        // Click to uncheck
        composeTestRule.onNodeWithContentDescription("Test Checkbox").performClick()
        assert(!checkedState) { "Checkbox did not become unchecked." }
        composeTestRule.onNodeWithContentDescription("Test Checkbox").assertIsOff()
    }

    @Test
    fun checkbox_isDisabledWhenSpecified() {
        composeTestRule.setContent {
            IosProductivTheme {
                Checkbox(
                    checked = false,
                    onCheckedChange = {},
                    label = "Disabled Checkbox",
                    enabled = false
                )
            }
        }

        composeTestRule.onNodeWithContentDescription("Disabled Checkbox").assertExists()
        // Checkbox is disabled, so it should not be clickable
        composeTestRule.onNodeWithContentDescription("Disabled Checkbox").assertIsNotEnabled()
    }
}
