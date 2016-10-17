import UIKit
import XCTest
import MusicMojoLyrica


class testLyrics: LyricsSearchManagerProtocol {
    var lyric:String!
    var err:Error!
     var asyncExpectation: XCTestExpectation?
    func test()
    {
        let lyricManager = LyricsSearchManager()
        lyricManager.delegate = self
        let _ = lyricManager.fetchLyricsForTrack(artist: "K. J. Yesudas", song: "Gori Tera Gaon Bada Pyara")
    }
    func lyricsFound(lyrics:String)
    {
        lyric = lyrics
        guard let expectation = asyncExpectation else {
            XCTFail("failed")
            return
        }
        expectation.fulfill()

    }
    func lyricsError(error:Error)
    {
        err = error
        guard let expectation = asyncExpectation else {
            XCTFail("failed")
            return
        }
        expectation.fulfill()
    }

}

class Tests: XCTestCase {
    var x :XCTestExpectation!
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        let expectation1 = expectation(description: "delegate called")
        
        let delegate = testLyrics()
        delegate.asyncExpectation = expectation1
        let manager = LyricsSearchManager()
        manager.delegate = delegate
        let _ = manager.fetchLyricsForTrack(artist: "Kesha", song: "Tik Tok")
        //let _ = manager.fetchLyricsForTrack(artist: "Kesha", song: "Tik Tok")
        self.waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            
            guard let result = delegate.lyric else {
                XCTFail("Expected delegate to be called")
                return
            }
            if let _ = delegate.err
            {
                XCTFail("Error Delegate called")
                
            }else {
                XCTAssert(true)
                
            }
            
            
            XCTAssertNotNil(result)
            print(result)
        }
            }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure() {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    
    
    
}
