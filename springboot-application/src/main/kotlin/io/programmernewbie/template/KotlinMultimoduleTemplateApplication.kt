package io.programmernewbie.template

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.data.jpa.repository.config.EnableJpaAuditing
import org.springframework.transaction.annotation.EnableTransactionManagement

/**
 * Main Spring Boot application class for Kotlin Multimodule Template
 *
 * This application demonstrates a minimal multimodule Kotlin architecture with:
 * - Service layer with business logic
 * - Spring Boot application layer with REST controllers
 *
 * To customize this template for your project:
 * 1. Change the package name from io.programmernewbie.template to your desired package
 * 2. Update the scanBasePackages to match your package structure
 * 3. Add your business logic in the service-module
 * 4. Add your REST controllers in this module
 */
@SpringBootApplication(
  scanBasePackages = [
    "io.programmernewbie.template.service",
    "io.programmernewbie.template",
  ],
)
@EnableJpaAuditing
@EnableTransactionManagement
class KotlinMultimoduleTemplateApplication

fun main(args: Array<String>) {
  runApplication<KotlinMultimoduleTemplateApplication>(*args)
}
