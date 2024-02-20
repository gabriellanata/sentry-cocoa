#import "SentryReplayEvent.h"
#import "SentryDateUtil.h"
#import "SentryId.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SentryReplayEvent

- (NSDictionary *)serialize
{
    NSMutableDictionary *result = [[super serialize] mutableCopy];

    NSMutableArray *trace_ids = [[NSMutableArray alloc] initWithCapacity:self.traceIds.count];

    for (SentryId *traceId in self.traceIds) {
        [trace_ids addObject:traceId.sentryIdString];
    }

    result[@"urls"] = self.urls;
    result[@"replay_start_timestamp"] =
        @([SentryDateUtil millisecondsSince1970:self.replayStartTimestamp]);
    result[@"trace_ids"] = trace_ids;
    result[@"replay_id"] = self.replayId.sentryIdString;
    result[@"segment_id"] = @(self.segmentId);
    result[@"replay_type"] = nameForSentryReplayType(self.replayType);

    return result;
}

@end

NS_ASSUME_NONNULL_END
