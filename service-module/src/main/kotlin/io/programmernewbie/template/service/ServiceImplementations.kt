package io.programmernewbie.template.service

import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

/**
 * Example service implementation for the template
 *
 * Replace this with your actual business logic services
 */
@Service
@Transactional
class ExampleService {

  /**
   * Example method - replace with your actual business logic
   */
  fun getWelcomeMessage(name: String = "World"): String {
    return "Hello, $name! This is your Kotlin Multimodule Template."
  }

  /**
   * Example async method - replace with your actual business logic
   */
  suspend fun getAsyncWelcomeMessage(name: String = "World"): String {
    // Simulate some async work
    kotlinx.coroutines.delay(100)
    return "Hello async, $name! This is your Kotlin Multimodule Template."
  }
}
