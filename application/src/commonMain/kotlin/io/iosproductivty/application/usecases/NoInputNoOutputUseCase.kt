package io.iosproductivty.application.usecases

/**
 * A specialized [UseCase] for operations that require no input and produce no output.
 *
 * This is the simplest form of a use case, typically used for actions that are self-contained
 * and don't need external data or don't return specific results beyond success/failure.
 */
interface NoInputNoOutputUseCase : NoInputUseCase<Unit>, NoOutputUseCase<Unit> {
    /**
     * Executes the use case.
     *
     * @throws Exception if any error occurs during execution.
     */
    @Throws(Exception::class)
    suspend fun execute()
}
