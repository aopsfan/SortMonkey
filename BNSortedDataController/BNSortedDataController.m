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

@interface BNSortedDataController ()
@property (strong, nonatomic)BNSortedTable *sortedTable;
@property BOOL shouldReloadSortedTable;
@end

@implementation BNSortedDataController

- (id)init
{
    self = [super init];
    if (self) {
        _sortedTable = [[BNSortedTable alloc] init];
    }
    return self;
}

#pragma mark Setting data

- (void)setObjects:(NSArray *)objects {
    _objects = objects;
    self.shouldReloadSortedTable = YES;
}

- (void)setSortKey:(NSString *)sortKey {
    _sortKey = sortKey;
    self.shouldReloadSortedTable = YES;
}

#pragma mark Getting data

- (BNSortedTable *)sortedTable {
    if (self.shouldReloadSortedTable) {
        
        // Add new objects
        
        for (id<BNSortableData> object in self.objects) {
            BNSortedSection *section = nil;
            id<BNSortableData> identifier = [object valueForKey:self.sortKey];
            
            for (BNSortedSection *tempSection in [_sortedTable sortedSections]) {
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
        
        NSMutableSet *oldSections = [NSMutableSet set];
        
        for (BNSortedSection *tempSection in [_sortedTable sortedSections]) {
            for (id<BNSortableData> object in [tempSection sortedObjects]) {
                if (![self.objects containsObject:object]) {
                    [tempSection removeObject:object];
                }
            }
            
            if ([tempSection sortedObjects].count == 0) {
                [oldSections addObject:tempSection];
            }
        }
        
        for (BNSortedSection *oldSection in oldSections) {
            [_sortedTable removeSection:oldSection];
        }
        
        // Reset the should reload flag
        
        self.shouldReloadSortedTable = NO;
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
