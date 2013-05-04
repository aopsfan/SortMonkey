//
//  BNSortedDataController.m
//  BNSortedDataController
//
//  Created by Bruce Ricketts on 4/23/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import "BNSortedDataController.h"
#import "BNSortedTable.h"
#import "BNSortedSection.h"
#import "BNArrayComparison.h"

@interface BNSortedDataController ()
@property (strong, nonatomic)BNSortedTable *sortedTable;
@property (strong, nonatomic)BNArrayComparison *arrayComparison;
@property BOOL shouldUpdateTable;
@property BOOL shouldDumpTableData;
@end

@implementation BNSortedDataController

- (id)init
{
    self = [super init];
    if (self) {
        _sortedTable = [[BNSortedTable alloc] init];
        _arrayComparison = [BNArrayComparison arrayComparisonWithOldArray:@[] updatedArray:@[]];
    }
    return self;
}

#pragma mark Setting data

- (void)setObjects:(NSArray *)objects {
    [self.arrayComparison addArrayComparison:[BNArrayComparison arrayComparisonWithOldArray:_objects updatedArray:objects]];
    _objects = objects;
    self.shouldUpdateTable = YES;
}

- (void)setSortKey:(NSString *)sortKey {
    _sortKey = sortKey;
    self.shouldUpdateTable = YES;
    
    if (self.sortedTable.numberOfSections > 0) {
        self.shouldDumpTableData = YES;
    }
}

#pragma mark Getting data

- (BNSortedTable *)sortedTable {
    if (self.shouldUpdateTable) {
        
        // Add new objects
        
        for (id<BNSortableData> object in self.arrayComparison.addedObjects) {
            BNSortedSection *section = nil;
            id<BNSortableData> identifier = [object valueForKey:self.sortKey];
            
            for (BNSortedSection *tempSection in [_sortedTable allSections]) {
                if ([tempSection.identifier compare:identifier] == NSOrderedSame) {
                    section = tempSection;
                }
            }
            
            if (!section) {
                section = [[BNSortedSection alloc] init];
                section.identifier = identifier;
                
                [_sortedTable addSection:section];
            }
            
            [section addObject:object];
        }
        
        // Delete old objects
        
        for (id<BNSortableData> deletedObject in self.arrayComparison.deletedObjects) {
            BNSortedSection *section = nil;
            id<BNSortableData> identifier = [deletedObject valueForKey:self.sortKey];
            
            for (BNSortedSection *tempSection in [_sortedTable allSections]) {
                if ([tempSection.identifier compare:identifier] == NSOrderedSame) {
                    section = tempSection;
                }
            }
            
            [section removeObject:deletedObject];
            
            if ([section numberOfObjects] == 0) {
                [_sortedTable removeSection:section];
            }
        }
        
        // Reset the should reload flags
        
        self.shouldUpdateTable = NO;
        self.shouldDumpTableData = NO;
    }
    
    return _sortedTable;
}

- (NSUInteger)numberOfSections {
    return [self.sortedTable numberOfSections];
}

- (NSUInteger)numberOfRowsInSection:(NSUInteger)section {
    BNSortedSection *sortedSection = [self.sortedTable sortedSections][section];
    return [sortedSection numberOfObjects];
}

- (id<BNSortableData>)identifierForSection:(NSUInteger)section {
    BNSortedSection *sortedSection = [self.sortedTable sortedSections][section];
    return sortedSection.identifier;
}

- (id<BNSortableData>)objectAtIndexPath:(NSIndexPath *)indexPath {
    BNSortedSection *sortedSection = [self.sortedTable sortedSectionAtIndex:indexPath.section];
    return [sortedSection sortedObjectAtIndex:indexPath.row];
}

@end
