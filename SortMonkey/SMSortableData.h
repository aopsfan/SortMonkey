//
//  SMSortableData.h
//  SMSortedDataController
//
//  Created by Bruce Ricketts on 4/24/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SMSortableData <NSObject>
- (NSComparisonResult)compare:(id<SMSortableData>)otherObject;
- (id)valueForKey:(NSString *)key;
@end
