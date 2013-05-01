//
//  BNSortedDataControllerTests.m
//  BNSortedDataControllerTests
//
//  Created by Bruce Ricketts on 4/23/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import "BNSortedDataControllerTests.h"
#import "Food.h"

@implementation BNSortedDataControllerTests

- (void)setUp {
    _sortedDataController = [[BNSortedDataController alloc] init];
    [self.sortedDataController setObjects:[Food sampleFoods]];
    self.sortedDataController.sortKey = @"category";
}

- (void)testNumberOfSections {
    STAssertEquals([self.sortedDataController numberOfSections], (NSUInteger)4, @"Controller should have 4 sections");
}

- (void)testNumberOfRowsInSection {
    NSArray *numberOfRowsPerSection = @[ @2, @4, @4, @3 ];
    
    for (NSUInteger index = 0; index < [self.sortedDataController numberOfSections]; index++) {
        STAssertEquals([self.sortedDataController numberOfRowsInSection:index], [numberOfRowsPerSection[index] unsignedIntegerValue], [NSString stringWithFormat:@"Section %i should have %@ rows", index, numberOfRowsPerSection[index]]);
    }
}

- (void)testIdentifierForSection {
    NSArray *identifiersPerSection = @[ @"Dairy", @"Fruits", @"Meats", @"Vegetables" ];
    
    for (NSUInteger index = 0; index < [self.sortedDataController numberOfSections]; index++) {
        STAssertEqualObjects([self.sortedDataController identifierForSection:index], identifiersPerSection[index], [NSString stringWithFormat:@"Section %i should have identifier %@", index, identifiersPerSection[index]]);
    }
}

- (void)testObjectAtIndexPath {
    NSArray *namesForSection1 = @[ @"Cheese", @"Milk" ];
    NSArray *namesForSection2 = @[ @"Apple", @"Mango", @"Orange", @"Pineapple" ];
    NSArray *namesForSection3 = @[ @"Bacon", @"Burger", @"Pork", @"Steak" ];
    NSArray *namesForSection4 = @[ @"Cucumber", @"Green Beans", @"Tomato" ];
    
    for (NSUInteger index = 0; index < [self.sortedDataController numberOfRowsInSection:0]; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        Food *food = (Food *)[self.sortedDataController objectAtIndexPath:indexPath];
        STAssertTrue([namesForSection1 containsObject:food.name], [NSString stringWithFormat:@"Object at index path %@ should be %@, is %@", indexPath, namesForSection1[index], food.name]);
    }
    
    for (NSUInteger index = 0; index < [self.sortedDataController numberOfRowsInSection:1]; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:1];
        Food *food = (Food *)[self.sortedDataController objectAtIndexPath:indexPath];
        STAssertTrue([namesForSection2 containsObject:food.name], [NSString stringWithFormat:@"Object at index path %@ should be %@, is %@", indexPath, namesForSection2[index], food.name]);
    }
    
    for (NSUInteger index = 0; index < [self.sortedDataController numberOfRowsInSection:2]; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:2];
        Food *food = (Food *)[self.sortedDataController objectAtIndexPath:indexPath];
        STAssertTrue([namesForSection3 containsObject:food.name], [NSString stringWithFormat:@"Object at index path %@ should be %@, is %@", indexPath, namesForSection3[index], food.name]);
    }
    
    for (NSUInteger index = 0; index < [self.sortedDataController numberOfRowsInSection:3]; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:3];
        Food *food = (Food *)[self.sortedDataController objectAtIndexPath:indexPath];
        STAssertTrue([namesForSection4 containsObject:food.name], [NSString stringWithFormat:@"Object at index path %@ should be %@, is %@", indexPath, namesForSection4[index], food.name]);
    }
}

@end
