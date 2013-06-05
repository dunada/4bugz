//
//  ProjectBusiness.m
//  4bugz
//
//  Created by Eduardo Rodrigues on 3/23/13.
//  Copyright (c) 2013 Eduardo Rodrigues. All rights reserved.
//

#import "ProjectBusiness.h"


@implementation ProjectBusiness

+ (void)loadListProjectsFromXml:(void (^)(void))callback
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
            [connection execute: @"DELETE FROM Project"];
            [connection close];
            
            __block NSError *error = nil;
            
            TBXMLElement * projectsXMLElement = [TBXML childElementNamed:@"projects" parentElement:rootXMLElement error:&error];
            
            [TBXML iterateElementsForQuery:@"project" fromElement:projectsXMLElement withBlock:^(TBXMLElement *anElement) {
                TBXMLElement * ixProjectXMLElement = [TBXML childElementNamed:@"ixProject" parentElement:anElement error:&error];
                TBXMLElement * sProjectXMLElement = [TBXML childElementNamed:@"sProject" parentElement:anElement error:&error];
                
                NSString * sIxProject = [TBXML textForElement:ixProjectXMLElement];
                
                NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
                [f setNumberStyle:NSNumberFormatterDecimalStyle];
                NSNumber * ixProject = [f numberFromString:sIxProject];
                
                
                NSString * sProject = [TBXML textForElement:sProjectXMLElement];
                Project * project = [[Project alloc]init];
                [project setTitle:sProject];
                [project setPk:ixProject];
                [project save];
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
    TBXML *tbxml = [[TBXML alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"%@?cmd=listProjects&token=%@",user.apiUrl,user.token]]
                                      success:successBlock
                                      failure:failureBlock];
      
}


@end
