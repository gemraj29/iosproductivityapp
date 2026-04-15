package io.iosproductivty.application.usecases

/**
 * A specialized [UseCase] for operations that do not produce any output.
 *
 * This interface is useful for use cases that perform an action, such as saving data,
 * deleting an item, or triggering a side effect, where the success or failure is
 * indicated by the absence of an exception.
 *
 * @param I The type of the input parameter for the use case. Use [Unit] if no input is required.
 */
interface NoOutputUseCase<in I> : UseCase<I, Unit>
