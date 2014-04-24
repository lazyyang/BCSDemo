
#import "NSString+URLEncoding.h"

@implementation NSString(URLEncoding)
- (NSString *)urlEncodeString
{
    NSString *result = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, 
                (CFStringRef)self, 
                NULL, 
                (CFStringRef)@";/?:@&=$+{}<>,",
                kCFStringEncodingUTF8);
    return [result autorelease];
}
@end
