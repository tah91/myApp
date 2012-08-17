//
//  SearchCriteria.h
//  myGreatApp
//
//  Created by Tahir Iftikhar on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum offerType{
    ot_freeArea,
    ot_buisnessLounge,
    ot_workstation,
    ot_desktop,
    ot_meetingRoom,
    ot_seminarRoom,
    ot_visioRoom
} offerTypes;

typedef enum localisationType{
    lt_wifiHotspot,
    lt_cafeRestaurant,
    lt_librairyMuseum,
    lt_internetCafe,
    lt_travelerLounge,
    lt_hotel,
    lt_telecentre,
    lt_businessLounge,
    lt_coworkingSpace,
    lt_corporateCentre,
    lt_privatePlace,
    lt_sharedOffice
} localisationTypes;

typedef enum orderBy{
    ob_rating,
    ob_distance, 
    ob_price
} orderBy;

typedef enum feature{
    f_access24,
    f_lunchClose,
    f_buisnessLounge,
    f_workstation,
    f_desktop,
    f_meetingRoom,
    f_visioRoom,
    f_seminarRoom,
    f_wifi_Free,
    f_parking,
    f_handicap,
    f_restauration,
    f_coffee,
    f_visio,
    f_concierge,
    f_secretariat,
    f_community,
    f_domiciliation,
    f_newspaper,
    f_computers,
    f_courier,
    f_printer,
    f_computerHelp,
    f_pressing,
    f_outlet,
    f_fastInternet,
    f_tV,
    f_safeStorage,
    f_roomService,
    f_archiving,
    f_relaxingArea,
    f_aC,
    f_ergonomicFurniture,
    f_room2_7,
    f_room7_20,
    f_room20_plus,
    f_room20_100,
    f_room100_250,
    f_room250_1000,
    f_room1000_plus,
    f_audio,
    f_projector,
    f_videoProj,
    f_paperboard,
    f_internet,
    f_phoneJack,
    f_drinks,
    f_accommodation,
    f_lighting,
    f_sound,
    f_catering,
    f_scene,
    f_micro,
    f_picturesque,
    f_welcoming,
    f_wifi_Not_Free,
    f_shower,
    f_room1_4,
    f_room5_10,
    f_room10_Plus,
    f_visioHD,
    f_telepresence,
    f_localisationOwner,
    f_freeArea,
    f_avoidMorning,
    f_avoidLunch,
    f_avoidAfternoom,
    f_avoidEvening,
    f_desktop10_25,
    f_desktop25_50,
    f_desktop50_100,
    f_desktop100Plus,
    f_equipped,
    f_availableNow,
    f_allInclusive,
    f_flexibleContract,
    f_notSectorial,
    f_coworkingVibe,
    f_openToAll,
    f_reservedToClients,
    f_phoneLine,
    f_kitchen,
    f_sharedMeetingRoom,
    f_lift,
    f_heater,
    f_architects,
    f_associative,
    f_artists,
    f_lawyers,
    f_businessDevelopers,
    f_commercial,
    f_communicationMedia,
    f_accountants,
    f_consultants,
    f_designers,
    f_developers,
    f_writers,
    f_contractors,
    f_independent,
    f_investors,
    f_journalists,
    f_photographers,
    f_nomads,
    
    //string features start from 1000, put bool features before this
    f_sector = 1000,
    f_minimalPeriod,
    f_forCardOwner,
    
    //number features start from 2000, put string features before this
    f_coffeePrice = 2000
} features;

@interface SearchCriteria : NSObject

@property (strong, nonatomic)   NSString* place;
@property (strong, nonatomic)   NSString* name;
@property (nonatomic)           NSNumber* latitude;
@property (nonatomic)           NSNumber* longitude;
@property (nonatomic)           NSNumber* neLat;
@property (nonatomic)           NSNumber* neLng;
@property (nonatomic)           NSNumber* swLat;
@property (nonatomic)           NSNumber* swLng;
@property (strong, nonatomic)   NSString* offerType;
@property (strong, nonatomic)   NSString* types;
@property (strong, nonatomic)   NSString* features;
@property (nonatomic)           NSNumber* boundary;
@property (nonatomic)           NSInteger orderBy;
@property (nonatomic)           NSInteger page;

@property (nonatomic) BOOL freePlace;
@property (nonatomic) BOOL desktop;
@property (nonatomic) BOOL meetingRoom;

-(id) initWithPlace:(NSString*)place;
-(NSMutableDictionary*) getParams;

@end