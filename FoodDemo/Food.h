//
//  Food.h
//  BNSortedDataController
//
//  Created by Bruce Ricketts on 4/30/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNSortableData.h"

@interface Food : NSObject <BNSortableData>
@property (weak, nonatomic)NSString *name;
@property (strong, nonatomic)NSString *category;

+ (Food *)foodWithName:(NSString *)name category:(NSString *)category;

@end
