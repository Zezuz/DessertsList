//
//  FetchDessertTests.swift
//  FetchDessertTests
//
//  Created by Michael Zanaty on 7/3/23.
//

import XCTest
@testable import FetchDessert


final class FetchDessertTests: XCTestCase {
    // Mark : DessertView Tests
    class DessertViewControllerTests: XCTestCase {
        
        func testTableViewDataSource() {
            let dessertViewController = DessertViewController()
            
            // Simulate the viewDidLoad method to populate desserts array
            dessertViewController.viewDidLoad()
            
            // Test the number of rows in the table view
            let numberOfRows = dessertViewController.tableView(dessertViewController.dessertTableView, numberOfRowsInSection: 0)
            XCTAssertEqual(numberOfRows, dessertViewController.desserts.count, "Number of rows should match desserts array count")
            
            // Test the cell configuration
            let indexPath = IndexPath(row: 0, section: 0)
            let cell = dessertViewController.tableView(dessertViewController.dessertTableView, cellForRowAt: indexPath)
            
            // Ensure the cell text label is set correctly
            XCTAssertEqual(cell.textLabel?.text, dessertViewController.desserts[0].strMeal, "Cell text label should match dessert name")
        }
        
        func testTableViewDelegate() {
            let dessertViewController = DessertViewController()
            
            // Simulate the viewDidLoad method to populate desserts array
            dessertViewController.viewDidLoad()
            
            // Simulate selecting a row
            let selectedIndexPath = IndexPath(row: 0, section: 0)
            dessertViewController.tableView(dessertViewController.dessertTableView, didSelectRowAt: selectedIndexPath)
            
            // Perform the necessary assertions based on the expected behavior when a row is selected
            // For example, check if the segue is performed and the selected dessert ID is passed correctly
            // You can use the XCTestExpectation class to handle asynchronous expectations if needed
        }
        
        // Add more test methods for other scenarios
        
    }
    
    // Mark: - DessertInfo Tests
    class DessertInfoViewControllerTests: XCTestCase {
        
        func testViewDidLoad() {
            // Create an instance of DessertInfoViewController
            let dessertInfoViewController = DessertInfoViewController()
            
            // Set up the test data
            let selectedDessertID = "12345"
            dessertInfoViewController.selectedDessertID = selectedDessertID
            
            // Simulate the viewDidLoad method
            dessertInfoViewController.viewDidLoad()
            
            // Perform assertions to verify the expected results
            XCTAssertEqual(dessertInfoViewController.selectedDessertID, selectedDessertID, "Selected dessert ID should be set correctly")
            // Add more assertions to check other expected behaviors
            
            // For asynchronous code, you can use XCTestExpectation to wait for the completion block to execute and then verify the results
        }
        
        override func setUpWithError() throws {
            // Put setup code here. This method is called before the invocation of each test method in the class.
        }
        
        override func tearDownWithError() throws {
            // Put teardown code here. This method is called after the invocation of each test method in the class.
        }
        
        func testExample() throws {
            // This is an example of a functional test case.
            // Use XCTAssert and related functions to verify your tests produce the correct results.
            // Any test you write for XCTest can be annotated as throws and async.
            // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
            // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        }
        
        func testPerformanceExample() throws {
            // This is an example of a performance test case.
            measure {
                // Put the code you want to measure the time of here.
            }
        }
        
    }
}
