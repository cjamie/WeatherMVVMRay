/// Copyright (c) 2019 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

@testable import Grados
import XCTest

class WeatherbitDataTests: XCTestCase {
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        return formatter
    }()

    var exampleJSONData: Data!
    var weather: WeatherbitData!

    override func setUp() {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: "WeatherbitExample", withExtension: "json")!
        exampleJSONData = try! Data(contentsOf: url)

        let decoder = JSONDecoder()
        weather = try! decoder.decode(WeatherbitData.self, from: exampleJSONData)
    }

    func testDecodeTemp() throws {
        XCTAssertEqual(weather.currentTemp, 24.19)
    }

    func testDecodeIcon() throws {
        XCTAssertEqual(weather.iconName, "c03d")
    }

    func testDecodeDescription() throws {
        XCTAssertEqual(weather.description, "Broken clouds")
    }

    func testDecodeDate() throws {
        XCTAssertEqual(Self.dateFormatter.string(from: weather.date), "08-28-2017")
    }
}