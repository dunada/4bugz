//
//  TicketTableCell.m
//  4bugz
//
//  Created by Eduardo Rodrigues on 3/24/13.
//  Copyright (c) 2013 Eduardo Rodrigues. All rights reserved.
//

#import "TicketTableCell.h"

@implementation TicketTableCell

@synthesize titleLabel = _titleLabel;
@synthesize priorityLabel = _priorityLabel;
@synthesize assignedToLabel = _assignedToLabel;
@synthesize iconImageView = _iconImageView;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
