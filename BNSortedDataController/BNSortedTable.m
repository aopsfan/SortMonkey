//
//  BNSortedTable.m
//  BNSortedDataController
//
//  Created by Bruce Ricketts on 4/23/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import "BNSortedTable.h"

@interface BNSortedTable ()
@property (strong, nonatomic)NSMutableArray *sections;
@property (strong, nonatomic)NSArray *sortedSections;
@property BOOL shouldRefreshSortedSections;
@end

@implementation BNSortedTable

- (id)init
{
    self = [super init];
    if (self) {
        _sections = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark Editing data

- (void)addSection:(BNSortedSection *)section {
    [self.sections addObject:section];
    self.shouldRefreshSortedSections = YES;
}

- (void)removeSection:(BNSortedSection *)section {
    [self.sections removeObject:section];
    self.shouldRefreshSortedSections = YES;
}

- (void)removeAllSections {
    [self.sections removeAllObjects];
    self.shouldRefreshSortedSections = YES;
}

#pragma mark Getting data

- (NSArray *)sortedSections {
    if (self.shouldRefreshSortedSections) {
        _sortedSections = [self.sections sortedArrayUsingSelector:@selector(compare:)];
        self.shouldRefreshSortedSections = NO;
    }
    
    return _sortedSections;
}

- (BNSortedSection *)sortedSectionAtIndex:(NSUInteger)index {
    return self.sortedSections[index];
}

- (NSUInteger)numberOfSections {
    return [self.sections count];
}

@end
