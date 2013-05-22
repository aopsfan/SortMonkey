//
//  SMContentUpdates.h
//  SMSortedDataController
//
//  Created by Bruce Ricketts on 5/3/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMContentUpdates : NSObject
@property (strong, nonatomic)NSArray *oldArray;
@property (strong, nonatomic)NSArray *updatedArray;

// Initializers
+ (SMContentUpdates *)contentUpdatesWithOldArray:(NSArray *)oldArray updatedArray:(NSArray *)updatedArray;

// Getting data
- (NSArray *)addedObjects;
- (NSArray *)deletedObjects;

// Setting data
- (void)addAddedObject:(id)addedObject;
- (void)addDeletedObject:(id)deletedObject;

- (void)addContentUpdates:(SMContentUpdates *)contentUpdates;
- (void)clear;

@end
