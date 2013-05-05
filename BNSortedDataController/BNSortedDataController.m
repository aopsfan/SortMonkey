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

- (NSArray *)addedIndexPaths;
- (NSArray *)deletedIndexPaths;

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

#pragma mark Private

- (NSArray *)addedIndexPaths {
    NSMutableArray *addedIndexPaths = [NSMutableArray arrayWithCapacity:self.arrayComparison.addedObjects.count];
    
    for (id<BNSortableData> object in self.arrayComparison.addedObjects) {
        [addedIndexPaths addObject:[self indexPathForObject:object]];
    }
    
    return addedIndexPaths;
}

- (NSArray *)deletedIndexPaths {
    NSMutableArray *deletedIndexPaths = [NSMutableArray arrayWithCapacity:self.arrayComparison.deletedObjects.count];
    
    for (id<BNSortableData> object in self.arrayComparison.deletedObjects) {
        [deletedIndexPaths addObject:[self indexPathForObject:object]];
    }
    
    return deletedIndexPaths;
}

#pragma mark Setters/getters

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

- (BNSortedTable *)sortedTable {
    [self reload];
    
    return _sortedTable;
}

#pragma mark Editing content

- (void)removeObjectAtIndexPath:(NSIndexPath *)indexPath {
    id<BNSortableData> object = [self objectAtIndexPath:indexPath];
    
    [self.arrayComparison addDeletedObject:object];
    
    NSMutableArray *tempObjects = [NSMutableArray arrayWithArray:self.objects];
    [tempObjects addObject:object];
    self.objects = [NSArray arrayWithArray:tempObjects];
    
    self.shouldUpdateTable = YES;
}

#pragma mark Table view data source helpers

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

#pragma mark Other

- (NSIndexPath *)indexPathForObject:(id<BNSortableData>)object {
    NSIndexPath *indexPath = nil;
    
    for (BNSortedSection *sortedSection in _sortedTable.sortedSections) {
        if ([sortedSection.allObjects containsObject:object]) {
            NSUInteger row = [sortedSection.sortedObjects indexOfObject:object];
            NSUInteger section = [_sortedTable.sortedSections indexOfObject:sortedSection];
            indexPath = [NSIndexPath indexPathForRow:row inSection:section];
        }
    }
    
    
    return indexPath;
}

- (void)reload {
    if (self.shouldUpdateTable) {
        // Track deleted index paths now, since they won't be gone yet
        
        NSArray *deletedIndexPaths = [self deletedIndexPaths];
        
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
        
        // Track added index paths now
        
        NSArray *addedIndexPaths = [self addedIndexPaths];
        
        // Reset flags and array comparison
        
        self.shouldUpdateTable = NO;
        self.shouldDumpTableData = NO;
        
        [self.arrayComparison clear];
        
        // Notify delegate
        
        [self.delegate sortedDataControllerDidReload:self addedIndexPaths:addedIndexPaths deletedIndexPaths:deletedIndexPaths];
    }
}

@end
