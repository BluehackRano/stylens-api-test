#import <Foundation/Foundation.h>
#import "SWGObject.h"

/**
* style-api
* This is a API document for Stylens Service
*
* OpenAPI spec version: 0.0.1
* Contact: master@bluehack.net
*
* NOTE: This class is auto generated by the swagger code generator program.
* https://github.com/swagger-api/swagger-codegen.git
* Do not edit the class manually.
*/




@protocol SWGProduct
@end

@interface SWGProduct : SWGObject


@property(nonatomic) NSString* _id;

@property(nonatomic) NSString* name;

@property(nonatomic) NSString* hostCode;

@property(nonatomic) NSString* hostUrl;

@property(nonatomic) NSString* hostName;

@property(nonatomic) NSArray<NSString*>* tags;

@property(nonatomic) NSString* classCode;

@property(nonatomic) NSNumber* price;

@property(nonatomic) NSString* currencyUnit;

@property(nonatomic) NSString* productUrl;

@property(nonatomic) NSString* productNo;

@property(nonatomic) NSString* nation;
/* image url [optional]
 */
@property(nonatomic) NSString* mainImage;
/* Mobile full size of image url [optional]
 */
@property(nonatomic) NSString* mainImageMobileFull;
/* Mobile thumbnail size of image url [optional]
 */
@property(nonatomic) NSString* mainImageMobileThumb;

@property(nonatomic) NSArray<NSString*>* sizes;

@property(nonatomic) NSNumber* discountRate;

@property(nonatomic) NSString* version;

@end
