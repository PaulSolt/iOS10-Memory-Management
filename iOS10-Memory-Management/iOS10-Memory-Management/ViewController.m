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
	NSMutableArray *names = [[NSMutableArray alloc] init]; // names: 1

	for (int i = 0; i < inputArray.count; i++) {
		NSString *name = [[NSString alloc] initWithFormat:@"%@", inputArray[i]]; // name: 1
		
		[names addObject:name]; // name: 2
		[name release];
	}
	
	[names release]; // names: 0 (array is cleaned up)
}


@end
