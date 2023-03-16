//
//  DependencyInjection.swift
//  Imjection
//
//  Created by monsoir on 3/16/23.
//

import Foundation

public typealias ProviderIdentifier = String

public protocol Provider {

    associatedtype ValueType

    var identifier: ProviderIdentifier { get }
    var value: Self.ValueType { get }
}

extension Provider {
    var identifier: String { String(describing: type(of: self)) }
}

final
public class DependencyResolver {

    public let environment: Environment

    public private(set) static var shared: DependencyResolver!

    public static func initialize(
        environment: Environment,
        createDependencies: (Environment) -> [any Provider]
    ) {
        shared = DependencyResolver(environment: environment, createDependencies: createDependencies)
    }

    private let pool: [ProviderIdentifier: AutoClosure]

    private init(environment: Environment, createDependencies: (Environment) -> [any Provider]) {
        self.environment = environment
        let dependencies = createDependencies(environment)
        pool = dependencies.reduce(into: [:], { partialResult, provider in
            partialResult[provider.identifier] = { provider.value }
        })
    }

    fileprivate func retrieveValue(at index: ProviderIdentifier) -> AutoClosure {
        return pool[index]!
    }
}

extension DependencyResolver {
    public enum Environment {
        case development
        case production
        case test
    }

    fileprivate typealias AutoClosure = () -> Any
}

@propertyWrapper
public struct DependencyInject<T> {

    private let identifier: ProviderIdentifier

    private var resolver: DependencyResolver { DependencyResolver.shared }

    public var wrappedValue: T {
        get { resolver.retrieveValue(at: identifier)() as! T }
    }

    public init(identifier: ProviderIdentifier) {
        self.identifier = identifier
    }

    public init<P: Provider>(providerType: P.Type) where P.ValueType == T {
        self.identifier = String(describing: P.self)
    }
}
