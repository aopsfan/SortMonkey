//
//  BNArrayComparison.h
//  BNSortedDataController
//
//  Created by Bruce Ricketts on 5/3/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNArrayComparison : NSObject
@property (strong, nonatomic)NSArray *oldArray;
@property (strong, nonatomic)NSArray *updatedArray;

// Initializers
+ (BNArrayComparison *)arrayComparisonWithOldArray:(NSArray *)oldArray updatedArray:(NSArray *)updatedArray;

// Getting data
- (NSArray *)addedObjects;
- (NSArray *)deletedObjects;

// Setting data
- (void)addAddedObject:(id)addedObject;
- (void)addDeletedObject:(id)deletedObject;

- (void)addArrayComparison:(BNArrayComparison *)arrayComparison;
- (void)clear;

@end
