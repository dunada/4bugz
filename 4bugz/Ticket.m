//
//  Ticket.m
//  4bugz
//
//  Created by Eduardo Rodrigues on 3/23/13.
//  Copyright (c) 2013 Eduardo Rodrigues. All rights reserved.
//

#import "Ticket.h"

@implementation Ticket

@synthesize pk = _pk;
@synthesize ixCategory = _ixCategory;
@synthesize ixProject = _ixProject;
@synthesize title = _title;
@synthesize assignedTo = _assignedTo;
@synthesize status = _status;
@synthesize priority = _priority;
@synthesize backlog = _backlog;

- (Project *) project {
    return [self belongsTo: [Project class] foreignKey: [NSArray arrayWithObject: @"ixProject"]];
}

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
	return @"Ticket";
}

+ (NSArray *) primaryKey {
	return [NSArray arrayWithObject: @"pk"];
}

+ (BOOL) isAutoIncremented {
	return NO;
}

- (NSString *) ixWithTitle
{
    return [NSString stringWithFormat:@"%@ - %@", self.pk, self.title];
}
- (NSString *) backlogWithPriority
{
    if ([self.backlog length]>0) {
        return [NSString stringWithFormat:@"%@ - %@", self.backlog, self.priority];

    }else{
        return self.priority;
    }
}

@end
