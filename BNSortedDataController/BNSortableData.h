//
//  BNSortableData.h
//  BNSortedDataController
//
//  Created by Bruce Ricketts on 4/24/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BNSortableData <NSObject>
- (NSComparisonResult)compare:(id<BNSortableData>)otherObject;
- (id)valueForKey:(NSString *)key;
@end
