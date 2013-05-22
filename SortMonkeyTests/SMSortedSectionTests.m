//
//  SMSortedSectionTests.m
//  SMSortedDataController
//
//  Created by Bruce Ricketts on 5/1/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import "SMSortedSectionTests.h"

@implementation SMSortedSectionTests

- (NSArray *)sectionMembers {
    return @[ @"Apple", @"Orange", @"Banana", @"Pineapple", @"123" ];
}

- (void)setUp {
    [super setUp];
    
    _sortedSection = [[SMSortedSection alloc] init];
}

- (void)testAddAndRemoveObject {
    for (id member in [self sectionMembers]) {
        [self.sortedSection addObject:member];
    }
    
    STAssertEquals([self.sortedSection numberOfObjects], (NSUInteger)5, @"Section should have 5 objects");
    
    for (id member in [self sectionMembers]) {
        [self.sortedSection removeObject:member];
    }
    
    STAssertEquals([self.sortedSection numberOfObjects], (NSUInteger)0, @"Section should have 0 objects");
}

- (void)testSetAllObjects {
    [self.sortedSection setAllObjects:[self sectionMembers]];
    
    STAssertEquals([self.sortedSection numberOfObjects], (NSUInteger)5, @"Section should have 5 objects");
    
    [self.sortedSection setAllObjects:@[ @"Banana", @"Pineapple", @"Avocado" ]];
    
    STAssertEquals([self.sortedSection numberOfObjects], (NSUInteger)3, @"Section should have 3 objects");
}

- (void)testAllObjects {
    [self.sortedSection setAllObjects:[self sectionMembers]];
    
    NSSet *correctObjects = [NSSet setWithObjects:@"123", @"Apple", @"Banana", @"Orange", @"Pineapple", nil];
    STAssertTrue([[NSSet setWithArray:self.sortedSection.allObjects] isEqualToSet:correctObjects], @"allObjects should equal correctObjects");
}

- (void)testSortedObjects {
    [self.sortedSection setAllObjects:[self sectionMembers]];
    
    NSArray *correctSortedObjects = @[ @"123", @"Apple", @"Banana", @"Orange", @"Pineapple" ];
    STAssertTrue([self.sortedSection.sortedObjects isEqualToArray:correctSortedObjects], @"sortedObjects should equal correctSortedObjects");
}

- (void)testSortedObjectAtIndex {
    [self.sortedSection setAllObjects:[self sectionMembers]];
    
    NSArray *sortedObjects = [self.sortedSection sortedObjects];
    
    STAssertEqualObjects(sortedObjects[0], [self.sortedSection sortedObjectAtIndex:0], @"sortedObjects item at index 0 should equal sortedObjectAtIndex 0");
    STAssertEqualObjects(sortedObjects[1], [self.sortedSection sortedObjectAtIndex:1], @"sortedObjects item at index 1 should equal sortedObjectAtIndex 1");
    STAssertEqualObjects(sortedObjects[2], [self.sortedSection sortedObjectAtIndex:2], @"sortedObjects item at index 2 should equal sortedObjectAtIndex 2");
    STAssertEqualObjects(sortedObjects[3], [self.sortedSection sortedObjectAtIndex:3], @"sortedObjects item at index 3 should equal sortedObjectAtIndex 3");
    STAssertEqualObjects(sortedObjects[4], [self.sortedSection sortedObjectAtIndex:4], @"sortedObjects item at index 4 should equal sortedObjectAtIndex 4");
}

- (void)testNumberOfObjects {
    STAssertEquals([self.sortedSection numberOfObjects], (NSUInteger)0, @"Section should have 0 objects");
    
    [self.sortedSection setAllObjects:[self sectionMembers]];
    
    STAssertEquals([self.sortedSection numberOfObjects], (NSUInteger)5, @"Section should have 5 objects");
}

@end
