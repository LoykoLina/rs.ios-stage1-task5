#import "Converter.h"

// Do not change
NSString *KeyPhoneNumber = @"phoneNumber";
NSString *KeyCountry = @"country";
NSString *KeyIndex = @"index";
NSString *KeySymbol = @"symbol";

@implementation PNConverter
- (NSDictionary*)converToPhoneNumberNextString:(NSString*)string; {
    NSArray *countryAndPhoneLength = [self getPnoneLengthAndCountry:string];
    
    if ([countryAndPhoneLength count] == 0) {
        if ([string length] > 12) {
            if ([[string substringToIndex:1] isEqual:@"+"]) {
                return @{KeyPhoneNumber: [string substringWithRange:NSMakeRange(0, 13)],
                         KeyCountry: @""};
            }
            return @{KeyPhoneNumber: [NSString stringWithFormat:@"+%@", [string substringWithRange:NSMakeRange(0, 12)]],
                     KeyCountry: @""};
        }
        return @{KeyPhoneNumber: [NSString stringWithFormat:@"+%@", string],
                 KeyCountry: @""};
    }
    NSString *phoneNumber = [self getPhoneNumberFromString:string country:countryAndPhoneLength[0] PNCountryLength:countryAndPhoneLength[1]];
    return @{KeyPhoneNumber: phoneNumber,
             KeyCountry: countryAndPhoneLength[0]};
}

- (NSArray*)getPnoneLengthAndCountry:(NSString*)str {
    if ([[str substringToIndex:1] isEqual:@"7"]) {
        if ([str length] != 1 && [[str substringWithRange:NSMakeRange(1, 1)] isEqual:@"7"]) {
            return @[@"KZ", @10];
        } else {
            return @[@"RU", @10];
        }
    } else if ([str length] > 2) {
        NSInteger countryCode = [[str substringWithRange:NSMakeRange(0, 3)] integerValue];
        switch (countryCode) {
            case 373:
                return @[@"MD", @8];
                break;
            case 374:
                return @[@"AM", @8];
                break;
            case 375:
                return @[@"BY", @9];
                break;
            case 380:
                return @[@"UA", @9];
                break;
            case 992:
                return @[@"TJ", @9];
                break;
            case 993:
                return @[@"TM", @8];
                break;
            case 994:
                return @[@"AZ", @9];
                break;
            case 996:
                return @[@"KG", @9];
                break;
            case 998:
                return @[@"UZ", @9];
                break;
            default:
                break;
        }
    }
    return @[];
}

- (NSString*)getPhoneNumberFromString:(NSString*)str country:(NSString*)country PNCountryLength:(NSNumber*)length {
    NSMutableString *phoneNumber = [NSMutableString stringWithString:str];
    NSMutableArray *format = [NSMutableArray new];
    
    switch ([length integerValue]) {
        case 8:
            if ([phoneNumber length] <= 3) {
                break;
            }
            if ([phoneNumber length] > 11) {
                phoneNumber = [[phoneNumber substringWithRange:NSMakeRange(0, 11)] mutableCopy];
            }
            format = [NSMutableArray arrayWithArray: @[ @{KeyIndex: @3, KeySymbol: @" ("},
                                                        @{KeyIndex: @7, KeySymbol: @") "},
                                                        @{KeyIndex: @12, KeySymbol: @"-"}, ]];
            break;
        case 9:
            if ([phoneNumber length] <= 3) {
                break;
            }
            if ([phoneNumber length] > 12) {
                phoneNumber = [[phoneNumber substringWithRange:NSMakeRange(0, 12)] mutableCopy];
            }
            format = [NSMutableArray arrayWithArray: @[ @{KeyIndex: @3, KeySymbol: @" ("},
                                                        @{KeyIndex: @7, KeySymbol: @") "},
                                                        @{KeyIndex: @12, KeySymbol: @"-"},
                                                        @{KeyIndex: @15, KeySymbol: @"-"} ]];
            break;
        case 10:
            if ([phoneNumber length] == 1) {
                break;
            }
            if ([phoneNumber length] > 11) {
                phoneNumber = [[phoneNumber substringWithRange:NSMakeRange(0, 11)] mutableCopy];
            }
            format = [NSMutableArray arrayWithArray:  @[ @{KeyIndex: @1, KeySymbol: @" ("},
                                                         @{KeyIndex: @6, KeySymbol: @") "},
                                                         @{KeyIndex: @11, KeySymbol: @"-"},
                                                         @{KeyIndex: @14, KeySymbol: @"-"} ]];
            break;
        default:
            break;
    }
    for (NSDictionary *dic in format) {
        NSInteger index = [[dic objectForKey:KeyIndex] integerValue];
        if (index < [phoneNumber length]) {
            [phoneNumber insertString:[dic objectForKey:KeySymbol] atIndex:index];
        }
    }
    return [NSString stringWithFormat:@"+%@", phoneNumber];
}

@end
