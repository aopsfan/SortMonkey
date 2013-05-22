//
//  SMContentUpdatesTests.m
//  SMSortedDataController
//
//  Created by Bruce Ricketts on 5/3/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import "SMContentUpdatesTests.h"

@implementation SMContentUpdatesTests

- (void)setUp {
    [super setUp];
    
    _contentUpdates = [SMContentUpdates contentUpdatesWithOldArray:@[ @"1", @"2", @"3" ] updatedArray:@[ @"1", @"2", @"4" ]];
}

- (void)testAddedObjects {
    STAssertEquals([[self.contentUpdates addedObjects] count], (NSUInteger)1, @"Added objects should have 1 object");
    STAssertTrue([[self.contentUpdates addedObjects] containsObject:@"4"], @"Added objects should contain 4");
    
    self.contentUpdates.oldArray = @[ @"1", @"3", @"5" ];
    self.contentUpdates.updatedArray = @[ @"2", @"4", @"6" ];
    
    STAssertEquals([[self.contentUpdates addedObjects] count], (NSUInteger)3, @"Added objects should have 3 objects");
    STAssertTrue([[self.contentUpdates addedObjects] containsObject:@"2"], @"Added objects should contain 2");
    STAssertTrue([[self.contentUpdates addedObjects] containsObject:@"4"], @"Added objects should contain 4");
    STAssertTrue([[self.contentUpdates addedObjects] containsObject:@"6"], @"Added objects should contain 6");
}

- (void)testDeletedObjects {
    STAssertEquals([[self.contentUpdates deletedObjects] count], (NSUInteger)1, @"Deleted objects should have 1 object");
    STAssertTrue([[self.contentUpdates deletedObjects] containsObject:@"3"], @"Deleted objects should contain 3");
    
    self.contentUpdates.oldArray = @[ @"1", @"3", @"5" ];
    self.contentUpdates.updatedArray = @[ @"2", @"4", @"6" ];
    
    STAssertEquals([[self.contentUpdates deletedObjects] count], (NSUInteger)3, @"Deleted objects should have 3 objects");
    STAssertTrue([[self.contentUpdates deletedObjects] containsObject:@"1"], @"Deleted objects should contain 1");
    STAssertTrue([[self.contentUpdates deletedObjects] containsObject:@"3"], @"Deleted objects should contain 3");
    STAssertTrue([[self.contentUpdates deletedObjects] containsObject:@"5"], @"Deleted objects should contain 5");
}

- (void)testAddAddedObject {
    [self.contentUpdates addAddedObject:@"5"];
    
    STAssertEquals([[self.contentUpdates addedObjects] count], (NSUInteger)2, @"Added objects should have 2 objects");
    STAssertTrue([[self.contentUpdates addedObjects] containsObject:@"4"], @"Added objects should contain 4");
    STAssertTrue([[self.contentUpdates addedObjects] containsObject:@"5"], @"Added objects should contain 5");
    
    [self.contentUpdates addAddedObject:@"3"];
    
    STAssertEquals([[self.contentUpdates addedObjects] count], (NSUInteger)2, @"Added objects should have 2 objects");
    STAssertTrue([[self.contentUpdates addedObjects] containsObject:@"4"], @"Added objects should contain 4");
    STAssertTrue([[self.contentUpdates addedObjects] containsObject:@"5"], @"Added objects should contain 5");
    
    STAssertEquals([[self.contentUpdates deletedObjects] count], (NSUInteger)0, @"Deleted objects should have 0 objects");
}

- (void)testAddDeletedObject {
    [self.contentUpdates addDeletedObject:@"5"];
    
    STAssertEquals([[self.contentUpdates deletedObjects] count], (NSUInteger)2, @"Deleted objects should have 2 objects");
    STAssertTrue([[self.contentUpdates deletedObjects] containsObject:@"3"], @"Deleted objects should contain 3");
    STAssertTrue([[self.contentUpdates deletedObjects] containsObject:@"5"], @"Deleted objects should contain 5");
    
    [self.contentUpdates addDeletedObject:@"4"];
    
    STAssertEquals([[self.contentUpdates addedObjects] count], (NSUInteger)0, @"Added objects should have 0 objects");
}

- (void)testAddContentUpdates {
    SMContentUpdates *newContentUpdates = [SMContentUpdates contentUpdatesWithOldArray:@[ @"1", @"2", @"4" ] updatedArray:@[ @"1", @"3", @"4", @"5" ]];
    [self.contentUpdates addContentUpdates:newContentUpdates];
    
    STAssertEquals([[self.contentUpdates addedObjects] count], (NSUInteger)2, @"Added objects should have 2 objects");
    STAssertTrue([[self.contentUpdates addedObjects] containsObject:@"4"], @"Added objects should contain 4");
    STAssertTrue([[self.contentUpdates addedObjects] containsObject:@"5"], @"Added objects should contain 5");
    
    STAssertEquals([[self.contentUpdates deletedObjects] count], (NSUInteger)1, @"Deleted objects should have 1 object");
    STAssertTrue([[self.contentUpdates deletedObjects] containsObject:@"2"], @"Deleted objects should contain 2");
}

@end
