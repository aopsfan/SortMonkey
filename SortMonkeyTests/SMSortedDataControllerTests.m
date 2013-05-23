//
//  SMSortedDataControllerTests.m
//  SMSortedDataControllerTests
//
//  Created by Bruce Ricketts on 4/23/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import "SMSortedDataControllerTests.h"
#import "SMSortedSection.h"
#import "Food.h"

@implementation SMSortedDataControllerTests

- (void)setUp {
    [super setUp];
    
    _sortedDataController = [[SMSortedDataController alloc] init];
    [self.sortedDataController setObjects:[Food sampleFoods]];
    self.sortedDataController.sortKey = @"category";
}

- (void)testAddObject {
    Food *chicken = [Food foodWithName:@"Chicken" category:@"Meats"];
    Food *snickers = [Food foodWithName:@"Snickers" category:@"Candy"];
    
    [self.sortedDataController addObject:chicken];
    [self.sortedDataController addObject:snickers];
    
    STAssertEquals([self.sortedDataController numberOfObjectsInSection:0], (NSUInteger)1, @"Candy section should have 1 row");
    STAssertEquals([self.sortedDataController numberOfObjectsInSection:1], (NSUInteger)2, @"Dairy section should have 2 rows");
    STAssertEquals([self.sortedDataController numberOfObjectsInSection:2], (NSUInteger)4, @"Fruits sections should have 4 rows");
    STAssertEquals([self.sortedDataController numberOfObjectsInSection:3], (NSUInteger)5, @"Meats section should have 5 rows");
    STAssertEquals([self.sortedDataController numberOfObjectsInSection:4], (NSUInteger)3, @"Veggies section should have 3 rows");
    
    Food *chickenFromDataController = [self.sortedDataController objectAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:3]];
    Food *snickersFromDataController = [self.sortedDataController objectAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    STAssertEqualObjects(chicken, chickenFromDataController, @"%@ should be Chicken", chickenFromDataController.name);
    STAssertEqualObjects(snickers, snickersFromDataController, @"%@ should be Snickers", snickersFromDataController.name);
}

