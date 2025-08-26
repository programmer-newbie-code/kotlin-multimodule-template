package io.programmernewbie.template.controller

import io.mockk.coEvery
import io.mockk.coVerify
import io.mockk.every
import io.mockk.mockk
import io.mockk.verify
import io.programmernewbie.template.service.ExampleService
import kotlinx.coroutines.runBlocking
import org.testng.Assert.assertEquals
import org.testng.Assert.assertNotNull
import org.testng.Assert.assertTrue
import org.testng.Assert.fail
import org.testng.annotations.BeforeMethod
import org.testng.annotations.Test
import java.time.Instant

/**
 * Small unit tests for ExampleController
 *
 * These tests are fast (< 100ms) and use mocks to isolate the controller logic.
 * They focus on testing the controller's behavior without Spring context.
 */
@Test(groups = ["small"])
class ExampleControllerTest {

  private lateinit var mockExampleService: ExampleService
  private lateinit var controller: ExampleController

  @BeforeMethod
  fun setup() {
    mockExampleService = mockk()
    controller = ExampleController(mockExampleService)
  }

  @Test
  fun `getWelcome, with custom name, returns response with message and timestamp`() {
    // Given
    val name = "Alice"
    val expectedMessage = "Hello, Alice! This is your Kotlin Multimodule Template."
    every { mockExampleService.getWelcomeMessage(name) } returns expectedMessage

    // When
    val response = controller.getWelcome(name)

    // Then
    assertEquals(response["message"], expectedMessage)
    assertTrue(response.containsKey("timestamp"))
    assertNotNull(response["timestamp"])
    verify { mockExampleService.getWelcomeMessage(name) }
  }

  @Test
  fun `getWelcome, with default name, returns response with default message`() {
    // Given
    val expectedMessage = "Hello, World! This is your Kotlin Multimodule Template."
    every { mockExampleService.getWelcomeMessage("World") } returns expectedMessage

    // When
    val response = controller.getWelcome("World")

    // Then
    assertEquals(response["message"], expectedMessage)
    assertTrue(response.containsKey("timestamp"))
    verify { mockExampleService.getWelcomeMessage("World") }
  }

  @Test
  fun `getWelcome, response contains timestamp, timestamp is valid instant`() {
    // Given
    val name = "Test"
    val expectedMessage = "Hello, Test! This is your Kotlin Multimodule Template."
    every { mockExampleService.getWelcomeMessage(name) } returns expectedMessage

    // When
    val response = controller.getWelcome(name)

    // Then
    val timestamp = response["timestamp"]
    assertNotNull(timestamp)
    // Verify timestamp is a valid ISO instant format
    assertDoesNotThrow {
      Instant.parse(timestamp as String)
    }
  }

  @Test
  fun `getWelcomeAsync, with custom name, returns async response with correct type`() {
    // Given
    val name = "Bob"
    val expectedMessage = "Hello async, Bob! This is your Kotlin Multimodule Template."
    coEvery { mockExampleService.getAsyncWelcomeMessage(name) } returns expectedMessage

    // When
    val response = runBlocking { controller.getWelcomeAsync(name) }

    // Then
    assertEquals(response["message"], expectedMessage)
    assertEquals(response["type"], "async")
    assertTrue(response.containsKey("timestamp"))
    coVerify { mockExampleService.getAsyncWelcomeMessage(name) }
  }

  @Test
  fun `getWelcomeAsync, with default name, returns async response with default message`() {
    // Given
    val expectedMessage = "Hello async, World! This is your Kotlin Multimodule Template."
    coEvery { mockExampleService.getAsyncWelcomeMessage("World") } returns expectedMessage

    // When
    val response = runBlocking { controller.getWelcomeAsync("World") }

    // Then
    assertEquals(response["message"], expectedMessage)
    assertEquals(response["type"], "async")
    assertTrue(response.containsKey("timestamp"))
    coVerify { mockExampleService.getAsyncWelcomeMessage("World") }
  }

  @Test
  fun `getWelcomeAsync, response structure, contains all required fields`() {
    // Given
    val name = "Structure"
    val expectedMessage = "Hello async, Structure! This is your Kotlin Multimodule Template."
    coEvery { mockExampleService.getAsyncWelcomeMessage(name) } returns expectedMessage

    // When
    val response = runBlocking { controller.getWelcomeAsync(name) }

    // Then
    assertEquals(3, response.size) // Should have exactly 3 fields
    assertTrue(response.containsKey("message"))
    assertTrue(response.containsKey("timestamp"))
    assertTrue(response.containsKey("type"))
  }

  @Test
  fun `health, returns correct status, status is UP with service name`() {
    // When
    val response = controller.health()

    // Then
    assertEquals(response["status"], "UP")
    assertEquals(response["service"], "kotlin-multimodule-template")
    assertEquals(2, response.size) // Should have exactly 2 fields
  }

  @Test
  fun `health, does not depend on external services, no service interactions`() {
    // When
    val response = controller.health()

    // Then
    assertEquals(response["status"], "UP")
    // Verify no interactions with mock service (health should be independent)
    verify(exactly = 0) { mockExampleService.getWelcomeMessage(any()) }
    coVerify(exactly = 0) { mockExampleService.getAsyncWelcomeMessage(any()) }
  }

  private fun assertDoesNotThrow(block: () -> Unit) {
    try {
      block()
    } catch (e: Exception) {
      fail("Expected no exception but got: ${e.message}")
    }
  }
}
