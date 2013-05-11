//
//  BNSortedDataControllerTests.m
//  BNSortedDataControllerTests
//
//  Created by Bruce Ricketts on 4/23/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import "BNSortedDataControllerTests.h"
#import "BNSortedSection.h"
#import "Food.h"

@implementation BNSortedDataControllerTests

- (void)setUp {
    [super setUp];
    
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

- (void)testSectionForIdentifier {
    NSUInteger sectionForDairyIdentifier = [self.sortedDataController sectionForIdentifier:(id<BNSortableData>)@"Dairy"];
    NSUInteger sectionForFruitsIdentifier = [self.sortedDataController sectionForIdentifier:(id<BNSortableData>)@"Fruits"];
    NSUInteger sectionForMeatsIdentifier = [self.sortedDataController sectionForIdentifier:(id<BNSortableData>)@"Meats"];
    NSUInteger sectionForVeggiesIdentifier = [self.sortedDataController sectionForIdentifier:(id<BNSortableData>)@"Vegetables"];
    
    STAssertEquals(sectionForDairyIdentifier, (NSUInteger)0, @"Dairy section should be at index 0");
    STAssertEquals(sectionForFruitsIdentifier, (NSUInteger)1, @"Fruits section should be at index 1");
    STAssertEquals(sectionForMeatsIdentifier, (NSUInteger)2, @"Meats section should be at index 2");
    STAssertEquals(sectionForVeggiesIdentifier, (NSUInteger)3, @"Veggies section should be at index 3");
}

- (void)testIndexOfObject {
    for (Food *food in self.sortedDataController.objects) {
        Food *testFood = [self.sortedDataController objectAtIndexPath:[self.sortedDataController indexPathForObject:food]];
        STAssertEquals(food, testFood, [NSString stringWithFormat:@"Food (%@) should equal food (%@)", testFood.name, food.name]);
    }
}

- (void)testUpdateContent {
    NSMutableArray *newSampleFoods = [[Food sampleFoods] mutableCopy];
    [newSampleFoods removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(4, 4)]]; // All veggies and one dairy
    
    Food *iceCream = [Food foodWithName:@"Ice Cream" category:@"Dairy"];
    Food *jollyRanchers = [Food foodWithName:@"Jolly Ranchers" category:@"Candy"];
    Food *cowTales = [Food foodWithName:@"Cow Tales" category:@"Candy"];
    
    [newSampleFoods addObjectsFromArray:@[ iceCream, jollyRanchers, cowTales ]];
    
    [self.sortedDataController setObjects:newSampleFoods];
    
    STAssertEquals([self.sortedDataController numberOfSections], (NSUInteger)4, @"Controller should have 3 sections");
    
    NSArray *namesForSection1 = @[ @"Cow Tales", @"Jolly Ranchers" ];
    NSArray *namesForSection2 = @[ @"Cheese", @"Ice Cream" ];
    NSArray *namesForSection3 = @[ @"Apple", @"Mango", @"Orange", @"Pineapple" ];
    NSArray *namesForSection4 = @[ @"Bacon", @"Burger", @"Pork", @"Steak" ];
    
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
