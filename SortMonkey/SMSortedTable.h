//
//  SMSortedTable.h
//  SMSortedDataController
//
//  Created by Bruce Ricketts on 4/23/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SMSortedSection;
@interface SMSortedTable : NSObject

// Editing data
- (void)addSection:(SMSortedSection *)section;
- (void)removeSection:(SMSortedSection *)section;
- (void)removeAllSections;

// Getting data
- (NSArray *)allSections;
- (NSArray *)sortedSections;
- (SMSortedSection *)sortedSectionAtIndex:(NSUInteger)index;
- (NSUInteger)numberOfSections;

@end
