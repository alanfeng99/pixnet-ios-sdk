#import "Expecta.h"
#import "Specta.h"
#import "Nocilla.h"
#import "PIXNETSDK.h"

SpecBegin(ErrorDescription)
        beforeAll(^{
            [[LSNocilla sharedInstance] start];
        });
        afterEach(^{
            [[LSNocilla sharedInstance] clearStubs];
        });
        afterAll(^{
            [[LSNocilla sharedInstance] stop];
        });
        describe(@"test1", ^{
            it(@"should return error", ^AsyncBlock{
                stubRequest(@"GET", @"https://emma.pixnet.cc/mainpage/blog/categories/hot/0?page=1&count=10&format=json").
                        andReturn(401).
                        withBody(@"{\"error\":\"1\", \"code\":\"1302\"}");

                [[PIXNETSDK new] getMainpageBlogCategoriesWithCategoryID:@"0" articleType:PIXMainpageTypeHot page:1 perPage:10 completion:^(BOOL succeed, id result, NSError *error) {
                    NSString *string = error.userInfo[@"NSLocalizedDescription"];
                    NSDictionary *errorDictionary = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
                    NSError *transferedError = [NSError PIXErrorWithServerResponse:errorDictionary];

                    done();
                }];
            });
        });

SpecEnd