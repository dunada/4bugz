//
//  Ticket.h
//  4bugz
//
//  Created by Eduardo Rodrigues on 3/23/13.
//  Copyright (c) 2013 Eduardo Rodrigues. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZIMOrmModel.h"
#import "Project.h"

@interface Ticket : ZIMOrmModel{
@protected
    NSNumber *_pk;
    NSNumber *_ixCategory;
    NSNumber *_ixProject;
    NSString *_title;
    NSString *_assignedTo;
    NSString *_status;
    NSString *_priority;
    NSString *_backlog;
}
@property (strong, nonatomic) NSNumber *pk;
@property (strong, nonatomic) NSNumber *ixCategory;
@property (strong, nonatomic) NSNumber *ixProject;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *assignedTo;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *priority;
@property (strong, nonatomic) NSString *backlog;

- (Project *) project;
- (NSString *) ixWithTitle;
- (NSString *) backlogWithPriority;

@end
