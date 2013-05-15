BNSortedDataController
======================

BNSortedDataController is a lighter take on NSFetchedResultsController that's more centered on displaying and organizing content than controlling it.  It's designed to have a very friendly interface, and help cut down the amount of code we have to write to get a table view working.

BNSortedDataController is centered on practically organizing and displaying content in a `UITableView`.  Specifically, we can easily construct a Contacts app-style table view, where data is automatically divided up into different sections and rows are sorted logically within their sections.

Installation
============

Follow Apple's [Using Static Libraries in iOS][http://developer.apple.com/library/ios/#technotes/iOSStaticLibraries/Articles/configuration.html%23/apple_ref/doc/uid/TP40012554-CH3-SW2] guide on how to import BNSortedDataController into your project.

Demo
====

Let's explore a bit by making a simple table view controller that sorts Food by their category, and displays their name.

Model
-----

First, we build our `Food` model, a subclass of `NSObject`.  Foods need just names and categories, and thus we start our class's `@interface` as follows:

    @interface Food : NSObject
    @property (weak, nonatomic)NSString *name;
    @property (weak, nonatomic)NSString *category;

    + (Food *)foodWithName:(NSString *)name category:(NSString *)category;
    + (NSArray *)sampleFoods;

    @end

The two class methods here are to help us generate sample data for `BNSortedDataController` to manage.  Here's our corresponding `@implementation` of `Food`:

    @implementation Food
    
    + (Food *)foodWithName:(NSString *)name category:(NSString *)category {
        Food *food = [[Food alloc] init];
        food.name = name;
        food.category = category;
        
        return food;
    }
    
    + (NSArray *)sampleFoods {
        Food *milk = [Food foodWithName:@"Milk" category:@"Dairy"];
        Food *cheese = [Food foodWithName:@"Cheese" category:@"Dairy"];
        Food *pork = [Food foodWithName:@"Pork" category:@"Meats"];
        ...
        
        return @[ milk, cheese, pork, ... ];
    }
    
    @end

As you can see, it's very straightforward, nothing special going on here.  Obviously, you can create your sample data any way you want, but for the purposes of this demo, we'll go with this method.

OK, now we need to prepare our model to be organized into a table.  Specifically, we need to implement the `<BNSortableData>` protocol, which looks like this:

    @protocol BNSortableData <NSObject>
    - (NSComparisonResult)compare:(id<BNSortableData>)otherObject;
    - (id)valueForKey:(NSString *)key;
    @end

The first method is one that `BNSortedDataController` uses to sort rows in each section.  It's return type, `NSComparisonResult`, is an enumeration with three values: `NSOrderedAscending`, `NSOrderedSame`, and `NSOrderedDescending`.  We return the value that represents the correct order of the receiver and `otherObject`.  For example, we return `NSOrderedAscending` if this Food (self)'s name comes before the other Food (otherObject)'s name alphabetically.  However, many of Apple's data types (NSString, NSDate, NSNumber) respond to `-compare:`, so we can simply "forward" our implementation down to `Food`'s name property, and after updating our model's interface to conform to the `<BNSortableData>` protocol,

    #import "BNSortedDataController/BNSortableData.h"
    
    @interface Food : NSObject <BNSortableData>
    ...

...our implementation of `-compare:` is really quite simple:

    - (NSComparisonResult)compare:(id<BNSortableData>)otherObject {
        Food *otherFood = (Food *)otherObject;
        return [self.name compare:otherFood.name];
    }

The other method required by this protocol is a simple KVC method, `-valueForKey:`.  Fortunately, `NSObject` implements this for us, so we don't need to worry about it.  This means we're done editing our model, and can move on to setting up our table view controller.

Table View Controller
---------------------

The easiest way to set up a table is to subclass `BNSortedTableViewController`, which subclasses UITableViewController.  This class provides some handy default implementations of a couple of `UITableViewDataSource` methods, as well as some more stuff, which we'll cover later.

Our view controller, which we call `FoodsViewController`, has a dead simple `@interface`:

    #import "BNSortedDataController/BNSortedTableViewController.h"
    
    @interface FoodsViewController : BNSortedTableViewController
    @end

In our `@implementation`, we need to implement a couple of methods.  First, our designated initializer (`initWithStyle:` or `initWithNibName:bundle:`).  All we need to do here is give our sorted data controller (which `BNSortedTableViewController` provides and initializes for us) some objects and tell it how we want our data sectioned:

    - (id)initWith...
    {
        self = [super initWith...];
        if (self) {
            self.sortedDataController.objects = [Food sampleFoods];
            self.sortedDataController.sortKey = @"category";
        }
        return self;
    }

The property `sortKey` determines how objects will be sectioned.  In our app, we have set this value to `@"category"`, which means our table will group items into the same section if they have the same category name.

Believe it or not, we're almost done.  Our superclass, `BNSortedTableViewController`, implements `numberOfSectionsInTableView:`, `tableView:numberOfRowsInSection:`, and `tableView:titleForHeaderInSection:` using a few simple calls from our sorted data controller.  Thus, the only method left to implement to get our table displayed is `tableView:cellForRowAtIndexPath:`.  This is quite simple:

    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        // Cell setup and reuse
        
        Food *food = [self.sortedDataController objectAtIndexPath:indexPath];
        cell.textLabel.text = food.name;
        
        return cell;
    }

`BNSortedDataController` provides us a handy instance method, `-objectAtIndexPath:` that gives us direct access to the Food that should show up at our provided index path...and that's it!  We're done.

Features!
=========

One of the coolest features of `BNSortedDataController` is dynamic table updates.  For instance, if we want to enable swipe-to-delete for our table from the demo, all we need to do is add these three lines of code to our table view controller's implementation:

    - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
        return YES;
    }

`BNSortedTableViewController` implements `tableView:commitEditingStyle:forRowAtIndexPath:`, removes the necessary object from storage, and deletes the row from the table with animation.

`BNSortedDataController` has a delegate protocol also, which currently only has one (optional) method:

    - (void)sortedDataController:(BNSortedDataController *)controller didCommitUpdates:(BNTableViewUpdates *)tableViewUpdates;

`BNSortedTableViewController` conforms to this protocol and uses the above method to assist with dynamic updates.  We can override it in our table for more custom work.  (`BNTableViewUpdates` is a simple container object that tells us what rows and sections have been added and deleted.)