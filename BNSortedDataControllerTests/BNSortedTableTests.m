//
//  BNSortedTableTests.m
//  BNSortedDataController
//
//  Created by Bruce Ricketts on 5/1/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import "BNSortedTableTests.h"
#import "BNSortedSection.h"

@implementation BNSortedTableTests

- (NSArray *)sampleSections {
    BNSortedSection *fruits = [[BNSortedSection alloc] init];
    BNSortedSection *meats = [[BNSortedSection alloc] init];
    BNSortedSection *dairy = [[BNSortedSection alloc] init];
    
    fruits.identifier = (id<BNSortableData>)@"Fruits";
    meats.identifier = (id<BNSortableData>)@"Meats";
    dairy.identifier = (id<BNSortableData>)@"Dairy";
    
    return @[ fruits, meats, dairy ];
}

- (void)setUp {
    [super setUp];
    
    _sortedTable = [[BNSortedTable alloc] init];
}

- (void)testAddAndRemoveSection {
    for (BNSortedSection *section in [self sampleSections]) {
        [self.sortedTable addSection:section];
    }
    
    STAssertEquals([self.sortedTable numberOfSections], (NSUInteger)3, @"Table should have 3 sections");
    
    NSArray *sections = [self.sortedTable sortedSections];
    for (BNSortedSection *section in sections) {
        [self.sortedTable removeSection:section];
    }
    
    STAssertEquals([self.sortedTable numberOfSections], (NSUInteger)0, @"Table should have 0 sections");
}

- (void)testRemoveAllSections {
    for (BNSortedSection *section in [self sampleSections]) {
        [self.sortedTable addSection:section];
    }
    
    [self.sortedTable removeAllSections];
    
    STAssertEquals([self.sortedTable numberOfSections], (NSUInteger)0, @"Table should have 0 sections");
}

- (void)testAllSections {
    for (BNSortedSection *section in [self sampleSections]) {
        [self.sortedTable addSection:section];
    }
    
    BOOL sectionIsDairy, sectionIsFruits, sectionIsMeats;
    
    for (BNSortedSection *section in [self.sortedTable allSections]) {
        sectionIsDairy = [(NSString *)section.identifier isEqualToString:@"Dairy"];
        sectionIsFruits = [(NSString *)section.identifier isEqualToString:@"Fruits"];
        sectionIsMeats = [(NSString *)section.identifier isEqualToString:@"Meats"];
        
        STAssertTrue(sectionIsDairy || sectionIsFruits || sectionIsMeats, @"Table should contain all the right sections");
    }
}

- (void)testSortedSections {
    for (BNSortedSection *section in [self sampleSections]) {
        [self.sortedTable addSection:section];
    }
    
    BNSortedSection *section1 = [self.sortedTable sortedSectionAtIndex:0];
    BNSortedSection *section2 = [self.sortedTable sortedSectionAtIndex:1];
    BNSortedSection *section3 = [self.sortedTable sortedSectionAtIndex:2];
    
    NSString *section1Identifier = (NSString *)section1.identifier;
    NSString *section2Identifier = (NSString *)section2.identifier;
    NSString *section3Identifier = (NSString *)section3.identifier;
    
    STAssertTrue([section1Identifier isEqualToString:@"Dairy"], @"Section 1 Identifier should be Dairy");
    STAssertTrue([section2Identifier isEqualToString:@"Fruits"], @"Section 2 Identifier should be Fruits");
    STAssertTrue([section3Identifier isEqualToString:@"Meats"], @"Section 3 Identifier should be Meats");
}

- (void)testSortedSectionAtIndex {
    for (BNSortedSection *section in [self sampleSections]) {
        [self.sortedTable addSection:section];
    }
    
    BNSortedSection *sectionAtIndex0 = [self.sortedTable sortedSectionAtIndex:0];
    BNSortedSection *sectionAtIndex1 = [self.sortedTable sortedSectionAtIndex:1];
    BNSortedSection *sectionAtIndex2 = [self.sortedTable sortedSectionAtIndex:2];
    
    BNSortedSection *section0 = self.sortedTable.sortedSections[0];
    BNSortedSection *section1 = self.sortedTable.sortedSections[1];
    BNSortedSection *section2 = self.sortedTable.sortedSections[2];
    
    STAssertEqualObjects(sectionAtIndex0, section0, @"sortedSections item at index 0 should equal sortedSectionAtIndex 0");
    STAssertEqualObjects(sectionAtIndex1, section1, @"sortedSections item at index 1 should equal sortedSectionAtIndex 1");
    STAssertEqualObjects(sectionAtIndex2, section2, @"sortedSections item at index 2 should equal sortedSectionAtIndex 2");
}

- (void)testNumberOfSections {
    STAssertEquals([self.sortedTable numberOfSections], (NSUInteger)0, @"Table should have 0 sections");
    
    for (BNSortedSection *section in [self sampleSections]) {
        [self.sortedTable addSection:section];
    }
    
    STAssertEquals([self.sortedTable numberOfSections], (NSUInteger)3, @"Table should have 3 sections");
}

@end
