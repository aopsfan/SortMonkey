//
//  BNSortedTableViewController.m
//  BNSortedDataController
//
//  Created by Bruce Ricketts on 4/30/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import "BNSortedTableViewController.h"
#import "BNTableViewUpdates.h"

@implementation BNSortedTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        _sortedDataController = [[BNSortedDataController alloc] init];
        self.sortedDataController.delegate = self;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _sortedDataController = [[BNSortedDataController alloc] init];
        self.sortedDataController.delegate = self;
    }
    return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sortedDataController numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sortedDataController numberOfRowsInSection:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    id<BNSortableData> identifier = [self.sortedDataController identifierForSection:section];
    
    if ([identifier isKindOfClass:[NSString class]]) {
        return (NSString *)identifier;
    } else if ([identifier isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)identifier stringValue];
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.sortedDataController removeObjectAtIndexPath:indexPath];
        [self.sortedDataController reload];
    }
}

#pragma mark - Sorted data controller delegate

- (void)sortedDataControllerDidReload:(BNSortedDataController *)controller committedUpdates:(BNTableViewUpdates *)tableViewUpdates {
    [self.tableView beginUpdates];
    
    [self.tableView deleteRowsAtIndexPaths:tableViewUpdates.deletedRowIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    for (NSIndexSet *indexSet in tableViewUpdates.deletedSectionIndexSets) {
        [self.tableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    for (NSIndexSet *indexSet in tableViewUpdates.addedSectionIndexSets) {
        [self.tableView insertSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    [self.tableView insertRowsAtIndexPaths:tableViewUpdates.addedRowIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.tableView endUpdates];
}

@end
