//
//  CaseBusiness.m
//  4bugz
//
//  Created by Eduardo Rodrigues on 3/23/13.
//  Copyright (c) 2013 Eduardo Rodrigues. All rights reserved.
//

#import "TicketBusiness.h"


@implementation TicketBusiness

+ (void) loadSearchFromXML:(void (^)(void))callback
{
    User *user=[User loggedUser];
    // Create a success block to be called when the asyn request completes
    TBXMLSuccessBlock successBlock = ^(TBXML *tbxmlDocument) {
        NSLog(@"PROCESSING ASYNC CALLBACK");
        
        // If TBXML found a root node, process element and iterate all children
        TBXMLElement * rootXMLElement = tbxmlDocument.rootXMLElement;
        if (rootXMLElement){
            //Delete tickets
            ZIMDbConnection *connection = [[ZIMDbConnection alloc] initWithDataSource: @"4bugz"];
            [connection execute: @"DELETE FROM Ticket"];
            [connection close];
            
            __block NSError *error = nil;
            
            TBXMLElement * descriptionXMLElement = [TBXML childElementNamed:@"description" parentElement:rootXMLElement error:&error];
            NSString * description = [TBXML textForElement:descriptionXMLElement];
            [user setCurrentFilterDescription:description];
            [user save];

            
            TBXMLElement * casesXMLElement = [TBXML childElementNamed:@"cases" parentElement:rootXMLElement error:&error];
            
            [TBXML iterateElementsForQuery:@"case" fromElement:casesXMLElement withBlock:^(TBXMLElement *anElement) {
                
                TBXMLElement * ixBugXMLElement = [TBXML childElementNamed:@"ixBug" parentElement:anElement error:&error];
                TBXMLElement * sTitleXMLElement = [TBXML childElementNamed:@"sTitle" parentElement:anElement error:&error];
                TBXMLElement * sPersonAssignedToXMLElement = [TBXML childElementNamed:@"sPersonAssignedTo" parentElement:anElement error:&error];
                TBXMLElement * sStatusXMLElement = [TBXML childElementNamed:@"sStatus" parentElement:anElement error:&error];
                TBXMLElement * ixCategoryXMLElement = [TBXML childElementNamed:@"ixCategory" parentElement:anElement error:&error];
                TBXMLElement * ixProjectXMLElement = [TBXML childElementNamed:@"ixProject" parentElement:anElement error:&error];
                TBXMLElement * backlogXMLElement = [TBXML childElementNamed:@"backlog" parentElement:anElement error:&error];
                TBXMLElement * sPriorityXMLElement = [TBXML childElementNamed:@"sPriority" parentElement:anElement error:&error];
                
                NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
                [f setNumberStyle:NSNumberFormatterDecimalStyle];
                
                NSNumber * ixBug = [f numberFromString:[TBXML textForElement:ixBugXMLElement]];
                NSString * sTitle = [TBXML textForElement:sTitleXMLElement];
                NSString * sPersonAssignedTo = [TBXML textForElement:sPersonAssignedToXMLElement];
                NSString * sStatus = [TBXML textForElement:sStatusXMLElement];
                NSNumber * ixCategory = [f numberFromString:[TBXML textForElement:ixCategoryXMLElement]];
                NSNumber * ixProject = [f numberFromString:[TBXML textForElement:ixProjectXMLElement]];
                NSString * backlog = [TBXML textForElement:backlogXMLElement];
                NSString * sPriority = [TBXML textForElement:sPriorityXMLElement];
                
                
                
                Ticket * ticket = [[Ticket alloc]init];
                [ticket setPk:ixBug];
                [ticket setTitle:sTitle];
                [ticket setAssignedTo:sPersonAssignedTo];
                [ticket setStatus:sStatus];
                [ticket setIxCategory:ixCategory];
                [ticket setBacklog:backlog];
                [ticket setPriority:sPriority];
                [ticket setIxProject:ixProject];
                [ticket save];
                
            }];
           
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            callback();
        });
        
    };
    
    // Create a failure block that gets called if something goes wrong
    TBXMLFailureBlock failureBlock = ^(TBXML *tbxmlDocument, NSError * error) {
        NSLog(@"Error! %@ %@", [error localizedDescription], [error userInfo]);
    };
    
	// Initialize TBXML with the URL of an XML doc. TBXML asynchronously loads and parses the file.
	TBXML *tbxml = [[TBXML alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"%@?cmd=search&cols=ixCategory,ixProject,ixBug,sTitle,sPersonAssignedTo,sStatus,sPriority,backlog&token=%@",user.apiUrl,user.token]]
                                      success:successBlock
                                      failure:failureBlock];

}

@end
