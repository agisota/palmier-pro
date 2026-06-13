import Foundation
import Testing
@testable import PalmierPro

@Suite("KeywordSearch")
struct KeywordSearchTests {
    @Test func parsesTermsStrippingEdgePunctuation() {
        #expect(KeywordSearch.terms(in: "  budget, meeting!  ") == ["budget", "meeting"])
        #expect(KeywordSearch.terms(in: "don't stop") == ["don't", "stop"])
        #expect(KeywordSearch.terms(in: "...") == [])
        #expect(KeywordSearch.terms(in: "") == [])
    }

    @Test func matchesAllTermsAnyOrder() {
        let text = "We reviewed the Q3 budget at the morning meeting."
        #expect(KeywordSearch.matches(text, terms: ["budget", "meeting"]))
        #expect(KeywordSearch.matches(text, terms: ["meeting", "budget"]))
        #expect(!KeywordSearch.matches(text, terms: ["budget", "harbor"]))
    }

    @Test func caseAndDiacriticInsensitiveAndPartialWord() {
        #expect(KeywordSearch.matches("Visit the CAFÉ downtown", terms: ["cafe"]))
        #expect(KeywordSearch.matches("she was running fast", terms: ["run"]))
    }
}
