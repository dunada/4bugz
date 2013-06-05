//
//  User.h
//  4bugz
//
//  Created by Eduardo Rodrigues on 3/23/13.
//  Copyright (c) 2013 Eduardo Rodrigues. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZIMOrmSdk.h"

@interface User : ZIMOrmModel{
@protected
    NSNumber *_pk;
    NSString *_email;
    NSString *_password;
    NSString *_token;
    NSString *_currentFilterDescription;
    NSString *_apiUrl;
    NSNumber *_logged;
    
}
@property (strong, nonatomic) NSNumber *pk;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSString *currentFilterDescription;
@property (strong, nonatomic) NSString *apiUrl;
@property (strong, nonatomic) NSNumber *logged;

- (void) initLoggedUser;

+(User*)loggedUser;


@end
