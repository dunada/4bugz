//
//  ViewController.m
//  4bugz
//
//  Created by Eduardo Rodrigues on 3/23/13.
//  Copyright (c) 2013 Eduardo Rodrigues. All rights reserved.
//

#import "HomeController.h"



@interface HomeController ()

@end

@implementation HomeController

@synthesize tickets;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [tickets count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *projectName = [[tickets allKeys] objectAtIndex:section];
    return [[tickets objectForKey:projectName] count];

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
     return [[tickets allKeys] objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TicketTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TicketTableCell"];
    if (nil == cell){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TicketTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    }

    NSString *projectName = [[tickets allKeys] objectAtIndex:indexPath.section];
    Ticket *ticket =[[tickets objectForKey:projectName] objectAtIndex:[indexPath row]];
    
    [[cell titleLabel] setText:[ticket ixWithTitle]];
    [[cell priorityLabel] setText:[ticket backlogWithPriority]];
    [[cell assignedToLabel] setText:[ticket assignedTo]];
    [[cell iconImageView] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.gif",[ticket ixCategory]]]];
    return cell;
}

-(void)loadTickets
{
    ZIMOrmSelectStatement *select = [[ZIMOrmSelectStatement alloc] initWithModel: [Ticket class]];
    NSArray *records = [select query];
    Project *project;
    NSMutableArray *group;
    tickets = [[NSMutableDictionary alloc] init];
    if (records) {
        for (int i=0; i<records.count; i++) {
            project=[records[i] project];
            group=[tickets objectForKey:project.title];
            if(!group){
                group=[[NSMutableArray alloc] init];
                [tickets setObject:group forKey:project.title];
            }
            [group addObject:records[i]];

        }
    }
    NSString *title = [[User loggedUser] currentFilterDescription];
    if (title != (id)[NSNull null]) {
        self.title=title;
    }

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    [self loadTickets];
    
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    self.navigationItem.leftBarButtonItem = refreshButton;
    

}

- (void)refresh:(id)sender
{
    [activityIndicator startAnimating];
    [ProjectBusiness loadListProjectsFromXml:^{
        [TicketBusiness loadSearchFromXML:^{
            [self loadTickets];
            [ticketViewController reloadData];
            [activityIndicator stopAnimating];
        }];
    }];

    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showTicket"]) {
        NSIndexPath *indexPath = [ticketViewController indexPathForSelectedRow];
        //NSDate *object = _objects[indexPath.row];
        //[[segue destinationViewController] setDetailItem:object];
    }
}

@end
