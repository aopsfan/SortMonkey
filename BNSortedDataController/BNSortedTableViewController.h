//
//  BNSortedTableViewController.h
//  BNSortedDataController
//
//  Created by Bruce Ricketts on 4/30/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNSortedDataController.h"

@interface BNSortedTableViewController : UITableViewController <BNSortedDataControllerDelegate>
@property (strong, nonatomic, readonly)BNSortedDataController *sortedDataController;
@end
