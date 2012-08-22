//
//  Auth.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 22/08/12.
//
//

#import <Foundation/Foundation.h>
#import "Jastor.h"

typedef enum {
    CiviltyMr,
    CiviltyMme,
    CiviltyMlle
} Civilty;

typedef enum {
    MemberProfileLocalisationOwner,
    MemberProfileNomad,
    MemberProfileTeleworker,
    MemberProfileIndependant,
    MemberProfileStartup,
    MemberProfileCompany,
    MemberProfileStudent,
    MemberProfilePunctualUser,
    MemberProfileOther
} MemberProfile;

@interface Auth : Jastor

@property (nonatomic, copy) NSString*    token;
@property (nonatomic, copy) NSString*    email;
@property (nonatomic, copy) NSString*    firstName;
@property (nonatomic, copy) NSString*    lastName;
@property (nonatomic, copy) NSString*    birthDate;
@property (nonatomic, copy) NSString*    phoneNumber;
@property (nonatomic, copy) NSNumber*    profile;
@property (nonatomic, copy) NSNumber*    civility;
@property (nonatomic, copy) NSString*    avatar;
@property (nonatomic, copy) NSString*    description;
@property (nonatomic, copy) NSString*    city;
@property (nonatomic, copy) NSString*    postalCode;

@end
