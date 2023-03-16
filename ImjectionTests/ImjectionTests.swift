//
//  ImjectionTests.swift
//  ImjectionTests
//
//  Created by monsoir on 3/16/23.
//

import XCTest
@testable import Imjection

final class ImjectionTests: XCTestCase {

    @DependencyInject(providerType: GlobalFooProvider.self)
    private var globalFoo: Foo

    @DependencyInject(identifier: "custom")
    private var customFoo: Foo

    override class func setUp() {
        DependencyResolver.initialize(
            environment: .test,
            createDependencies: { _ in
                [
                    GlobalFooProvider(),
                    CustomIdentifierFooProvider(),
                ]
            }
        )
    }

    func testInjectedObject() {
        XCTAssert(globalFoo.id == theGlobalFoo.id)
        XCTAssert(customFoo.id == theCustomIDFoo.id)
    }
}

final
class Foo {

    let id: String

    init(id: String) {
        self.id = id
    }
}

let theGlobalFoo = Foo(id: "global")
let theCustomIDFoo = Foo(id: "123")

struct GlobalFooProvider: Provider {
    var value: Foo { theGlobalFoo }
}

struct CustomIdentifierFooProvider: Provider {
    var identifier: ProviderIdentifier { "custom" }
    var value: Foo { theCustomIDFoo }
}
