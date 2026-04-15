package io.iosproductivty.application.usecases

/**
 * Base interface for all use cases in the application layer.
 *
 * Use cases represent specific business operations that can be performed by the application.
 * They encapsulate the logic for interacting with the domain layer and potentially the data layer
 * to achieve a particular goal.
 *
 * @param I The type of the input parameter for the use case. Use [Unit] if no input is required.
 * @param O The type of the output (result) of the use case. Use [Unit] if no output is produced.
 */
interface UseCase<in I, out O> {
    /**
     * Executes the use case with the given input.
     *
     * @param input The input parameter for the use case.
     * @return The result of the use case execution.
     * @throws Exception if any error occurs during execution.
     */
    @Throws(Exception::class)
    suspend fun execute(input: I): O
}
