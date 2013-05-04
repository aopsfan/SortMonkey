//
//  BNArrayComparisonTests.m
//  BNSortedDataController
//
//  Created by Bruce Ricketts on 5/3/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import "BNArrayComparisonTests.h"

@implementation BNArrayComparisonTests

- (void)setUp {
    [super setUp];
    
    _arrayComparison = [BNArrayComparison arrayComparisonWithOldArray:@[ @"1", @"2", @"3" ] updatedArray:@[ @"1", @"2", @"4" ]];
}

- (void)testAddedObjects {
    STAssertEquals([[self.arrayComparison addedObjects] count], (NSUInteger)1, @"Added objects should have 1 object");
    STAssertTrue([[self.arrayComparison addedObjects] containsObject:@"4"], @"Added objects should contain 4");
    
    self.arrayComparison.oldArray = @[ @"1", @"3", @"5" ];
    self.arrayComparison.updatedArray = @[ @"2", @"4", @"6" ];
    
    STAssertEquals([[self.arrayComparison addedObjects] count], (NSUInteger)3, @"Added objects should have 3 objects");
    STAssertTrue([[self.arrayComparison addedObjects] containsObject:@"2"], @"Added objects should contain 2");
    STAssertTrue([[self.arrayComparison addedObjects] containsObject:@"4"], @"Added objects should contain 4");
    STAssertTrue([[self.arrayComparison addedObjects] containsObject:@"6"], @"Added objects should contain 6");
}

- (void)testDeletedObjects {
    STAssertEquals([[self.arrayComparison deletedObjects] count], (NSUInteger)1, @"Deleted objects should have 1 object");
    STAssertTrue([[self.arrayComparison deletedObjects] containsObject:@"3"], @"Deleted objects should contain 3");
    
    self.arrayComparison.oldArray = @[ @"1", @"3", @"5" ];
    self.arrayComparison.updatedArray = @[ @"2", @"4", @"6" ];
    
    STAssertEquals([[self.arrayComparison deletedObjects] count], (NSUInteger)3, @"Deleted objects should have 3 objects");
    STAssertTrue([[self.arrayComparison deletedObjects] containsObject:@"1"], @"Deleted objects should contain 1");
    STAssertTrue([[self.arrayComparison deletedObjects] containsObject:@"3"], @"Deleted objects should contain 3");
    STAssertTrue([[self.arrayComparison deletedObjects] containsObject:@"5"], @"Deleted objects should contain 5");
}

- (void)testAddAddedObject {
    [self.arrayComparison addAddedObject:@"5"];
    
    STAssertEquals([[self.arrayComparison addedObjects] count], (NSUInteger)2, @"Added objects should have 2 objects");
    STAssertTrue([[self.arrayComparison addedObjects] containsObject:@"4"], @"Added objects should contain 4");
    STAssertTrue([[self.arrayComparison addedObjects] containsObject:@"5"], @"Added objects should contain 5");
    
    [self.arrayComparison addAddedObject:@"3"];
    
    STAssertEquals([[self.arrayComparison addedObjects] count], (NSUInteger)2, @"Added objects should have 2 objects");
    STAssertTrue([[self.arrayComparison addedObjects] containsObject:@"4"], @"Added objects should contain 4");
    STAssertTrue([[self.arrayComparison addedObjects] containsObject:@"5"], @"Added objects should contain 5");
    
    STAssertEquals([[self.arrayComparison deletedObjects] count], (NSUInteger)0, @"Deleted objects should have 0 objects");
}

- (void)testAddDeletedObject {
    [self.arrayComparison addDeletedObject:@"5"];
    
    STAssertEquals([[self.arrayComparison deletedObjects] count], (NSUInteger)2, @"Deleted objects should have 2 objects");
    STAssertTrue([[self.arrayComparison deletedObjects] containsObject:@"3"], @"Deleted objects should contain 3");
    STAssertTrue([[self.arrayComparison deletedObjects] containsObject:@"5"], @"Deleted objects should contain 5");
    
    [self.arrayComparison addDeletedObject:@"4"];
    
    STAssertEquals([[self.arrayComparison addedObjects] count], (NSUInteger)0, @"Added objects should have 0 objects");
}

- (void)testAddArrayComparison {
    BNArrayComparison *newArrayComparison = [BNArrayComparison arrayComparisonWithOldArray:@[ @"1", @"2", @"4" ] updatedArray:@[ @"1", @"3", @"4", @"5" ]];
    [self.arrayComparison addArrayComparison:newArrayComparison];
    
    STAssertEquals([[self.arrayComparison addedObjects] count], (NSUInteger)2, @"Added objects should have 2 objects");
    STAssertTrue([[self.arrayComparison addedObjects] containsObject:@"4"], @"Added objects should contain 4");
    STAssertTrue([[self.arrayComparison addedObjects] containsObject:@"5"], @"Added objects should contain 5");
    
    STAssertEquals([[self.arrayComparison deletedObjects] count], (NSUInteger)1, @"Deleted objects should have 1 object");
    STAssertTrue([[self.arrayComparison deletedObjects] containsObject:@"2"], @"Deleted objects should contain 2");
}

@end
