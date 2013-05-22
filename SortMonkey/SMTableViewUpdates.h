//
//  SMTableViewUpdates.h
//  SMSortedDataController
//
//  Created by Bruce Ricketts on 5/5/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMTableViewUpdates : NSObject
@property (strong, nonatomic)NSMutableArray *addedRowIndexPaths;
@property (strong, nonatomic)NSMutableArray *deletedRowIndexPaths;
@property (strong, nonatomic)NSMutableArray *addedSectionIndexSets;
@property (strong, nonatomic)NSMutableArray *deletedSectionIndexSets;
@end
