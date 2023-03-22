Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50162F37
	for <mptcp@lists.linux.dev>; Wed, 22 Mar 2023 19:47:50 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso13728659wmb.0
        for <mptcp@lists.linux.dev>; Wed, 22 Mar 2023 12:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1679514469;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hrh9y+P+KSDposI6RaKkcBZJJPa40TJSHOu2zkV04Z4=;
        b=WDYAU75lc9XJ5C/qTLieNJpoTfrqnYJzWdOKn9j5p4OjL/MAUBLR5gjT+LqzuHyJP1
         geEO7yAjYNEKodh3dXFvXViKPkncr66yGFHVqOtzegv4KZtXsfn0csr8sWAorMPZYIo+
         xLhuBDpqdtQQcszI9fQno+LdpscFd5ymH2PptrrkfID/LeiBwVAv7ZrKP6lYMAiINmXy
         clbpWG6nb6dv58ZKV5ZFRKnC/YZst/8ibh56dGWj7n926V5WDed7MUzJTyDMvY/MC746
         38SnCipz5LupjFtdQhtM6otC7GzmxZ86RLsDzzLpcYaR49bb5WjKclDNd8BtE6KAbf6J
         ZqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679514469;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hrh9y+P+KSDposI6RaKkcBZJJPa40TJSHOu2zkV04Z4=;
        b=0puhDBkIjJHqkQAmvqOI25iGlQ9ek2F1Q1dzdl6nIqoDcbgpFs68Zo9b909Aie3vQ6
         kqHhpvWEqyB7hE2amLJuPZ/BeWHIFgitY4MVqM8QGTnmzlZzjaSzSBXxfo/jqyA4+9+t
         IcaIl3eJfIHMYcwUAfRT5zfttWHZZQ65by9lgl8gacCCs+ahiMHBxMAV7jyAFbtRBDmI
         Zgs7NGI36EzNXnHHj9ddtEmuVEuXhPrgsApO1PrrCL7n9kyTn5worOYAuyEv6GI65oTh
         Sazo/yNOqZgE3J61p1APlwKMVKgtgCKO7tUndM/KIhAI95XrA53wzDgJpZV7oU5mTWSK
         hRgg==
X-Gm-Message-State: AO0yUKV3cxbqwWdi/XIVDcYSdoEi3Vbb+v1Ylo6BFN/lZp3e1S7aB+Sl
	QYkxdTOu5kF9M/rfWESkTSA3Iw==
X-Google-Smtp-Source: AK7set/8vp+EmlDUWYqBKEFt6ZiMhkzbt6kzh1XyCGohgNDdSKh6Q0E1MYkXcaU942W3Ea4CobT7Bw==
X-Received: by 2002:a05:600c:21c7:b0:3ed:23d5:4c4c with SMTP id x7-20020a05600c21c700b003ed23d54c4cmr529337wmj.12.1679514468491;
        Wed, 22 Mar 2023 12:47:48 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:4d5c:7535:4763:760? ([2a02:578:8593:1200:4d5c:7535:4763:760])
        by smtp.gmail.com with ESMTPSA id f20-20020a7bcd14000000b003e203681b26sm17626013wmj.29.2023.03.22.12.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 12:47:48 -0700 (PDT)
Message-ID: <7975a4b1-208c-572e-31e0-9a54d11bdc80@tessares.net>
Date: Wed, 22 Mar 2023 20:47:47 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: Linaro tests: kselftest-net-mptcp: how to improve stability?
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
 Linux Kernel Functional Testing <lkft@linaro.org>
References: <d90817bf-3721-349e-017c-3df5e8cca5f0@tessares.net>
 <CA+G9fYu8z_yp5xSuYT6AusCL1pVg9+zPevsgJ3BZvAA-uTnMCQ@mail.gmail.com>
Content-Language: en-GB
In-Reply-To: <CA+G9fYu8z_yp5xSuYT6AusCL1pVg9+zPevsgJ3BZvAA-uTnMCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Naresh,

Thank you very much for your reply!

