package io.programmernewbie.template.controller

import io.programmernewbie.template.service.ExampleService
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController

/**
 * Example REST controller for the template
 *
 * Replace this with your actual REST controllers
 */
@RestController
@RequestMapping("/api/example")
class ExampleController(
  private val exampleService: ExampleService,
) {

  /**
   * Example GET endpoint
   *
   * @param name Optional name parameter
   * @return Welcome message
   */
  @GetMapping("/welcome")
  fun getWelcome(@RequestParam(defaultValue = "World") name: String): Map<String, String> {
    return mapOf(
      "message" to exampleService.getWelcomeMessage(name),
      "timestamp" to java.time.Instant.now().toString(),
    )
  }

  /**
   * Example async GET endpoint
   *
   * @param name Optional name parameter
   * @return Welcome message from async service
   */
  @GetMapping("/welcome-async")
  suspend fun getWelcomeAsync(@RequestParam(defaultValue = "World") name: String): Map<String, String> {
    return mapOf(
      "message" to exampleService.getAsyncWelcomeMessage(name),
      "timestamp" to java.time.Instant.now().toString(),
      "type" to "async",
    )
  }

  /**
   * Health check endpoint
   */
  @GetMapping("/health")
  fun health(): Map<String, String> {
    return mapOf(
      "status" to "UP",
      "service" to "kotlin-multimodule-template",
    )
  }
}
