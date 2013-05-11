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
#import "BNTableViewUpdates.h"

@interface BNSortedDataController ()
@property (strong, nonatomic)BNSortedTable *sortedTable;
@property (strong, nonatomic)BNArrayComparison *arrayComparison;
@property BOOL shouldUpdateTable;
@property BOOL shouldDumpTableData;

- (NSMutableArray *)addedIndexPaths;
- (NSMutableArray *)deletedIndexPaths;

- (NSUInteger)sectionForIdentifier:(id<BNSortableData>)identifier commitUpdates:(BOOL)commitUpdates;
- (NSIndexPath *)indexPathForObject:(id<BNSortableData>)object commitUpdates:(BOOL)commitUpdates;

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

- (NSMutableArray *)addedIndexPaths {
    NSMutableArray *addedIndexPaths = [NSMutableArray arrayWithCapacity:self.arrayComparison.addedObjects.count];
    
    for (id<BNSortableData> object in self.arrayComparison.addedObjects) {
        [addedIndexPaths addObject:[self indexPathForObject:object commitUpdates:NO]];
    }
    
    return addedIndexPaths;
}

- (NSMutableArray *)deletedIndexPaths {
    NSMutableArray *deletedIndexPaths = [NSMutableArray arrayWithCapacity:self.arrayComparison.deletedObjects.count];
    
    for (id<BNSortableData> object in self.arrayComparison.deletedObjects) {
        [deletedIndexPaths addObject:[self indexPathForObject:object commitUpdates:NO]];
    }
    
    return deletedIndexPaths;
}

- (NSUInteger)sectionForIdentifier:(id<BNSortableData>)identifier commitUpdates:(BOOL)commitUpdates {
    BNSortedTable *sortedTable = commitUpdates ? self.sortedTable : _sortedTable;
    NSUInteger section = NSNotFound;
    
    for (BNSortedSection *sortedSection in sortedTable.sortedSections) {
        if (sortedSection.identifier == identifier) {
            section = [sortedTable.sortedSections indexOfObject:sortedSection];
        }
    }
    
    return section;
}

- (NSIndexPath *)indexPathForObject:(id<BNSortableData>)object commitUpdates:(BOOL)commitUpdates {
    BNSortedTable *sortedTable = commitUpdates ? self.sortedTable : _sortedTable;
    NSIndexPath *indexPath = nil;
    
    for (BNSortedSection *sortedSection in sortedTable.sortedSections) {
        if ([sortedSection.allObjects containsObject:object]) {
            NSUInteger row = [sortedSection.sortedObjects indexOfObject:object];
            NSUInteger section = [sortedTable.sortedSections indexOfObject:sortedSection];
            indexPath = [NSIndexPath indexPathForRow:row inSection:section];
        }
    }
    
    return indexPath;
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
    [self commitUpdates];
    
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

- (NSUInteger)sectionForIdentifier:(id<BNSortableData>)identifier {
    return [self sectionForIdentifier:identifier commitUpdates:YES];
}

- (NSIndexPath *)indexPathForObject:(id<BNSortableData>)object {
    return [self indexPathForObject:object commitUpdates:YES];
}

- (void)commitUpdates {
    if (self.shouldUpdateTable) {
        BNTableViewUpdates *tableViewUpdates = [[BNTableViewUpdates alloc] init];
        
        // Delete old objects
        
        for (id<BNSortableData> deletedObject in self.arrayComparison.deletedObjects) {
            [tableViewUpdates.deletedRowIndexPaths addObject:[self indexPathForObject:deletedObject commitUpdates:NO]];
            
            BNSortedSection *section = nil;
            id<BNSortableData> identifier = [deletedObject valueForKey:self.sortKey];
            
            for (BNSortedSection *tempSection in [_sortedTable allSections]) {
                if ([tempSection.identifier compare:identifier] == NSOrderedSame) {
                    section = tempSection;
                }
            }
            
            [section removeObject:deletedObject];
            
            if ([section numberOfObjects] == 0) {
                [tableViewUpdates.deletedSectionIndexSets addObject:[NSIndexSet indexSetWithIndex:[_sortedTable.sortedSections indexOfObject:section]]];
                
                [_sortedTable removeSection:section];
            }
        }
        
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
                
                [tableViewUpdates.addedSectionIndexSets addObject:[NSIndexSet indexSetWithIndex:[_sortedTable.sortedSections indexOfObject:section]]];
            }
            
            [section addObject:object];
            
            [tableViewUpdates.addedRowIndexPaths addObject:[self indexPathForObject:object commitUpdates:NO]];
        }
        
        // Reset flags and array comparison
        
        self.shouldUpdateTable = NO;
        self.shouldDumpTableData = NO;
        
        [self.arrayComparison clear];
        
        // Notify delegate
        
        [self.delegate sortedDataController:self didCommitUpdates:tableViewUpdates];
    }
}

@end
