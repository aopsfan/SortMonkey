//
//  SMSortedSection.h
//  SMSortedDataController
//
//  Created by Bruce Ricketts on 4/23/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMSortableData.h"

@interface SMSortedSection : NSObject <SMSortableData>
@property (weak, nonatomic)id<SMSortableData> identifier;

// Editing data
- (void)addObject:(id<SMSortableData>)object;
- (void)removeObject:(id<SMSortableData>)object;
- (void)setAllObjects:(NSArray *)objects;

// Getting data
- (NSArray *)allObjects;
- (NSArray *)sortedObjects;
- (id<SMSortableData>)sortedObjectAtIndex:(NSUInteger)index;
- (NSUInteger)numberOfObjects;

@end
