//
//  KeywordsService.swift
//  QuizChallengeTests
//
//  Created by m.dos.santos.junior on 29/08/19.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import QuizChallenge

class KeywordsServiceSpecs: QuickSpec {
    
    override func spec() {
        var sut: KeywordsServiceImpl!
        var apiClientMock: APIClientMock<Keywords>!
        describe("KeywordsServiceSpecs") {
            
            beforeEach {
                apiClientMock = APIClientMock()
                sut = KeywordsServiceImpl(apiClient: apiClientMock)
            }
            
            context("When keywords is called") {
                beforeEach {
                    sut.keywords(completion: { (result) in })
                }
                
                it("Should call request from apiClient") {
                    expect(apiClientMock.isRequestCalled).to(beTrue())
                    expect(apiClientMock.endpointPassed!).to(beAKindOf(KeywordsEndpoint.self))
                }
            }
        }
    }
}
