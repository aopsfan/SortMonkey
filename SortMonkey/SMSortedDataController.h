//
//  SMSortedDataController.h
//  SMSortedDataController
//
//  Created by Bruce Ricketts on 4/23/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMSortableData.h"

@class SMSortedDataController, SMTableViewUpdates;
@protocol SMSortedDataControllerDelegate <NSObject>
@optional

- (void)sortedDataController:(SMSortedDataController *)controller didCommitUpdates:(SMTableViewUpdates *)tableViewUpdates;

@end

@interface SMSortedDataController : NSObject
@property (strong, nonatomic)NSArray *objects;
@property (weak, nonatomic)NSString *sortKey;
@property (weak, nonatomic)id<SMSortedDataControllerDelegate> delegate;

// Editing content
- (void)addObject:(id)object;
- (void)removeObject:(id)object;
- (void)removeObjectAtIndexPath:(NSIndexPath *)indexPath;

// Table view data source helpers
- (NSUInteger)numberOfSections;
- (NSUInteger)numberOfObjectsInSection:(NSUInteger)section;
- (id<SMSortableData>)identifierForSection:(NSUInteger)section;
- (id<SMSortableData>)objectAtIndexPath:(NSIndexPath *)indexPath;

// Other
- (NSUInteger)sectionForIdentifier:(id<SMSortableData>)identifier;
- (NSIndexPath *)indexPathForObject:(id<SMSortableData>)object;
- (void)commitUpdates;

@end
