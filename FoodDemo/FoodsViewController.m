//
//  FoodsViewController.m
//  BNSortedDataController
//
//  Created by Bruce Ricketts on 4/30/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import "FoodsViewController.h"
#import "BNSortedDataController.h"
#import "Food.h"
#import "Category.h"

@interface FoodsViewController ()
@property (strong, nonatomic)BNSortedDataController *sortedDataController;
@end

@implementation FoodsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        _sortedDataController = [[BNSortedDataController alloc] init];
        
        Category *fruits = [Category categoryWithName:@"Fruits"];
        Category *vegetables = [Category categoryWithName:@"Vegetables"];
        Category *dairy = [Category categoryWithName:@"Dairy"];
        Category *meats = [Category categoryWithName:@"Meats"];
        
        Food *apple = [Food foodWithName:@"Apple" category:fruits];
        Food *orange = [Food foodWithName:@"Orange" category:fruits];
        Food *mango = [Food foodWithName:@"Mango" category:fruits];
        Food *pineapple = [Food foodWithName:@"Pineapple" category:fruits];
        
        Food *tomato = [Food foodWithName:@"Tomato" category:vegetables];
        Food *cucumber = [Food foodWithName:@"Cucumber" category:vegetables];
        Food *greenBeans = [Food foodWithName:@"Green Beans" category:vegetables];
        
        Food *milk = [Food foodWithName:@"Milk" category:dairy];
        Food *cheese = [Food foodWithName:@"Cheese" category:dairy];
        
        Food *pork = [Food foodWithName:@"Pork" category:meats];
        Food *bacon = [Food foodWithName:@"Bacon" category:meats];
        Food *burger = [Food foodWithName:@"Burger" category:meats];
        Food *steak = [Food foodWithName:@"Steak" category:meats];
        
        self.sortedDataController.objects = @[ apple, orange, mango, pineapple, tomato, cucumber, greenBeans, milk, cheese, pork, bacon, burger, steak ];
        self.sortedDataController.sortKey = @"category";
        
        self.title = @"Foods";
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
    Category *category = [self.sortedDataController identifierForSection:section];
    return category.name;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Food *food = [self.sortedDataController objectAtIndexPath:indexPath];
    cell.textLabel.text = food.name;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
