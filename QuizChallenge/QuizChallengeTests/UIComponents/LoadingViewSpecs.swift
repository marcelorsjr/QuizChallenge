import Foundation
import Quick
import Nimble
import Nimble_Snapshots
@testable import QuizChallenge

class LoadingViewSpec: QuickSpec {
    
    override func spec() {
        
        describe("LoadingView") {
            
            var sut: LoadingView!
            
            beforeEach {
                sut = LoadingView(frame: CGRect(x: 0, y: 0, width: 320, height: 568))
            }
            
            context("When show is called with no title") {
                beforeEach {
                    sut.startLoading()
                }
                it("should show loading view with default title") {
                    expect(sut) == snapshot()
                }
            }
            
            context("When show is called with custom title") {
                beforeEach {
                    sut.startLoading(with: "Wait...")
                }
                it("should show loading view with desired title") {
                    expect(sut) == snapshot()
                }
            }
        }
    }
}