On 21/03/2023 10:28, Naresh Kamboju wrote:
> Hi Matt,
> 
> On Fri, 10 Mar 2023 at 03:58, Matthieu Baerts
> <matthieu.baerts@tessares.net> wrote:
>>
>> Hi Naresh,
>>
>> TL;DR: I'm contacting you regarding the MPTCP selftests you are running
>> as part of the LKFT project. I'm part of the MPTCP dev team and I would
>> like to improve the stability of these tests and their "value".
> 
> We have been noticing new developments in MPTCP and LKFT would like
> to continue testing and validating MPTCP subsystems.

Great! Again thank you for that!

>> A few words about our QA strategy: we are trying to cover a large amount
>> of our code by writing some selftests but not exclusively (we are also
>> using kunit, packetdrill and syzkaller). Ideally, new tests are added
>> when a feature is added or a bug is fixed but that's not always easy.
>> Our test suites are running regularly: when the code is modified or when
>> someone sends patches. The tests are executed by different CIs,
>> including one [1] which is public (but slow).
>> In other words, we try to have test suites we can rely on to track bugs
>> and regressions. It is not always easy to avoid instabilities because
>> most tests are expecting events that can happen slightly after a certain
>> timeout but we do our best and we are trying to improve reported issues.
> 
> LKFT test plan also includes LTP, selftests, kunit and packetdrill.

Oh, good to know.

For our Packetdrill tests, we depend on a Packetdrill fork supporting
MPTCP[1]. We would like to have MPTCP supported by the upstream
Packetdrill version but there are still some work to be done there. So I
guess it is easier not to validate our packetdrill tests[2] on your side.

[1] https://github.com/multipath-tcp/packetdrill/
[2]
https://github.com/multipath-tcp/packetdrill/tree/mptcp-net-next/gtests/net/mptcp


Regarding KUnit tests, that would be great if you can validate them.
Maybe you are already validating the ones linked to MPTCP
(CONFIG_MPTCP_KUNIT_TEST -- in net/mptcp/) but I didn't find them on
your website when looking at the results for the last v6.1 [2]:

[2]
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.20-200-g2152cefff654


>> [1] https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export
> 
> This is an interesting CI and I have checked multiple test runs and verdicts.
> Do you have a reporting emailer ? if yes. Please add me to the CC list.

Currently, we only send emails for tests linked to patches sent to our
ML and "daily" reports are only published on IRC: #mptcp-ci on
irc.libera.chat.

One example:
https://lore.kernel.org/mptcp/727e7111-585b-8734-c09b-3fec788f498f@gmail.com/T/#u

Results are also published on patchwork, e.g.


https://patchwork.kernel.org/project/mptcp/patch/c913793939e57514aa7143d70751749961ede71f.1678778977.git.geliang.tang@suse.com/


Maybe we could publish results to KCIDB, would you be interested by that?
(It might also help us to track regressions than doing that manually.)

Or start sending email reports if you prefer.

>> I looked a bit at the different builds that have been executed on your
>> side and I have a few questions:
>>
>> - The results from the validation of v6.1.13 were quite good [2]:
>>   - only one issue with mptcp_join.sh selftest because BusyBox is used.
>> The error is "cmp: unrecognized option '--bytes=1024'". We don't use
>> BusyBox on our side and we didn't notice this option was not supported.
>>   - Is BusyBox common in CI environment? Can you easily change or should
>> we adapt our tests to support it?
> 
> As you know Busybox is a common CI environment but not enough.
> 
> We have our internal rootfs Openembedded and Deabian projects. By use of
> these projects we are testing our test suite. Like any other test suite
> the userspace tools  / commands / packages are needed. Here We will add
> required commands like "cmp" into our rootfs projects and that way test
> coverage will be improved.

Thank you!

If it is common, we can also adapt our tests when there are alternatives
that are Busybox's friendly.

>> - The results for v6.1.15 are less good [3]:
>>   - mptcp_connect.sh fails because a new feature (TFO) is not supported
>> on older kernels
> 
> Noted !
> 
> Let the test detect that feature is not supported on older kernel / not
> supported architecture and exit as SKIP instead of fail.
> 
>  - test can check for feature availability on running machine by checking
>    file : /sys/files or /dev/files or /proc/file
>    grep CONFIG /proc/config.gz
>    if not found then SKIP it.

