//
//  User.m
//  4bugz
//
//  Created by Eduardo Rodrigues on 3/23/13.
//  Copyright (c) 2013 Eduardo Rodrigues. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize pk = _pk;
@synthesize email = _email;
@synthesize password = _password;
@synthesize token = _token;
@synthesize currentFilterDescription = _currentFilterDescription;
@synthesize apiUrl = _apiUrl;
@synthesize logged = _logged;

static User* _loggedUser = nil;


- (id) init {
	if ((self = [super init])) {
		_saved = nil;
	}
	return self;
}

- (void) initLoggedUser {
    ZIMDbConnection *connection = [[ZIMDbConnection alloc] initWithDataSource: @"4bugz"];
    NSArray *records = [connection query: @"SELECT * FROM User where logged=1;"];
    
    if ([records count]>0) {
        User *user = [[User alloc] init];
        [user setEmail:[[records objectAtIndex:0] objectForKey:@"email"]];
        [user setToken:[[records objectAtIndex:0] objectForKey:@"token"]];
        [user setCurrentFilterDescription:[[records objectAtIndex:0] objectForKey:@"currentFilterDescription"]];
        [user setApiUrl:[[records objectAtIndex:0] objectForKey:@"apiUrl"]];

        _loggedUser=user;
    }
	[connection close];

}

+ (NSString *) dataSource {
	return @"4bugz";
}

+ (NSString *) table {
	return @"User";
}

+ (NSArray *) primaryKey {
	return [NSArray arrayWithObject: @"pk"];
}

+ (BOOL) isAutoIncremented {
	return YES;
}

+(User*)loggedUser
{
	@synchronized([User class])
	{
		if (!_loggedUser){
			[[self alloc] initLoggedUser];
        }
        
		return _loggedUser;
	}
    
	return nil;
}


@end