- (void)testRemoveObject {
    Food *mango = [self.sortedDataController objectAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    STAssertTrue([@"Mango" isEqualToString:mango.name], @"Object at index path [1, 1] should be Mango, not %@", mango.name);
    [self.sortedDataController removeObject:mango];
    
    STAssertEquals([self.sortedDataController numberOfObjectsInSection:1], (NSUInteger)3, @"Fruits section should have 3 rows");
    STAssertFalse([self.sortedDataController.objects containsObject:mango], @"Controller should not have Mango object");
    
    Food *orange = [self.sortedDataController objectAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    STAssertTrue([@"Orange" isEqualToString:orange.name], @"Object at index path [1, 1] should be Orange, not %@", orange.name);
    [self.sortedDataController removeObject:orange];
    
    STAssertEquals([self.sortedDataController numberOfObjectsInSection:1], (NSUInteger)2, @"Fruits section should have 2 rows");
    STAssertFalse([self.sortedDataController.objects containsObject:orange], @"Controller should not have Orange object");
    
    Food *apple = [self.sortedDataController objectAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    STAssertTrue([@"Apple" isEqualToString:apple.name], @"Object at index path [1, 1] should be Apple, not %@", apple.name);
    [self.sortedDataController removeObject:apple];
    
    STAssertEquals([self.sortedDataController numberOfObjectsInSection:1], (NSUInteger)1, @"Fruits section should have 1 row");
    STAssertFalse([self.sortedDataController.objects containsObject:apple], @"Controller should not have Apple object");
    
    Food *pineapple = [self.sortedDataController objectAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    STAssertTrue([@"Pineapple" isEqualToString:pineapple.name], @"Object at index path [1, 1] should be Pineapple, not %@", pineapple.name);
    [self.sortedDataController removeObject:pineapple];
    
    STAssertFalse([(NSString *)[self.sortedDataController identifierForSection:1] isEqualToString:@"Fruits"], @"Section at index 1 should have identifier Meats, not %@", [self.sortedDataController identifierForSection:1]);
}

- (void)testRemoveObjectAtIndexPath {
    NSIndexPath *mangoIndexPath = [NSIndexPath indexPathForRow:1 inSection:1];
    Food *mango = [self.sortedDataController objectAtIndexPath:mangoIndexPath];
    STAssertTrue([@"Mango" isEqualToString:mango.name], @"Object at index path [1, 1] should be Mango, not %@", mango.name);
    [self.sortedDataController removeObjectAtIndexPath:mangoIndexPath];
    
    STAssertEquals([self.sortedDataController numberOfObjectsInSection:1], (NSUInteger)3, @"Fruits section should have 3 rows");
    STAssertFalse([self.sortedDataController.objects containsObject:mango], @"Controller should not have Mango object");
    
    NSIndexPath *orangeIndexPath = [NSIndexPath indexPathForRow:1 inSection:1];
    Food *orange = [self.sortedDataController objectAtIndexPath:orangeIndexPath];
    STAssertTrue([@"Orange" isEqualToString:orange.name], @"Object at index path [1, 1] should be Orange, not %@", orange.name);
    [self.sortedDataController removeObjectAtIndexPath:orangeIndexPath];
    
    STAssertEquals([self.sortedDataController numberOfObjectsInSection:1], (NSUInteger)2, @"Fruits section should have 2 rows");
    STAssertFalse([self.sortedDataController.objects containsObject:orange], @"Controller should not have Orange object");
    
    NSIndexPath *appleIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    Food *apple = [self.sortedDataController objectAtIndexPath:appleIndexPath];
    STAssertTrue([@"Apple" isEqualToString:apple.name], @"Object at index path [1, 1] should be Apple, not %@", apple.name);
    [self.sortedDataController removeObjectAtIndexPath:appleIndexPath];
    
    STAssertEquals([self.sortedDataController numberOfObjectsInSection:1], (NSUInteger)1, @"Fruits section should have 1 row");
    STAssertFalse([self.sortedDataController.objects containsObject:apple], @"Controller should not have Apple object");
    
    NSIndexPath *pineappleIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    Food *pineapple = [self.sortedDataController objectAtIndexPath:pineappleIndexPath];
    STAssertTrue([@"Pineapple" isEqualToString:pineapple.name], @"Object at index path [1, 1] should be Pineapple, not %@", pineapple.name);
    [self.sortedDataController removeObjectAtIndexPath:pineappleIndexPath];
    
    STAssertFalse([(NSString *)[self.sortedDataController identifierForSection:1] isEqualToString:@"Fruits"], @"Section at index 1 should have identifier Meats, not %@", [self.sortedDataController identifierForSection:1]);
}

- (void)testNumberOfSections {
    STAssertEquals([self.sortedDataController numberOfSections], (NSUInteger)4, @"Controller should have 4 sections");
}

- (void)testNumberOfObjectsInSection {
    NSArray *numberOfObjectsPerSection = @[ @2, @4, @4, @3 ];
    
    for (NSUInteger index = 0; index < [self.sortedDataController numberOfSections]; index++) {
        STAssertEquals([self.sortedDataController numberOfObjectsInSection:index], [numberOfObjectsPerSection[index] unsignedIntegerValue], @"Section %i should have %@ rows", index, numberOfObjectsPerSection[index]);
    }
}

- (void)testIdentifierForSection {
    NSArray *identifiersPerSection = @[ @"Dairy", @"Fruits", @"Meats", @"Vegetables" ];
    
    for (NSUInteger index = 0; index < [self.sortedDataController numberOfSections]; index++) {
        STAssertEqualObjects([self.sortedDataController identifierForSection:index], identifiersPerSection[index], @"Section %i should have identifier %@", index, identifiersPerSection[index]);
    }
}

- (void)testObjectAtIndexPath {
    NSArray *namesForSection1 = @[ @"Cheese", @"Milk" ];
    NSArray *namesForSection2 = @[ @"Apple", @"Mango", @"Orange", @"Pineapple" ];
    NSArray *namesForSection3 = @[ @"Bacon", @"Burger", @"Pork", @"Steak" ];
    NSArray *namesForSection4 = @[ @"Cucumber", @"Green Beans", @"Tomato" ];
    
    for (NSUInteger index = 0; index < [self.sortedDataController numberOfObjectsInSection:0]; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        Food *food = (Food *)[self.sortedDataController objectAtIndexPath:indexPath];
        STAssertTrue([namesForSection1 containsObject:food.name], [NSString stringWithFormat:@"Object at index path %@ should be %@, is %@", indexPath, namesForSection1[index], food.name]);
    }
    
    for (NSUInteger index = 0; index < [self.sortedDataController numberOfObjectsInSection:1]; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:1];
        Food *food = (Food *)[self.sortedDataController objectAtIndexPath:indexPath];
        STAssertTrue([namesForSection2 containsObject:food.name], [NSString stringWithFormat:@"Object at index path %@ should be %@, is %@", indexPath, namesForSection2[index], food.name]);
    }
    
    for (NSUInteger index = 0; index < [self.sortedDataController numberOfObjectsInSection:2]; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:2];
        Food *food = (Food *)[self.sortedDataController objectAtIndexPath:indexPath];
        STAssertTrue([namesForSection3 containsObject:food.name], [NSString stringWithFormat:@"Object at index path %@ should be %@, is %@", indexPath, namesForSection3[index], food.name]);
    }
    
    for (NSUInteger index = 0; index < [self.sortedDataController numberOfObjectsInSection:3]; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:3];
        Food *food = (Food *)[self.sortedDataController objectAtIndexPath:indexPath];
        STAssertTrue([namesForSection4 containsObject:food.name], [NSString stringWithFormat:@"Object at index path %@ should be %@, is %@", indexPath, namesForSection4[index], food.name]);
    }
}

- (void)testSectionForIdentifier {
    NSUInteger sectionForDairyIdentifier = [self.sortedDataController sectionForIdentifier:(id<SMSortableData>)@"Dairy"];
    NSUInteger sectionForFruitsIdentifier = [self.sortedDataController sectionForIdentifier:(id<SMSortableData>)@"Fruits"];
    NSUInteger sectionForMeatsIdentifier = [self.sortedDataController sectionForIdentifier:(id<SMSortableData>)@"Meats"];
    NSUInteger sectionForVeggiesIdentifier = [self.sortedDataController sectionForIdentifier:(id<SMSortableData>)@"Vegetables"];
    
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
    
    for (NSUInteger index = 0; index < [self.sortedDataController numberOfObjectsInSection:0]; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        Food *food = (Food *)[self.sortedDataController objectAtIndexPath:indexPath];
        STAssertTrue([namesForSection1 containsObject:food.name], [NSString stringWithFormat:@"Object at index path %@ should be %@, is %@", indexPath, namesForSection1[index], food.name]);
    }
    
    for (NSUInteger index = 0; index < [self.sortedDataController numberOfObjectsInSection:1]; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:1];
        Food *food = (Food *)[self.sortedDataController objectAtIndexPath:indexPath];
        STAssertTrue([namesForSection2 containsObject:food.name], [NSString stringWithFormat:@"Object at index path %@ should be %@, is %@", indexPath, namesForSection2[index], food.name]);
    }
    
    for (NSUInteger index = 0; index < [self.sortedDataController numberOfObjectsInSection:2]; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:2];
        Food *food = (Food *)[self.sortedDataController objectAtIndexPath:indexPath];
        STAssertTrue([namesForSection3 containsObject:food.name], [NSString stringWithFormat:@"Object at index path %@ should be %@, is %@", indexPath, namesForSection3[index], food.name]);
    }
    
    for (NSUInteger index = 0; index < [self.sortedDataController numberOfObjectsInSection:3]; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:3];
        Food *food = (Food *)[self.sortedDataController objectAtIndexPath:indexPath];
        STAssertTrue([namesForSection4 containsObject:food.name], [NSString stringWithFormat:@"Object at index path %@ should be %@, is %@", indexPath, namesForSection4[index], food.name]);
    }
}

@end
