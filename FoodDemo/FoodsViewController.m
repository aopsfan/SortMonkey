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

@implementation FoodsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {        
        Food *apple = [Food foodWithName:@"Apple" category:@"Fruits"];
        Food *orange = [Food foodWithName:@"Orange" category:@"Fruits"];
        Food *mango = [Food foodWithName:@"Mango" category:@"Fruits"];
        Food *pineapple = [Food foodWithName:@"Pineapple" category:@"Fruits"];
        
        Food *tomato = [Food foodWithName:@"Tomato" category:@"Vegetables"];
        Food *cucumber = [Food foodWithName:@"Cucumber" category:@"Vegetables"];
        Food *greenBeans = [Food foodWithName:@"Green Beans" category:@"Vegetables"];
        
        Food *milk = [Food foodWithName:@"Milk" category:@"Dairy"];
        Food *cheese = [Food foodWithName:@"Cheese" category:@"Dairy"];
        
        Food *pork = [Food foodWithName:@"Pork" category:@"Meats"];
        Food *bacon = [Food foodWithName:@"Bacon" category:@"Meats"];
        Food *burger = [Food foodWithName:@"Burger" category:@"Meats"];
        Food *steak = [Food foodWithName:@"Steak" category:@"Meats"];
        
        self.sortedDataController.objects = @[ apple, orange, mango, pineapple, tomato, cucumber, greenBeans, milk, cheese, pork, bacon, burger, steak ];
        self.sortedDataController.sortKey = @"category";
        
        self.title = @"Foods";
    }
    return self;
}

#pragma mark - Table view data source

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
