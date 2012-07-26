### Steps to reproduce

``` shell
$ gem install bundler
```

``` shell
$ cd restkit_arity_bug/server
$ bundle install
$ ./server.rb
== Sinatra/1.3.2 has taken the stage on 4567 for development with backup from Thin
>> Thin web server (v1.4.1 codename Chromeo)
>> Maximum connections set to 1024
>> Listening on 0.0.0.0:4567, CTRL+C to stop
```

...in another shell...

``` shell
$ cd restkit_arity_bug
$ bundle install
$ rake
     Build ./build/iPhoneSimulator-5.1-Development
     Build vendor/Pods
Build settings from command line:
    ARCHS = i386
    CONFIGURATION_BUILD_DIR = build
    SDKROOT = iphonesimulator5.1

=== BUILD NATIVE TARGET Pods OF PROJECT Pods WITH CONFIGURATION Release ===
Check dependencies
# ...TONS of output...
  Simulate ./build/iPhoneSimulator-5.1-Development/restkit_arity_bug.app
2012-07-26 14:54:47.085 restkit_arity_bug[50472:c07] D restkit.network:RKClient.m:279:-[RKClient reachabilityObserverDidChange:] Reachability observer changed for client <RKClient: 0xa8a07f0>, suspending queue <RKRequestQueue: 0xa8a0ba0 name=(null) suspended=YES requestCount=0 loadingCount=0/5> until reachability to host 'localhost' can be determined
XXX: Loading objects...
XXX: Objects being loaded...
2012-07-26 14:54:47.089 restkit_arity_bug[50472:c07] D restkit.network:RKClient.m:409:-[RKClient reachabilityWasDetermined:] Reachability to host 'localhost' determined for client <RKClient: 0xa8a07f0>, unsuspending queue <RKRequestQueue: 0xa8a0ba0 name=(null) suspended=YES requestCount=1 loadingCount=0/5>
2012-07-26 14:54:47.091 restkit_arity_bug[50472:c07] D restkit.network:RKRequest.m:436:-[RKRequest fireAsynchronousRequest] Sending asynchronous GET request to URL http://localhost:4567/coffee_shops.
2012-07-26 14:54:47.091 restkit_arity_bug[50472:c07] T restkit.network:RKRequest.m:402:-[RKRequest prepareURLRequest] Prepared GET URLRequest '<NSMutableURLRequest http://localhost:4567/coffee_shops>'. HTTP Headers: {
    Accept = "application/json";
    "Content-Length" = 0;
}. HTTP Body: .
2012-07-26 14:54:47.096 restkit_arity_bug[50472:c07] D restkit.network:RKResponse.m:188:-[RKResponse connection:willSendRequest:redirectResponse:] Proceeding with request to <NSURLRequest http://localhost:4567/coffee_shops>
(main)> 2012-07-26 14:54:47.301 restkit_arity_bug[50472:c07] D restkit.network:RKResponse.m:207:-[RKResponse connection:didReceiveResponse:] NSHTTPURLResponse Status Code: 200
2012-07-26 14:54:47.302 restkit_arity_bug[50472:c07] D restkit.network:RKResponse.m:208:-[RKResponse connection:didReceiveResponse:] Headers: {
    Connection = "keep-alive";
    "Content-Length" = 97;
    "Content-Type" = "application/json;charset=utf-8";
    Server = "thin 1.4.1 codename Chromeo";
    "X-Frame-Options" = sameorigin;
    "X-XSS-Protection" = "1; mode=block";
}
2012-07-26 14:54:47.302 restkit_arity_bug[50472:c07] T restkit.network:RKResponse.m:218:-[RKResponse connectionDidFinishLoading:] Read response body: {"coffee_shops":[{"id":1,"latitude":"20.0","longitude":"-122.4075","name":"Foo","shot_count":0}]}
2012-07-26 14:54:47.305 restkit_arity_bug[50472:1803] D restkit.network:RKObjectLoader.m:268:__47-[RKObjectLoader performMappingInDispatchQueue]_block_invoke_0 Beginning object mapping activities within GCD queue labeled: org.restkit.ObjectMapping
2012-07-26 14:54:47.305 restkit_arity_bug[50472:1803] D restkit.network:RKObjectLoader.m:256:-[RKObjectLoader performMapping:] No object mapping provider, using mapping provider from parent object manager to perform KVC mapping
2012-07-26 14:54:47.305 restkit_arity_bug[50472:1803] T restkit.network:RKObjectLoader.m:193:-[RKObjectLoader mapResponseWithMappingProvider:toObject:inContext:error:] bodyAsString: {"coffee_shops":[{"id":1,"latitude":"20.0","longitude":"-122.4075","name":"Foo","shot_count":0}]}
2012-07-26 14:54:47.306 restkit_arity_bug[50472:1803] D restkit.object_mapping:RKObjectMapper.m:320:-[RKObjectMapper performMapping] Performing object mapping sourceObject: {
    "coffee_shops" =     (
                {
            id = 1;
            latitude = "20.0";
            longitude = "-122.4075";
            name = Foo;
            "shot_count" = 0;
        }
    );
}
 and targetObject: (null)
2012-07-26 14:54:47.306 restkit_arity_bug[50472:1803] T restkit.object_mapping:RKObjectMapper.m:278:-[RKObjectMapper performKeyPathMappingUsingMappingDictionary:] Examining keyPath 'coffee_shops' for mappable content...
2012-07-26 14:54:47.307 restkit_arity_bug[50472:1803] D restkit.object_mapping:RKObjectMapper.m:261:-[RKObjectMapper performMappingForObject:atKeyPath:usingMapping:] Found mappable collection at keyPath 'coffee_shops': (
        {
        id = 1;
        latitude = "20.0";
        longitude = "-122.4075";
        name = Foo;
        "shot_count" = 0;
    }
)
dyld: DYLD_ environment variables being ignored because main executable (/usr/bin/atos) has __RESTRICT/__restrict section
(main)> 2012-07-26 14:54:47.369 restkit_arity_bug[50472:1803] wrong number of arguments (-1341117672 for 0) (ArgumentError)
((null))> rake aborted!t an active exception
Command failed with status (1): [DYLD_FRAMEWORK_PATH="/Applications/Xcode.a...]

Tasks: TOP => default => simulator
(See full trace by running task with --trace)
```

The key error here is:

```
2012-07-26 14:54:47.369 restkit_arity_bug[50472:1803] wrong number of arguments (-1341117672 for 0) (ArgumentError)
```

Which sure feels like I'm being trolled.

