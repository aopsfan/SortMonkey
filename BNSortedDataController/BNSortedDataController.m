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
        // TODO: make this not suck
        // TODO: never show nick's dad this code
        // First, remove all data from the table
        [_sortedTable removeAllSections];
        
        // Add everything
        for (id<BNSortableData> object in self.objects) {
            BOOL shouldContinue = YES;
            NSComparisonResult sectionIdentifierComparison;
            id<BNSortableData> identifier = [object valueForKey:self.sortKey];
            
            for (BNSortedSection *section in [_sortedTable sortedSections]) {
                sectionIdentifierComparison = [section.identifier compare:identifier];
                if (sectionIdentifierComparison == NSOrderedSame) { // Add this item to an existing section
                    [section addObject:object];
                    shouldContinue = NO;
                    
                    break;
                }
            }
            
            if (shouldContinue) {
                BNSortedSection *section = [[BNSortedSection alloc] init];
                section.identifier = identifier;
                [section addObject:object];
                
                [_sortedTable addSection:section];
            }
        }
        
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
