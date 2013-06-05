//
//  CaseBusiness.h
//  4bugz
//
//  Created by Eduardo Rodrigues on 3/23/13.
//  Copyright (c) 2013 Eduardo Rodrigues. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"
#import "TBXML+HTTP.h"
#import "Ticket.h"
#import "User.h"
#import "ZIMDbConnection.h"

@interface TicketBusiness : NSObject
+ (void) loadSearchFromXML:(void (^)(void))callback;
@end
