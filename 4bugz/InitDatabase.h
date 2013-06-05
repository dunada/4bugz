//
//  InitDatabase.h
//  4bugz
//
//  Created by Eduardo Rodrigues on 3/23/13.
//  Copyright (c) 2013 Eduardo Rodrigues. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZIMSqlCreateTableStatement.h"
#import "ZIMDbConnection.h"
#import "ZIMDbConnectionPool.h"
#import "Project.h"

@interface InitDatabase : NSObject
+(void)initialize;
@end
