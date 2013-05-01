//
//  Food.m
//  BNSortedDataController
//
//  Created by Bruce Ricketts on 4/30/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import "Food.h"

@implementation Food

- (NSComparisonResult)compare:(id<BNSortableData>)otherObject {
    Food *otherFood = (Food *)otherObject;
    return [self.name compare:otherFood.name];
}

+ (Food *)foodWithName:(NSString *)name category:(Category *)category {
    Food *food = [[Food alloc] init];
    food.name = name;
    food.category = category;
    
    return food;
}

@end
