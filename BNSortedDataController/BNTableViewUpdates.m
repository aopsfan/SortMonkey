//
//  BNTableViewUpdates.m
//  BNSortedDataController
//
//  Created by Bruce Ricketts on 5/5/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import "BNTableViewUpdates.h"

@implementation BNTableViewUpdates

- (id)init
{
    self = [super init];
    if (self) {
        _addedRowIndexPaths = [[NSMutableArray alloc] init];
        _deletedRowIndexPaths = [[NSMutableArray alloc] init];
        
        _addedSectionIndexSets = [[NSMutableArray alloc] init];
        _deletedSectionIndexSets = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
