//
//  Car.m
//  iOS9-MemoryManagement
//
//  Created by Paul Solt on 11/13/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "Car.h"

@implementation Car

- (instancetype)init
{
	self = [super init];
	if (self) {
		NSLog(@"Car.init");
	}
	return self;
}

- (void)dealloc {
	[super dealloc];
	NSLog(@"Car.dealloc");
}


@end
