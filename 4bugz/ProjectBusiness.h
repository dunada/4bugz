//
//  ProjectBusiness.h
//  4bugz
//
//  Created by Eduardo Rodrigues on 3/23/13.
//  Copyright (c) 2013 Eduardo Rodrigues. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"
#import "TBXML+HTTP.h"
#import "Project.h"
#import "User.h"
#import "ZIMDbConnection.h"


@interface ProjectBusiness : NSObject
+ (void) loadListProjectsFromXml:(void (^)(void))callback;

@end
