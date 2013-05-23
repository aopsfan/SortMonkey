//
//  SMSortedDataController.m
//  SMSortedDataController
//
//  Created by Bruce Ricketts on 4/23/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import "SMSortedDataController.h"
#import "SMSortedTable.h"
#import "SMSortedSection.h"
#import "SMContentUpdates.h"
#import "SMTableViewUpdates.h"

NSString *SMNotSortableDataException = @"SMNotSortableDataException";

@interface SMSortedDataController ()
@property (strong, nonatomic)SMSortedTable *sortedTable;
@property (strong, nonatomic)SMContentUpdates *contentUpdates;
@property (strong, nonatomic)NSMutableArray *mutableObjects;
@property BOOL shouldUpdateTable;
@property BOOL shouldDumpTableData;

- (NSMutableArray *)addedIndexPaths;
- (NSMutableArray *)deletedIndexPaths;

- (NSUInteger)sectionForIdentifier:(id<SMSortableData>)identifier commitUpdates:(BOOL)commitUpdates;
- (NSIndexPath *)indexPathForObject:(id<SMSortableData>)object commitUpdates:(BOOL)commitUpdates;

@end

@implementation SMSortedDataController

- (id)init
{
    self = [super init];
    if (self) {
        _sortedTable = [[SMSortedTable alloc] init];
        _contentUpdates = [SMContentUpdates contentUpdatesWithOldArray:@[] updatedArray:@[]];
        _mutableObjects = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark Private

- (NSMutableArray *)addedIndexPaths {
    NSMutableArray *addedIndexPaths = [NSMutableArray arrayWithCapacity:self.contentUpdates.addedObjects.count];
    
    for (id<SMSortableData> object in self.contentUpdates.addedObjects) {
        [addedIndexPaths addObject:[self indexPathForObject:object commitUpdates:NO]];
    }
    
    return addedIndexPaths;
}

- (NSMutableArray *)deletedIndexPaths {
    NSMutableArray *deletedIndexPaths = [NSMutableArray arrayWithCapacity:self.contentUpdates.deletedObjects.count];
    
    for (id<SMSortableData> object in self.contentUpdates.deletedObjects) {
        [deletedIndexPaths addObject:[self indexPathForObject:object commitUpdates:NO]];
    }
    
    return deletedIndexPaths;
}

- (NSUInteger)sectionForIdentifier:(id<SMSortableData>)identifier commitUpdates:(BOOL)commitUpdates {
    SMSortedTable *sortedTable = commitUpdates ? self.sortedTable : _sortedTable;
    NSUInteger section = NSNotFound;
    
    for (SMSortedSection *sortedSection in sortedTable.sortedSections) {
        if (sortedSection.identifier == identifier) {
            section = [sortedTable.sortedSections indexOfObject:sortedSection];
        }
    }
    
    return section;
}

- (NSIndexPath *)indexPathForObject:(id<SMSortableData>)object commitUpdates:(BOOL)commitUpdates {
    SMSortedTable *sortedTable = commitUpdates ? self.sortedTable : _sortedTable;
    NSIndexPath *indexPath = nil;
    
    for (SMSortedSection *sortedSection in sortedTable.sortedSections) {
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
    [self.contentUpdates addContentUpdates:[SMContentUpdates contentUpdatesWithOldArray:self.objects updatedArray:objects]];
    [self.mutableObjects setArray:objects];
    
    self.shouldUpdateTable = YES;
}

- (void)setSortKey:(NSString *)sortKey {
    _sortKey = sortKey;
    self.shouldUpdateTable = YES;
    
    if (self.sortedTable.numberOfSections > 0) {
        self.shouldDumpTableData = YES;
    }
}

- (NSArray *)objects {
    return [self.mutableObjects copy];
}

- (SMSortedTable *)sortedTable {
    [self commitUpdates];
    
    return _sortedTable;
}

#pragma mark Editing content

- (void)addObject:(id)object {
    [self.contentUpdates addAddedObject:object];
    [self.mutableObjects addObject:object];
    
    self.shouldUpdateTable = YES;
}

- (void)removeObject:(id)object {
    [self.contentUpdates addDeletedObject:object];
    [self.mutableObjects removeObject:object];
    
    self.shouldUpdateTable = YES;
}

- (void)removeObjectAtIndexPath:(NSIndexPath *)indexPath {
    id<SMSortableData> object = [self objectAtIndexPath:indexPath];
    [self removeObject:object];
}

#pragma mark Table view data source helpers

- (NSUInteger)numberOfSections {
    return [self.sortedTable numberOfSections];
}

- (NSUInteger)numberOfObjectsInSection:(NSUInteger)section {
    SMSortedSection *sortedSection = [self.sortedTable sortedSections][section];
    return [sortedSection numberOfObjects];
}

- (id<SMSortableData>)identifierForSection:(NSUInteger)section {
    SMSortedSection *sortedSection = [self.sortedTable sortedSections][section];
    return sortedSection.identifier;
}

- (id<SMSortableData>)objectAtIndexPath:(NSIndexPath *)indexPath {
    SMSortedSection *sortedSection = [self.sortedTable sortedSectionAtIndex:indexPath.section];
    return [sortedSection sortedObjectAtIndex:indexPath.row];
}

#pragma mark Other

- (NSUInteger)sectionForIdentifier:(id<SMSortableData>)identifier {
    return [self sectionForIdentifier:identifier commitUpdates:YES];
}

- (NSIndexPath *)indexPathForObject:(id<SMSortableData>)object {
    return [self indexPathForObject:object commitUpdates:YES];
}

- (void)commitUpdates {
    if (self.shouldUpdateTable) {
        SMTableViewUpdates *tableViewUpdates = [[SMTableViewUpdates alloc] init];
        
        // Delete old objects
        
        for (id<SMSortableData> deletedObject in self.contentUpdates.deletedObjects) {
            [tableViewUpdates.deletedRowIndexPaths addObject:[self indexPathForObject:deletedObject commitUpdates:NO]];
            
            SMSortedSection *section = nil;
            id<SMSortableData> identifier = [deletedObject valueForKey:self.sortKey];
            
            for (SMSortedSection *tempSection in [_sortedTable allSections]) {
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
        
        for (id<SMSortableData> object in self.contentUpdates.addedObjects) {
            if (![object conformsToProtocol:@protocol(SMSortableData)]) {
                NSException *exception = [NSException exceptionWithName:SMNotSortableDataException reason:[NSString stringWithFormat:@"Object %@ does not conform to SMSortableData protocol", object] userInfo:nil];
                [exception raise];
            }
            
            SMSortedSection *section = nil;
            id<SMSortableData> identifier = [object valueForKey:self.sortKey];
            
            if (![identifier respondsToSelector:@selector(compare:)]) {
                NSException *exception = [NSException exceptionWithName:SMNotSortableDataException reason:[NSString stringWithFormat:@"Section identifier %@ does not respond to -compare:", identifier] userInfo:nil];
                [exception raise];
            }
            
            for (SMSortedSection *tempSection in [_sortedTable allSections]) {
                if ([tempSection.identifier compare:identifier] == NSOrderedSame) {
                    section = tempSection;
                }
            }
            
            if (!section) {
                section = [[SMSortedSection alloc] init];
                section.identifier = identifier;
                
                [_sortedTable addSection:section];
                
                [tableViewUpdates.addedSectionIndexSets addObject:[NSIndexSet indexSetWithIndex:[_sortedTable.sortedSections indexOfObject:section]]];
            }
            
            [section addObject:object];
            
            [tableViewUpdates.addedRowIndexPaths addObject:[self indexPathForObject:object commitUpdates:NO]];
        }
        
        // Reset flags and content updates
        
        self.shouldUpdateTable = NO;
        self.shouldDumpTableData = NO;
        
        [self.contentUpdates clear];
        
        // Notify delegate
        
        [self.delegate sortedDataController:self didCommitUpdates:tableViewUpdates];
    }
}

@end
