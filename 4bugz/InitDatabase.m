//
//  InitDatabase.m
//  4bugz
//
//  Created by Eduardo Rodrigues on 3/23/13.
//  Copyright (c) 2013 Eduardo Rodrigues. All rights reserved.
//

#import "InitDatabase.h"


@implementation InitDatabase
+(void)initialize{
    ZIMSqlCreateTableStatement *table;
    NSString *statement;
    NSArray *records;
    ZIMDbConnection *connection = [[ZIMDbConnectionPool sharedInstance] connection: @"4bugz"];
    records = [connection query: @"SELECT name FROM sqlite_master WHERE type='table' AND name='Ticket';"];

    
    if (records.count==0) {
        
        //Ticket
        table = [[ZIMSqlCreateTableStatement alloc] init];
        [table table: @"Ticket"];
        [table column: @"pk" type: ZIMSqlDataTypeInteger primaryKey:YES];
        [table column: @"ixCategory" type: ZIMSqlDataTypeInteger];
        [table column: @"ixProject" type: ZIMSqlDataTypeInteger];
        [table column: @"title" type: ZIMSqlDataTypeVarChar(100)];
        [table column: @"assignedTo" type: ZIMSqlDataTypeVarChar(100)];
        [table column: @"status" type: ZIMSqlDataTypeVarChar(100)];
        [table column: @"priority" type: ZIMSqlDataTypeVarChar(100)];
        [table column: @"backlog" type: ZIMSqlDataTypeVarChar(100)];
        statement = [table statement];
        NSLog(@"%@", statement);
        // Executes the SQL statement
        NSNumber *result = [ZIMDbConnection dataSource: @"4bugz" execute: statement];
        NSLog(@"Create Ticket table : %@",result);
    }
    
    records = [connection query: @"SELECT name FROM sqlite_master WHERE type='table' AND name='Project';"];
    if (records.count==0) {

        //Project
        table = [[ZIMSqlCreateTableStatement alloc] init];
        [table table: @"Project"];
        [table column: @"pk" type: ZIMSqlDataTypeInteger primaryKey:YES];
        [table column: @"title" type: ZIMSqlDataTypeVarChar(100)];
        statement = [table statement];
        NSLog(@"%@", statement);
        // Executes the SQL statement
        NSNumber *result = [ZIMDbConnection dataSource: @"4bugz" execute: statement];
        NSLog(@"Create Project table : %@",result);

        
    }
    
    records = [connection query: @"SELECT name FROM sqlite_master WHERE type='table' AND name='User';"];
    if (records.count==0) {
        
        //User
        table = [[ZIMSqlCreateTableStatement alloc] init];
        [table table: @"User"];
        [table column: @"pk" type: ZIMSqlDataTypeInteger primaryKey:YES];
        [table column: @"email" type: ZIMSqlDataTypeVarChar(100)];
        [table column: @"password" type: ZIMSqlDataTypeVarChar(100)];
        [table column: @"token" type: ZIMSqlDataTypeVarChar(100)];
        [table column: @"currentFilterDescription" type: ZIMSqlDataTypeVarChar(100)];
        [table column: @"apiUrl" type: ZIMSqlDataTypeVarChar(100)];
        [table column: @"logged" type: ZIMSqlDataTypeBoolean];
        statement = [table statement];
        NSLog(@"%@", statement);
        // Executes the SQL statement
        NSNumber *result = [ZIMDbConnection dataSource: @"4bugz" execute: statement];
        NSLog(@"Create User table : %@",result);
    }

    

}
@end
