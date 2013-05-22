//
//  SMSortedTableViewController.h
//  SMSortedDataController
//
//  Created by Bruce Ricketts on 4/30/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMSortedDataController.h"

@interface SMSortedTableViewController : UITableViewController <SMSortedDataControllerDelegate>
@property (strong, nonatomic, readonly)SMSortedDataController *sortedDataController;
@end
