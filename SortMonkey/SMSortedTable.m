//
//  SMSortedTable.m
//  SMSortedDataController
//
//  Created by Bruce Ricketts on 4/23/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import "SMSortedTable.h"

@interface SMSortedTable ()
@property (strong, nonatomic)NSMutableArray *sections;
@property (strong, nonatomic)NSArray *sortedSections;
@property BOOL shouldRefreshSortedSections;
@end

@implementation SMSortedTable

- (id)init
{
    self = [super init];
    if (self) {
        _sections = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark Editing data

- (void)addSection:(SMSortedSection *)section {
    [self.sections addObject:section];
    self.shouldRefreshSortedSections = YES;
}

- (void)removeSection:(SMSortedSection *)section {
    [self.sections removeObject:section];
    self.shouldRefreshSortedSections = YES;
}

- (void)removeAllSections {
    [self.sections removeAllObjects];
    self.shouldRefreshSortedSections = YES;
}

#pragma mark Getting data

- (NSArray *)allSections {
    return self.sections;
}

- (NSArray *)sortedSections {
    if (self.shouldRefreshSortedSections) {
        _sortedSections = [self.sections sortedArrayUsingSelector:@selector(compare:)];
        self.shouldRefreshSortedSections = NO;
    }
    
    return _sortedSections;
}

- (SMSortedSection *)sortedSectionAtIndex:(NSUInteger)index {
    return self.sortedSections[index];
}

- (NSUInteger)numberOfSections {
    return [self.sections count];
}

@end
