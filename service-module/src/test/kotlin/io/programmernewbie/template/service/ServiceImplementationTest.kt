package io.programmernewbie.template.service

import kotlinx.coroutines.runBlocking
import org.testng.Assert.assertEquals
import org.testng.Assert.assertTrue
import org.testng.annotations.BeforeMethod
import org.testng.annotations.Test

/**
 * Small unit tests for ExampleService
 *
 * These tests are fast (< 100ms) and test pure business logic without external dependencies.
 * They ensure the service methods work correctly and meet the 85% coverage requirement.
 */
@Test(groups = ["small"])
class ServiceImplementationTest {

  private lateinit var exampleService: ExampleService

  @BeforeMethod
  fun setup() {
    exampleService = ExampleService()
  }

  @Test
  fun `getWelcomeMessage, with custom name, returns personalized message`() {
    // Given
    val name = "Alice"

    // When
    val result = exampleService.getWelcomeMessage(name)

    // Then
    assertEquals(result, "Hello, Alice! This is your Kotlin Multimodule Template.")
  }

  @Test
  fun `getWelcomeMessage, with default name, returns default message`() {
    // When
    val result = exampleService.getWelcomeMessage()

    // Then
    assertEquals(result, "Hello, World! This is your Kotlin Multimodule Template.")
  }

  @Test
  fun `getWelcomeMessage, with empty string, returns message with empty name`() {
    // Given
    val name = ""

    // When
    val result = exampleService.getWelcomeMessage(name)

    // Then
    assertEquals(result, "Hello, ! This is your Kotlin Multimodule Template.")
  }

  @Test
  fun `getWelcomeMessage, with special characters, returns message with special characters`() {
    // Given
    val name = "João & María"

    // When
    val result = exampleService.getWelcomeMessage(name)

    // Then
    assertEquals(result, "Hello, João & María! This is your Kotlin Multimodule Template.")
  }

  @Test
  fun `getWelcomeMessage, with long name, returns message with long name`() {
    // Given
    val name = "VeryLongNameThatShouldStillWorkCorrectly"

    // When
    val result = exampleService.getWelcomeMessage(name)

    // Then
    assertEquals(result, "Hello, VeryLongNameThatShouldStillWorkCorrectly! This is your Kotlin Multimodule Template.")
  }

  @Test
  fun `getAsyncWelcomeMessage, with custom name, returns async personalized message`() {
    // Given
    val name = "Bob"

    // When
    val result = runBlocking { exampleService.getAsyncWelcomeMessage(name) }

    // Then
    assertEquals(result, "Hello async, Bob! This is your Kotlin Multimodule Template.")
  }

  @Test
  fun `getAsyncWelcomeMessage, with default name, returns async default message`() {
    // When
    val result = runBlocking { exampleService.getAsyncWelcomeMessage() }

    // Then
    assertEquals(result, "Hello async, World! This is your Kotlin Multimodule Template.")
  }

  @Test
  fun `getAsyncWelcomeMessage, with empty string, returns async message with empty name`() {
    // Given
    val name = ""

    // When
    val result = runBlocking { exampleService.getAsyncWelcomeMessage(name) }

    // Then
    assertEquals(result, "Hello async, ! This is your Kotlin Multimodule Template.")
  }

  @Test
  fun `getAsyncWelcomeMessage, execution time, completes within reasonable time`() {
    // Given
    val name = "Performance"
    val startTime = System.currentTimeMillis()

    // When
    runBlocking { exampleService.getAsyncWelcomeMessage(name) }
    val endTime = System.currentTimeMillis()

    // Then
    val executionTime = endTime - startTime
    assertTrue(executionTime >= 90, "Async method should simulate delay (>=90ms)")
  }

  @Test
  fun `getAsyncWelcomeMessage, is actually suspending, delay is present`() {
    // Given
    val name = "Async"

    // When & Then - This test verifies the method is actually suspending
    runBlocking {
      val startTime = System.currentTimeMillis()
      val result = exampleService.getAsyncWelcomeMessage(name)
      val endTime = System.currentTimeMillis()

      assertEquals(result, "Hello async, Async! This is your Kotlin Multimodule Template.")
      assertTrue(endTime - startTime >= 100, "Should have simulated async delay")
    }
  }

  @Test
  fun `messageFormat, both methods, have consistent structure`() {
    // Given
    val name = "Consistency"

    // When
    val syncMessage = exampleService.getWelcomeMessage(name)
    val asyncMessage = runBlocking { exampleService.getAsyncWelcomeMessage(name) }

    // Then
    assertTrue(syncMessage.startsWith("Hello, $name!"))
    assertTrue(asyncMessage.startsWith("Hello async, $name!"))
    assertTrue(syncMessage.endsWith("This is your Kotlin Multimodule Template."))
    assertTrue(asyncMessage.endsWith("This is your Kotlin Multimodule Template."))
  }
}
