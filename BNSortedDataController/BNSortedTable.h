//
//  BNSortedTable.h
//  BNSortedDataController
//
//  Created by Bruce Ricketts on 4/23/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNSortedSection;
@interface BNSortedTable : NSObject

// Editing data
- (void)addSection:(BNSortedSection *)section;
- (void)removeSection:(BNSortedSection *)section;
- (void)removeAllSections;

// Getting data
- (NSArray *)sortedSections;
- (BNSortedSection *)sortedSectionAtIndex:(NSUInteger)index;
- (NSUInteger)numberOfSections;

@end
