//
//  SMSortedTableTests.m
//  SMSortedDataController
//
//  Created by Bruce Ricketts on 5/1/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import "SMSortedTableTests.h"
#import "SMSortedSection.h"

@implementation SMSortedTableTests

- (NSArray *)sampleSections {
    SMSortedSection *fruits = [[SMSortedSection alloc] init];
    SMSortedSection *meats = [[SMSortedSection alloc] init];
    SMSortedSection *dairy = [[SMSortedSection alloc] init];
    
    fruits.identifier = (id<SMSortableData>)@"Fruits";
    meats.identifier = (id<SMSortableData>)@"Meats";
    dairy.identifier = (id<SMSortableData>)@"Dairy";
    
    return @[ fruits, meats, dairy ];
}

- (void)setUp {
    [super setUp];
    
    _sortedTable = [[SMSortedTable alloc] init];
}

- (void)testAddAndRemoveSection {
    for (SMSortedSection *section in [self sampleSections]) {
        [self.sortedTable addSection:section];
    }
    
    STAssertEquals([self.sortedTable numberOfSections], (NSUInteger)3, @"Table should have 3 sections");
    
    NSArray *sections = [self.sortedTable sortedSections];
    for (SMSortedSection *section in sections) {
        [self.sortedTable removeSection:section];
    }
    
    STAssertEquals([self.sortedTable numberOfSections], (NSUInteger)0, @"Table should have 0 sections");
}

- (void)testRemoveAllSections {
    for (SMSortedSection *section in [self sampleSections]) {
        [self.sortedTable addSection:section];
    }
    
    [self.sortedTable removeAllSections];
    
    STAssertEquals([self.sortedTable numberOfSections], (NSUInteger)0, @"Table should have 0 sections");
}

- (void)testAllSections {
    for (SMSortedSection *section in [self sampleSections]) {
        [self.sortedTable addSection:section];
    }
    
    BOOL sectionIsDairy, sectionIsFruits, sectionIsMeats;
    
    for (SMSortedSection *section in [self.sortedTable allSections]) {
        sectionIsDairy = [(NSString *)section.identifier isEqualToString:@"Dairy"];
        sectionIsFruits = [(NSString *)section.identifier isEqualToString:@"Fruits"];
        sectionIsMeats = [(NSString *)section.identifier isEqualToString:@"Meats"];
        
        STAssertTrue(sectionIsDairy || sectionIsFruits || sectionIsMeats, @"Table should contain all the right sections");
    }
}

- (void)testSortedSections {
    for (SMSortedSection *section in [self sampleSections]) {
        [self.sortedTable addSection:section];
    }
    
    SMSortedSection *section1 = [self.sortedTable sortedSectionAtIndex:0];
    SMSortedSection *section2 = [self.sortedTable sortedSectionAtIndex:1];
    SMSortedSection *section3 = [self.sortedTable sortedSectionAtIndex:2];
    
    NSString *section1Identifier = (NSString *)section1.identifier;
    NSString *section2Identifier = (NSString *)section2.identifier;
    NSString *section3Identifier = (NSString *)section3.identifier;
    
    STAssertTrue([section1Identifier isEqualToString:@"Dairy"], @"Section 1 Identifier should be Dairy");
    STAssertTrue([section2Identifier isEqualToString:@"Fruits"], @"Section 2 Identifier should be Fruits");
    STAssertTrue([section3Identifier isEqualToString:@"Meats"], @"Section 3 Identifier should be Meats");
}

- (void)testSortedSectionAtIndex {
    for (SMSortedSection *section in [self sampleSections]) {
        [self.sortedTable addSection:section];
    }
    
    SMSortedSection *sectionAtIndex0 = [self.sortedTable sortedSectionAtIndex:0];
    SMSortedSection *sectionAtIndex1 = [self.sortedTable sortedSectionAtIndex:1];
    SMSortedSection *sectionAtIndex2 = [self.sortedTable sortedSectionAtIndex:2];
    
    SMSortedSection *section0 = self.sortedTable.sortedSections[0];
    SMSortedSection *section1 = self.sortedTable.sortedSections[1];
    SMSortedSection *section2 = self.sortedTable.sortedSections[2];
    
    STAssertEqualObjects(sectionAtIndex0, section0, @"sortedSections item at index 0 should equal sortedSectionAtIndex 0");
    STAssertEqualObjects(sectionAtIndex1, section1, @"sortedSections item at index 1 should equal sortedSectionAtIndex 1");
    STAssertEqualObjects(sectionAtIndex2, section2, @"sortedSections item at index 2 should equal sortedSectionAtIndex 2");
}

- (void)testNumberOfSections {
    STAssertEquals([self.sortedTable numberOfSections], (NSUInteger)0, @"Table should have 0 sections");
    
    for (SMSortedSection *section in [self sampleSections]) {
        [self.sortedTable addSection:section];
    }
    
    STAssertEquals([self.sortedTable numberOfSections], (NSUInteger)3, @"Table should have 3 sections");
}

@end
