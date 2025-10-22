//
//  AppContext.swift
//  CineNow
//
//  Created by Mickael Belhassen on 22/10/2025.
//

import ComposableArchitecture
import Foundation

enum AppContext {
    case live
    case test
    case preview

    static var current: AppContext {
        return if isRunningTests {
            .test
        } else if isRunningPreviews {
            .preview
        } else {
            .live
        }
    }

    private static var isRunningTests: Bool {
        NSClassFromString("XCTestCase") != nil || ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil || CommandLine.arguments.contains("--test")
    }

    private static var isRunningPreviews: Bool {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}

// MARK: - Store initialization with context

extension Store {
    
    static func withContext<R: Reducer>(context: AppContext = AppContext.current, initialState: R.State, reducer: @escaping () -> R) -> Store<R.State, R.Action> {
        switch context {
            case .live:
                Store<R.State, R.Action>(initialState: initialState) {
                    reducer()
                }
            case .test:
                withDependencies {
                    $0.context = .test
                } operation: {
                    Store<R.State, R.Action>(initialState: initialState) {
                        reducer()
                    }
                }
            case .preview:
                withDependencies {
                    $0.context = .preview
                } operation: {
                    Store<R.State, R.Action>(initialState: initialState) {
                        reducer()
                    }
                }
        }
    }
    
}
