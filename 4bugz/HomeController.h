//
//  ViewController.h
//  4bugz
//
//  Created by Eduardo Rodrigues on 3/23/13.
//  Copyright (c) 2013 Eduardo Rodrigues. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZIMOrmSdk.h"
#import "Ticket.h"
#import "User.h"
#import "Project.h"
#import "TicketBusiness.h"
#import "ProjectBusiness.h"
#import "TicketTableCell.h"

@interface HomeController : UIViewController <UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITableView *ticketViewController;
    __weak IBOutlet UIActivityIndicatorView *activityIndicator;
}
//Temp dictionary it needs to load from listCategories service


@property (nonatomic,strong) NSMutableDictionary *tickets;

-(void)loadTickets;


@end
