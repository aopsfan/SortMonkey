//
//  Food.h
//  BNSortedDataController
//
//  Created by Bruce Ricketts on 4/30/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNSortableData.h"

@class Category;
@interface Food : NSObject <BNSortableData>
@property (weak, nonatomic)NSString *name;
@property (strong, nonatomic)Category *category;

+ (Food *)foodWithName:(NSString *)name category:(Category *)category;

@end
