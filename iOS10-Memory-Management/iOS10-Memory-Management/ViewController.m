//
//  ViewController.m
//  iOS10-Memory-Management
//
//  Created by Paul Solt on 12/18/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "ViewController.h"

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
}

- (void)dealloc {
	[_names release];
	_names = nil;
	
	
	[super dealloc]; // last statement to cleanup NSObject or subclass
}


@end
