import XCTest
import STB

final class STBTests: XCTestCase {

    func testImageLoading() throws {

        let url = try Resource.load(.colorMap_png)

        var x: Int32 = -1
        var y: Int32 = -1
        var channels: Int32 = -1

        let image = stbi_load(url.path,
                              &x,
                              &y,
                              &channels,
                              Int32(STBI_rgb_alpha))

        XCTAssertNotNil(image)
        XCTAssertEqual(x, 1024)
        XCTAssertEqual(y, 1024)
        XCTAssertEqual(channels, 4)
    }
}
