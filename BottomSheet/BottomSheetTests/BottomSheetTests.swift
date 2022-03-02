//
//  BottomSheetTests.swift
//  BottomSheetTests
//
//  Created by Volodymyr Seredovych on 01.03.2022.
//
@testable import BottomSheet
import XCTest

class BottomSheetTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}

final class TestingPresentationTransition: NSObject, BottomSheetPresentationController {
  var presentationFrame: CGRect?
  var presentationView: UIView?
  func defaultModalPresentationStyle() -> UIModalPresentationStyle {
    return .custom
  }
  func presentationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController?) -> UIPresentationController? {
    let presentationController =
      BottomSheetPresentationController(presentedViewController: presented, presenting: presenting)
    presentationController.presentationFrame = presentationFrame
    presentationController.presentationView = presentationView
    return presentationController
  }
  func start(with context: TransitionContext) {
    context.transitionDidEnd()
  }
}
