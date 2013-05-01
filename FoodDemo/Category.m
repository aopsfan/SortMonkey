//
//  Category.m
//  BNSortedDataController
//
//  Created by Bruce Ricketts on 4/30/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import "Category.h"

@implementation Category

- (NSComparisonResult)compare:(id<BNSortableData>)otherObject {
    Category *otherCategory = (Category *)otherObject;
    return [self.name compare:otherCategory.name];
}

+ (Category *)categoryWithName:(NSString *)name {
    Category *category = [[Category alloc] init];
    category.name = name;
    
    return category;
}

@end
