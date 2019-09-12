//
//  KeywordsEndpointSpec.swift
//  QuizChallengeTests
//
//  Created by m.dos.santos.junior on 29/08/19.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import QuizChallenge

class KeywordsEndpointSpecs: QuickSpec {
    
    override func spec() {
        var sut: KeywordsEndpoint!
        describe("KeywordsEndpointSpecs") {
            
            beforeEach {
                
                sut = KeywordsEndpoint()
            }
            
            context("when instantiated") {
                it("should return right values") {
                    expect(sut.method == MethodHTTP.get).to(beTrue())
                    expect(sut.path == Constants.api.keywordsPath).to(beTrue())
                    expect(sut.parameters == nil).to(beTrue())
                    expect(sut.headers == nil).to(beTrue())
                }
            }            
            
            context("When errorMessage is called") {
                it("Should return generic message") {
                    expect(sut.errorMessage(with: 404) == Constants.api.genericError).to(beTrue())
                }
            }
        }
    }
}

