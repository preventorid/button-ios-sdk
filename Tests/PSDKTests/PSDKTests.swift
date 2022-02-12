import XCTest
@testable import PSDK

final class PSDKTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(PSDK().text, "Hello, World!")
    }
}
