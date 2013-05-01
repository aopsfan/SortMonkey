//
//  Category.h
//  BNSortedDataController
//
//  Created by Bruce Ricketts on 4/30/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNSortableData.h"

@interface Category : NSObject <BNSortableData>
@property (weak, nonatomic)NSString *name;

+ (Category *)categoryWithName:(NSString *)name;

@end
