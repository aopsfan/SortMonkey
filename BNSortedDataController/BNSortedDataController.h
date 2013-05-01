//
//  BNSortedDataController.h
//  BNSortedDataController
//
//  Created by Bruce Ricketts on 4/23/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNSortableData.h"

@interface BNSortedDataController : NSObject
@property (strong, nonatomic)NSArray *objects;
@property (weak, nonatomic)NSString *sortKey;

// Getting data
- (NSUInteger)numberOfSections;
- (NSUInteger)numberOfRowsInSection:(NSUInteger)section;
- (id<BNSortableData>)identifierForSection:(NSUInteger)section;
- (id<BNSortableData>)objectAtIndexPath:(NSIndexPath *)indexPath;

@end
