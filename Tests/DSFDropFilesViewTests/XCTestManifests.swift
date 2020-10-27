import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(DSFDropFilesViewTests.allTests),
    ]
}
#endif
