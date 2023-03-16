# Imjection

Simple dependency injection framework

## How to integrate

### CocoaPods

```
pod 'Imjection', :git => 'https://github.com/monsoir/Imjection.git', :tag => 'v1.0.0'
```

## How to use

```swift
// Injecting class
final
class Foo {

    let id: String

    init(id: String) {
        self.id = id
    }
}

// Injecting object
let theGlobalFoo = Foo(id: "global")
```

```swift
// Define providers
struct GlobalFooProvider: Provider {
    var value: Foo { theGlobalFoo }
}
```

```swift
// Right after app starts
DependencyResolver.initialize(
    environment: .test,
    createDependencies: { _ in
        [
            GlobalFooProvider(),
        ]
    }
)
```

```swift
// Somewhere the injecting used

class Bar {

    @DependencyInject(providerType: GlobalFooProvider.self)
    private var globalFoo: Foo
    
    func aFunction() {
        print("\(global.id)")
    }
}
```

