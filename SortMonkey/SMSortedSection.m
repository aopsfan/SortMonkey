//
//  SMSortedSection.m
//  SMSortedDataController
//
//  Created by Bruce Ricketts on 4/23/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import "SMSortedSection.h"

@interface SMSortedSection ()
@property (strong, nonatomic)NSMutableArray *objects;
@property (strong, nonatomic)NSArray *sortedObjects;
@property BOOL shouldRefreshSortedObjects;
@end

@implementation SMSortedSection

- (id)init
{
    self = [super init];
    if (self) {
        _objects = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSComparisonResult)compare:(id<SMSortableData>)otherObject {
    SMSortedSection *section = (SMSortedSection *)otherObject;
    return [self.identifier compare:section.identifier];
}

#pragma mark Editing data

- (void)addObject:(id<SMSortableData>)object {
    [self.objects addObject:object];
    self.shouldRefreshSortedObjects = YES;
}

- (void)removeObject:(id<SMSortableData>)object {
    [self.objects removeObject:object];
    self.shouldRefreshSortedObjects = YES;
}

- (void)setAllObjects:(NSArray *)objects {
    [self.objects setArray:objects];
    self.shouldRefreshSortedObjects = YES;
}

#pragma mark Getting data

- (NSArray *)allObjects {
    return self.objects;
}

- (NSArray *)sortedObjects {
    if (self.shouldRefreshSortedObjects) {
        self.sortedObjects = [self.objects sortedArrayUsingSelector:@selector(compare:)];
        self.shouldRefreshSortedObjects = NO;
    }
    
    return _sortedObjects;
}

- (id<SMSortableData>)sortedObjectAtIndex:(NSUInteger)index {
    return self.sortedObjects[index];
}

- (NSUInteger)numberOfObjects {
    return [self.objects count];
}

@end
