//
//  BNSortedDataController.h
//  BNSortedDataController
//
//  Created by Bruce Ricketts on 4/23/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNSortableData.h"

@class BNSortedDataController, BNTableViewUpdates;
@protocol BNSortedDataControllerDelegate <NSObject>
@optional

- (void)sortedDataControllerDidReload:(BNSortedDataController *)controller committedUpdates:(BNTableViewUpdates *)tableViewUpdates;

@end

@interface BNSortedDataController : NSObject
@property (strong, nonatomic)NSArray *objects;
@property (weak, nonatomic)NSString *sortKey;
@property (weak, nonatomic)id<BNSortedDataControllerDelegate> delegate;

// Editing content
- (void)removeObjectAtIndexPath:(NSIndexPath *)indexPath;

// Table view data source helpers
- (NSUInteger)numberOfSections;
- (NSUInteger)numberOfRowsInSection:(NSUInteger)section;
- (id<BNSortableData>)identifierForSection:(NSUInteger)section;
- (id<BNSortableData>)objectAtIndexPath:(NSIndexPath *)indexPath;

// Other
- (NSUInteger)sectionForIdentifier:(id<BNSortableData>)identifier;
- (NSIndexPath *)indexPathForObject:(id<BNSortableData>)object;
- (void)reload;

@end
