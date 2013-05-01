//
//  BNSortedSection.h
//  BNSortedDataController
//
//  Created by Bruce Ricketts on 4/23/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNSortableData.h"

@interface BNSortedSection : NSObject <BNSortableData>
@property (weak, nonatomic)id<BNSortableData> identifier;

// Editing data
- (void)addObject:(id<BNSortableData>)object;
- (void)removeObject:(id<BNSortableData>)object;
- (void)setAllObjects:(NSArray *)objects;

// Getting data
- (NSArray *)sortedObjects;
- (id<BNSortableData>)sortedObjectAtIndex:(NSUInteger)index;
- (NSUInteger)numberOfObjects;

@end
