//
//  Project.h
//  4bugz
//
//  Created by Eduardo Rodrigues on 3/22/13.
//  Copyright (c) 2013 Eduardo Rodrigues. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZIMOrmModel.h"

@interface Project : ZIMOrmModel {
@protected
    NSNumber *_pk;
    NSString *_title;
}
@property (strong, nonatomic) NSNumber *pk;
@property (strong, nonatomic) NSString *title;

@end
