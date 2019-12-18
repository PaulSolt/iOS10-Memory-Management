//
//  ViewController.m
//  iOS10-Memory-Management
//
//  Created by Paul Solt on 12/18/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Car.h"

@interface ViewController ()

@property (retain) NSMutableArray *names;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];



	// alloc = retain
	NSString *jsonString = [[NSString alloc] initWithFormat:@"{ \"name\" : \"Paul\" }"]; // retainCount = 1
	
	NSString *alias = [jsonString retain]; // retainCount = 2
	
	[alias release]; // retainCount = 1
	alias = nil; // Don't accidentally use a deallocated reference

	printf("json: %s\n", jsonString.UTF8String);

	[jsonString release];

	// Rule: All collection classes will retain on adding, and release on removing
	
	NSArray *inputArray = @[@"Paul", @"Isaac", @"John", @"Jesse"];

	// Manual Reference Counting = MRC = ownership
	_names = [[NSMutableArray alloc] init]; // names: 1
	// NOTE: self.name = ...;  will do a retain to establish ownership if we use the (retain) property attribute
	// typically you'd want to set the variable to the instance variable in an initializer, so you don't get a double
	// retain count

	for (int i = 0; i < inputArray.count; i++) {
		NSString *name = [[NSString alloc] initWithFormat:@"%@", inputArray[i]]; // name: 1
		
		[self.names addObject:name]; // name: 2
		[name release];
	}
	
//	[self.names release]; // names: 0 (array is cleaned up)
	
	NSDate *today = [NSDate date]; // autoreleased object
	printf("%s\n", today.description.UTF8String);
	
	Car *honda = [Car car]; // autoreleased object
	
	NSLog(@"honda: %@", honda);
	
	Person *bob = [[[Person alloc] initWithCar:honda] autorelease];
	
	NSLog(@"Bob: %@", bob);
	
	
	// Is the object autoreleased? Why?

	NSString *name = [NSString stringWithFormat:@"%@ %@", @"John", @"Miller"];
	// autoreleased
	
	NSDate *today1 = [NSDate date];
	// autoreleased
	
	NSDate *now = [NSDate new];
	// retained (not autoreleased)
	
	NSDate *tomorrow2 = [NSDate dateWithTimeIntervalSinceNow:60*60*24];
	// autoreleased
	
	NSDate *nextTomorrow = [tomorrow2 copy]; // retain: 1
	// not autoreleased
	
	NSArray *words = [@"This sentence is the bomb" componentsSeparatedByString:@" "];
	// autoreleased
	
	NSString *idea = [[NSString alloc] initWithString:@"Hello Ideas"];
	// not autoreleased
	
	Car *redCar = [Car car];
	// autoreleased
	
	NSString *idea2 = [[[NSString alloc] initWithString:@"Hello Ideas"] autorelease];
	// autoreleased
	
	NSString *idea3 = [[NSString alloc] initWithString:@"Hello Ideas"];
	// not autoreleased
	[idea3 autorelease];
	// autoreleased
	
	
//	[nextTomorrow release];
//	NSLog(@"now: %@", now);
//	[now release];
	
	Car *subaru = [[Car alloc] init];
	Person *sue = [[Person alloc] initWithCar:subaru];
	[subaru release]; // transfered ownership to the car
	
//	[sue release];	// bug if we release early and then try to use it (Use a sanitizer to check prevent these issues)
	
	sue.car = [[[Car alloc] init] autorelease];
	NSLog(@"Sue: %@", sue.car);
	
	// [sue release]; // bug to not release memory before we leave this function

}	// end of scope, autoreleased objects that are not retained will get cleaned up after this point

- (void)dealloc {
	[_names release];
	_names = nil;
	
	
	[super dealloc]; // last statement to cleanup NSObject or subclass
}


@end
