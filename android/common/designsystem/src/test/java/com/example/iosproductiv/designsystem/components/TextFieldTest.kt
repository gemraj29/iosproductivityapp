package com.example.iosproductiv.designsystem.components

import androidx.compose.ui.test.junit4.createComposeRule
import androidx.compose.ui.test.onNodeWithText
import androidx.compose.ui.test.performTextInput
import com.example.iosproductiv.designsystem.theme.IosProductivTheme
import org.junit.Rule
import org.junit.Test

class TextFieldTest {

    @get:Rule
    val composeTestRule = createComposeRule()

    @Test
    fun textField_displaysCorrectlyAndHandlesInput() {
        val placeholderText = "Enter text here"
        var textValue = ""

        composeTestRule.setContent {
            IosProductivTheme {
                TextField(
                    value = textValue,
                    onValueChange = { newValue -> textValue = newValue },
                    placeholder = placeholderText
                )
            }
        }

        // Check placeholder
        composeTestRule.onNodeWithText(placeholderText).assertExists()

        // Input text
        val inputText = "Hello Compose"
        composeTestRule.onNodeWithText(placeholderText).performTextInput(inputText)

        // Verify text is updated
        composeTestRule.onNodeWithText(inputText).assertExists()
        assert(textValue == inputText) { "TextField value was not updated correctly." }
    }

    @Test
    fun textField_displaysInitialValue() {
        val initialText = "Initial Value"
        composeTestRule.setContent {
            IosProductivTheme {
                TextField(
                    value = initialText,
                    onValueChange = {},
                    placeholder = "Enter text"
                )
            }
        }

        composeTestRule.onNodeWithText(initialText).assertExists()
    }

    @Test
    fun textField_isDisabledWhenSpecified() {
        composeTestRule.setContent {
            IosProductivTheme {
                TextField(
                    value = "Disabled Text",
                    onValueChange = {},
                    placeholder = "Cannot type here",
                    enabled = false
                )
            }
        }

        composeTestRule.onNodeWithText("Disabled Text").assertExists()
        // TextField is disabled, so it should not be clickable/editable
        composeTestRule.onNodeWithText("Disabled Text").assertIsNotEnabled()
    }
}
