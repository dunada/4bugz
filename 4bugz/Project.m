//
//  Project.m
//  4bugz
//
//  Created by Eduardo Rodrigues on 3/22/13.
//  Copyright (c) 2013 Eduardo Rodrigues. All rights reserved.
//

#import "Project.h"

@implementation Project

@synthesize pk = _pk;
@synthesize title = _title;

- (id) init {
	if ((self = [super init])) {
		_saved = nil;
	}
	return self;
}

+ (NSString *) dataSource {
	return @"4bugz";
}

+ (NSString *) table {
	return @"Project";
}

+ (NSArray *) primaryKey {
	return [NSArray arrayWithObject: @"pk"];
}

+ (BOOL) isAutoIncremented {
	return NO;
}




@end