Unfortunately, that's not as simple:

- For this specific example, it is still OK but we can only detect if
the feature is present by trying to create a connection: so from the .c
program and not from the script launching the different tests. We then
need to handle this from the .c program and transfer the info to the
script. So here, we can do something but it increases the code
complexity and maintenance (and risk of wrongly skip the test). If the
kernel is being validated by the selftests coming from the same kernel
code source, we avoid having to handle that.

- For other issues, it might even not be really possible to predict the
behaviour the kernel will take, e.g.
  - on kernel X, a specific packet A is sent but there was no need to
send it in these conditions: it was not a bug, not sending it is seen as
an optimisation
  - on kernel X+1 and in the same conditions, the packet A is no longer
sent and the kselftests have been adapted to make sure it is not sent.

  => how can we deal with that? The userspace API has not been changed
but the "internal" behaviour has and the selftests validate that.


Is it not possible to add an exception for kselftest-net-mptcp to run
the selftests coming from the same kernel version? (e.g. selftests from
v6.1.21 when validating the kernel v6.1.21)

Maybe more subsystems need such exceptions if they validate internal
behaviours, probably many linked to network features when it is easy and
required to look at what has been generated.

>    or
> 
>    Like LTP test suite have API to check kernel_version()
>    selftests might need this way of validating kernel version
>    then act accordingly.
>      - tst_kvercmp.c
>      - tst_kconfig.c
>      - tst_kernel.c
>      - https://github.com/linux-test-project/ltp/blob/master/lib/tst_kvercmp.c

We would like to avoid looking at the kernel version as some patches --
fixes including some behaviour changes while keeping the same interface
-- can be backported.

>>   - mptcp_join.sh has the same issue as with v6.1.13 with "cmp" but also
>> new ones. I need to investigate why, probably because a feature is not
>> supported in older kernels or because the adaptations linked to that are
>> not supported on older kernels (or not working with BusyBox)
> 
> 
> We will keep you posted with the latest results after solving the "cmp"
> issue. Thanks for investigating the reported failures.

Thank you!

>>   - mptcp_sockopt.sh fails because we expect the kernel to write a
>> certain amount of bytes. Here the userspace has been compiled with a
>> more recent kernel having a "struct tcp_info" bigger than the one of the
>> kernel being validated here
>>
>>   - userspace_pm.sh: the failure is probably the same as the new ones
>> from mptcp_join.sh because of one feature missing
> 
> Same as above.

Same here, the selftest validates internal kernel behaviour and it looks
difficult to be able to support multiple kernel versions.

>> - The results for v6.2.2 are not that good [4] but the issues are the
>> same as seen with v6.1.15: mptcp_join.sh and userspace_pm.sh are
>> failing, maybe because of BusyBox.
> 
> We will re-validated after rootfs update with required userspace tools.
> 
>>
>> [2]
>> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.12-119-gfc84fcf24fda/testrun/14895400/suite/kselftest-net-mptcp/test/net_mptcp_mptcp_join_sh/log
>>
>> [3]
>> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.14-43-gb6150251d4dd/testrun/15204254/suite/kselftest-net-mptcp/test/net_mptcp_mptcp_connect_sh/log
>>
>> [4]
>> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.2.y/build/v6.2.2-1001-g69fee4438716/testrun/15395982/suite/kselftest-net-mptcp/test/net_mptcp_userspace_pm_sh/log
>>
>>
>> - Having the selftests from the last stable version running on older
>> kernels is problematic for us and cause the regression you reported [5]:
> 
> We will continue to do that.
> Maintaining known failures / issues test case names per kernel version is
> also a regular maintenance job for any CI system.
> 
>>   - It is OK to skip a test if a feature (or a tool) is missing even if
>> it increases the complexity (by adding multiple checks, stopping when we
>> detect that, etc.) and the risk of not seeing the validation is skipped
>> because the check was wrong.
>>
>>   - Some features can be hard to detect: e.g. an event is only generated
>> from a certain kernel version. That can be checked by querying the API
>> but then we need to add and maintain these tools to check capabilities.
> 
> You are right !
> OTOH, LKFT thinks of selftests as a project and we are discussing more
> generic problems.
> 
>>
>>   - But mainly: some modifications on the kernel side can not be visible
>> for the userspace application but cause a different production of
>> networking packets: order, type, attributes, etc. For example, some core
>> features of MPTCP have been added progressively in different kernel
>> versions: supporting multiple subflows, sending MPTCP FastClose to reset
>> a connection, etc. In one kernel version, with the same userspace app,
>> only one path will be used while multiple ones will be used later. Or
>> "plain" TCP RST will be sent in one version while MPTCP FastClose and
>> RST will be exchanged in another: for the userspace application with the
>> existing socket interface, that the same because the connections have
>> been reset, just one is doing that better.
> 
> As you describe, this is not easy to handle reported cases.

