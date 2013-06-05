//
//  TicketTableCell.h
//  4bugz
//
//  Created by Eduardo Rodrigues on 3/24/13.
//  Copyright (c) 2013 Eduardo Rodrigues. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TicketTableCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *priorityLabel;
@property (nonatomic, weak) IBOutlet UILabel *assignedToLabel;
@property (nonatomic, weak) IBOutlet UIImageView *iconImageView;


@end
