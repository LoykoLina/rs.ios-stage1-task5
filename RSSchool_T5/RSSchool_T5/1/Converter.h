#import <Foundation/Foundation.h>

extern NSString *KeyPhoneNumber;
extern NSString *KeyCountry;
extern NSString *KeyIndex;
extern NSString *KeySymbol;

@interface PNConverter : NSObject
- (NSDictionary*)converToPhoneNumberNextString:(NSString*)string;
- (NSArray*)getPnoneLengthAndCountry:(NSString*)str;
- (NSString*)getPhoneNumberFromString:(NSString*)str country:(NSString*)country PNCountryLength:(NSNumber*)length;
@end


