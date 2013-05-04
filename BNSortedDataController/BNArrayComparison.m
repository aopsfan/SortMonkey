//
//  BNArrayComparison.m
//  BNSortedDataController
//
//  Created by Bruce Ricketts on 5/3/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import "BNArrayComparison.h"

@interface BNArrayComparison ()
@property (strong, nonatomic)NSMutableArray *mutableAddedObjects, *mutableDeletedObjects;

@property BOOL shouldRefreshAddedObjects;
@property BOOL shouldRefreshDeletedObjects;
@end

@implementation BNArrayComparison

#pragma mark Setters

- (void)setOldArray:(NSArray *)oldArray {
    _oldArray = oldArray;
    self.shouldRefreshAddedObjects = YES;
    self.shouldRefreshDeletedObjects = YES;
}

- (void)setUpdatedArray:(NSArray *)updatedArray {
    _updatedArray = updatedArray;
    self.shouldRefreshAddedObjects = YES;
    self.shouldRefreshDeletedObjects = YES;
}

#pragma mark Initializers

- (id)init
{
    self = [super init];
    if (self) {
        _mutableAddedObjects = [[NSMutableArray alloc] init];
        _mutableDeletedObjects = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (BNArrayComparison *)arrayComparisonWithOldArray:(NSArray *)oldArray updatedArray:(NSArray *)updatedArray {
    BNArrayComparison *arrayComparison = [[BNArrayComparison alloc] init];
    arrayComparison.oldArray = oldArray;
    arrayComparison.updatedArray = updatedArray;
    
    return arrayComparison;
}

#pragma mark Getting data

- (NSArray *)addedObjects {
    if (self.shouldRefreshAddedObjects) {
        [self.mutableAddedObjects removeAllObjects];
        
        for (id object in self.updatedArray) {
            if (![self.oldArray containsObject:object]) {
                [self.mutableAddedObjects addObject:object];
            }
        }
        
        self.shouldRefreshAddedObjects = NO;
    }
    
    return self.mutableAddedObjects;
}

- (NSArray *)deletedObjects {
    if (self.shouldRefreshDeletedObjects) {
        [self.mutableDeletedObjects removeAllObjects];
        
        for (id object in self.oldArray) {
            if (![self.updatedArray containsObject:object]) {
                [self.mutableDeletedObjects addObject:object];
            }
        }
        
        self.shouldRefreshDeletedObjects = NO;
    }
    
    return self.mutableDeletedObjects;
}

#pragma mark Setting data

- (void)addAddedObject:(id)addedObject {
    if ([self.deletedObjects containsObject:addedObject]) {
        [(NSMutableArray *)self.deletedObjects removeObject:addedObject];
    } else {
        [(NSMutableArray *)self.addedObjects addObject:addedObject];
    }
}

- (void)addDeletedObject:(id)deletedObject {
    if ([self.addedObjects containsObject:deletedObject]) {
        [(NSMutableArray *)self.addedObjects removeObject:deletedObject];
    } else {
        [(NSMutableArray *)self.deletedObjects addObject:deletedObject];
    }
}

- (void)addArrayComparison:(BNArrayComparison *)arrayComparison {
    for (id addedObject in arrayComparison.addedObjects) {
        [self addAddedObject:addedObject];
    }
    
    for (id deletedObject in arrayComparison.deletedObjects) {
        [self addDeletedObject:deletedObject];
    }
}

- (void)clear {
    self.oldArray = @[];
    self.updatedArray = @[];
}

@end
