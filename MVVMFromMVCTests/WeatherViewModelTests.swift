////

@testable import Grados
import XCTest

final class WeatherViewModelTests: XCTestCase {

    func test_newLocationValue_updatesLocationName() {
        
        let myExp = expectation(description: "find location using geocoder")
        
        let sut = makeSUT()
        let expectednewLocation = "Richmond, VA"
        
        sut.locationName.bind { newLocation in
            if newLocation == "Richmond, VA" {
                myExp.fulfill()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            sut.changeLocation(expectednewLocation)
        }
        
        
        waitForExpectations(timeout: 1)
    }
    
    
    // MARK: - Helper methods
    
    private func makeSUT() -> WeatherViewModel{
        return WeatherViewModel()
    }

}
