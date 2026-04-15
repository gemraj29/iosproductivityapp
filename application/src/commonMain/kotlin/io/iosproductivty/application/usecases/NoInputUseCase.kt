package io.iosproductivty.application.usecases

/**
 * A specialized [UseCase] for operations that do not require any input parameters.
 *
 * This interface simplifies the definition of use cases that only need to perform an action
 * or retrieve data without needing external data to start.
 *
 * @param O The type of the output (result) of the use case. Use [Unit] if no output is produced.
 */
interface NoInputUseCase<out O> : UseCase<Unit, O> {
    /**
     * Executes the use case.
     *
     * @return The result of the use case execution.
     * @throws Exception if any error occurs during execution.
     */
    @Throws(Exception::class)
    suspend fun execute(): O = execute(Unit)
}
