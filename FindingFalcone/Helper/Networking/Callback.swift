//
//  Callback.swift
//  FindingFalcone
//
//  Created by Sparsh Singh on 06/09/23.
//

import Foundation

public class Callback<T, V> {
    private let successBlock: (T) -> Void
    private let failureBlock: (V) -> Void

    public init(onSuccess: @escaping (T) -> Void, onFailure: @escaping (V) -> Void) {
        successBlock = onSuccess
        failureBlock = onFailure
    }

    public func onSuccess(_ successResponse: T) {
        successBlock(successResponse)
    }

    public func onFailure(_ failureResponse: V) {
        failureBlock(failureResponse)
    }
}
