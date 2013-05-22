//
//  Food.m
//  FoodsDemo
//
//  Created by Bruce Ricketts on 4/30/13.
//  Copyright (c) 2013 Bruce Ricketts. All rights reserved.
//

#import "Food.h"

@implementation Food

- (NSComparisonResult)compare:(id<SMSortableData>)otherObject {
    Food *otherFood = (Food *)otherObject;
    return [self.name compare:otherFood.name];
}

+ (Food *)foodWithName:(NSString *)name category:(NSString *)category {
    Food *food = [[Food alloc] init];
    food.name = name;
    food.category = category;
    
    return food;
}

+ (NSArray *)sampleFoods {
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
    
    return @[ apple, orange, mango, pineapple, tomato, cucumber, greenBeans, milk, cheese, pork, bacon, burger, steak ];
}

@end
