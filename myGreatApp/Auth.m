//
//  Auth.m
//  myGreatApp
//
//  Created by Tahir Iftikhar on 22/08/12.
//
//

#import "Auth.h"

@implementation Auth

@synthesize token,email,firstName,lastName,birthDate,phoneNumber,profile,civility,avatar,description;

- (void)encodeWithCoder:(NSCoder *)encoder
{
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.token forKey:@"token"];
    [encoder encodeObject:self.email forKey:@"email"];
    [encoder encodeObject:self.firstName forKey:@"firstName"];
    [encoder encodeObject:self.lastName forKey:@"lastName"];
    [encoder encodeObject:self.birthDate forKey:@"birthDate"];
    [encoder encodeObject:self.phoneNumber forKey:@"phoneNumber"];
    [encoder encodeObject:self.profile forKey:@"profile"];
    [encoder encodeObject:self.civility forKey:@"civility"];
    [encoder encodeObject:self.avatar forKey:@"avatar"];
    [encoder encodeObject:self.description forKey:@"description"];
    [encoder encodeObject:self.city forKey:@"city"];
    [encoder encodeObject:self.postalCode forKey:@"postalCode"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if((self = [super init])) {
        //decode properties, other class vars
        self.token = [decoder decodeObjectForKey:@"token"];
        self.email = [decoder decodeObjectForKey:@"email"];
        self.firstName = [decoder decodeObjectForKey:@"firstName"];
        self.lastName = [decoder decodeObjectForKey:@"lastName"];
        self.birthDate = [decoder decodeObjectForKey:@"birthDate"];
        self.phoneNumber = [decoder decodeObjectForKey:@"phoneNumber"];
        self.profile = [decoder decodeObjectForKey:@"profile"];
        self.civility = [decoder decodeObjectForKey:@"civility"];
        self.avatar = [decoder decodeObjectForKey:@"avatar"];
        self.description = [decoder decodeObjectForKey:@"description"];
        self.city = [decoder decodeObjectForKey:@"city"];
        self.postalCode = [decoder decodeObjectForKey:@"postalCode"];
    }
    return self;
}

@end