It might not even be possible to predict the kernel behaviour when
validating the internal behaviours.

The problem is that if we cannot find a way to skip one subtest, the
whole test will be marked as failed making all the other tests useless!

For example, mptcp_join.sh selftests run >100 subtests. If one of these
subtests continuously fails on older kernel, the whole mptcp_join.sh
selftest is marked as "failed", making the whole test useless when
validating old kernels. Then we cannot track regressions properly and
miss real issues.

How can we avoid that if we cannot skip some tests and if the selftests
from the same kernel version cannot be used?


>>     In other words, the checks we do verify something (exchanged
>> packets) the userspace apps should not care about. One one hand, we
>> don't see an easy and maintainable way to be able to skip such tests if
>> the "feature" is missing because the feature is not directly exposed. On
>> the other hand, we don't want tests on older stable versions to fail all
>> the time and loose all their value because the new test suites are not
>> supporting older kernels. Please also note we ask to backport fixes in
>> the selftests to older kernel versions.
> 
> 
> But backporting fixes is one of the ways to solve these.

Yes but then, if only the selftests from the last stable version are
used, there is no interest to backport fixes to older versions if they
are no longer used.

> However, We will keep practicing running the latest selftests (not just MPTCP).
> on older stable branches.
> 
>>
>>     Could it eventually be possible to run MPTCP selftests (and maybe
>> all "net" tests from what I heard from Net maintainers) using the ones
>> from the same kernel version as the one being tested? (e.g. using the
>> selftests from v6.1.15 when validating v6.1.15)
>>
>> [5]
>> https://lore.kernel.org/stable/CA+G9fYtDGpgT4dckXD-y-N92nqUxuvue_7AtDdBcHrbOMsDZLg@mail.gmail.com/
>>
>>
>> - One last thing: some tests can be unstable if they run on slow/busy
>> environments, e.g.
>>   - mptcp_join.sh: many tests where we expect some packets to be
>> transmitted with a timeout: most of the time on our slow public CI, the
>> tests pass but it is difficult to cover all setups. What do you usually
>> do with such unstable tests? Do you stop taking them into account? Do
>> you have any recommendations for us? Maybe it is not ideal to have many
>> subtests (>100)?
> 
> Slow machines qemu. FVP and 32bit architectures are always a case to be
> considered. Would it be a good idea to keep / transmit fewer packets ?
> or increase the expected timeout ?

It is not as simple, e.g. if the delays are way too long, the kernel
might start retransmitting some packets, changing the expected behaviour
and failing the validation of the internal behaviour. The public CI we
used is already slow, we tried our best to cover most cases to make the
tests useful but don't hesitate to tell us when there are instabilities
on some specific environments.

> In Few cases we mark them as XFAIL which are time dependent on slow machines.

Does XFAIL mean "the test is ignored" or "the test is expected to fail,
if not an error is reported"?

>>   - simult_flows.sh: we check the generated bandwidth with quite some
>> margins. If the system is really busy, the test will fail. Could we
>> somehow mark the test as requiring to be executed on machines with
>> enough free resources?
> 
> We generally run a single test case at a given point of time.
> Mostly our test environments have good free resources.
> But I'm not sure if it will be enough for MPTCP.

OK, good to know. The instabilities should not happen then.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
