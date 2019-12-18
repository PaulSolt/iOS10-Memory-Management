//
//  Person.m
//  iOS9-MemoryManagement
//
//  Created by Paul Solt on 11/13/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "Person.h"
#import "Car.h"

@implementation Person

- (instancetype)initWithCar:(Car *)car {
	self = [super init];
	if (self) {
		NSLog(@"Person.init");
		_car = [car retain];
	}
	return self;
}

- (void)dealloc {
	[_car release]; // car is cleaned up immediately if retain count == 0
	_car = nil;
	NSLog(@"Person.dealloc");
	[super dealloc];
}


- (void)setCar:(Car *)car {
	[_car release];
	_car = [car retain];
}

@end
