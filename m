Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397CDC94E
	for <mptcp@lists.linux.dev>; Thu,  9 Mar 2023 22:28:05 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id bx12so3369630wrb.11
        for <mptcp@lists.linux.dev>; Thu, 09 Mar 2023 14:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1678400884;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzoBEy0kvFr9s/RrudERSi0b7mRq+e6VhjlRjX0FgxU=;
        b=10/Wud/i+17G7xXUqgiIVpAVkjmQ13WJBHHWQeLUgDmuxrDfZszvMnqv05ENxg1OyO
         m1ntpcB7OHyF7JW1pYz6BGkaewMcPi+DWiN1DbY3i/KBTpZEg3/WD9aU8LKHxXUBJGgz
         25YFmtZFZU21Z/fyLvN2Wi0iZz9FE8qPzVw2aM0uvSFkG+ERgzzBdFi0XJeysY+K8nS0
         JuNDD3cdyvcZSwemU3uu25+bFSIec+QU3cKf4yCl5R9ejXC6qgYKsvBgTtjY3aVllnVe
         iwGcB5Mjy+DiIHQUTCaev41O4L2K7xhq7q+4PunnWoY8czduap4NtoDndCbJKTiTtxto
         JS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678400884;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lzoBEy0kvFr9s/RrudERSi0b7mRq+e6VhjlRjX0FgxU=;
        b=6tIK7rXh2hgTutoJA6rKVEOwez9cCIutU4j9cYrBm8HDQ/Hw6eGEDTUMrA9vEoX8Hk
         24snRUhMuiGjtLZfdLTYb5R8B6JIcNIjjFDeCA2lTkBgjw4S0VZjUMDiV0bOwieJFbrA
         XvaSKV9/ymPFc22MnWZRh3cApLKz80hqBxHKtDDh9cKEAnEWIoa/N94je8s1yLvVloTc
         l8rK5toqN3KRUoRGXNvSQIhpiLIUhP5ybWJWsPpGClcMa6t2s3qOi2wFzFN9gyBzlzcx
         LDMlATfA1roCcfUV4h5mm51bDy/bkqARYRt0sM1bmW3CvY692P+0GHBGkhQAgHb65nm7
         OCqA==
X-Gm-Message-State: AO0yUKVTPlsM8PfyyHAwk+OnGV1F9ybohAzlkyU27l/R3y60lqN0Fr0n
	B/cmguP4t09IuYX7YDqKHPMQ8Q==
X-Google-Smtp-Source: AK7set94dNmGGriGW93iTDmwnuy8UFlQsPKM00x+atbOylKdIlpjW18k7kWYSoamU5q6eAHaHP7cPg==
X-Received: by 2002:adf:ea03:0:b0:2c7:1e43:f46e with SMTP id q3-20020adfea03000000b002c71e43f46emr16885824wrm.37.1678400883914;
        Thu, 09 Mar 2023 14:28:03 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:4361:62e9:a7e1:a51f? ([2a02:578:8593:1200:4361:62e9:a7e1:a51f])
        by smtp.gmail.com with ESMTPSA id i5-20020a5d4385000000b002c563b124basm450518wrq.103.2023.03.09.14.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 14:28:03 -0800 (PST)
Message-ID: <d90817bf-3721-349e-017c-3df5e8cca5f0@tessares.net>
Date: Thu, 9 Mar 2023 23:28:02 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
 Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Linaro tests: kselftest-net-mptcp: how to improve stability?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Naresh,

TL;DR: I'm contacting you regarding the MPTCP selftests you are running
as part of the LKFT project. I'm part of the MPTCP dev team and I would
like to improve the stability of these tests and their "value".


First, thank you very much for testing these MPTCP selftests!

A few words about our QA strategy: we are trying to cover a large amount
of our code by writing some selftests but not exclusively (we are also
using kunit, packetdrill and syzkaller). Ideally, new tests are added
when a feature is added or a bug is fixed but that's not always easy.
Our test suites are running regularly: when the code is modified or when
someone sends patches. The tests are executed by different CIs,
including one [1] which is public (but slow).
In other words, we try to have test suites we can rely on to track bugs
and regressions. It is not always easy to avoid instabilities because
most tests are expecting events that can happen slightly after a certain
timeout but we do our best and we are trying to improve reported issues.

[1] https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export


I looked a bit at the different builds that have been executed on your
side and I have a few questions:

- The results from the validation of v6.1.13 were quite good [2]:
  - only one issue with mptcp_join.sh selftest because BusyBox is used.
The error is "cmp: unrecognized option '--bytes=1024'". We don't use
BusyBox on our side and we didn't notice this option was not supported.
  - Is BusyBox common in CI environment? Can you easily change or should
we adapt our tests to support it?


- The results for v6.1.15 are less good [3]:
  - mptcp_connect.sh fails because a new feature (TFO) is not supported
on older kernels

  - mptcp_join.sh has the same issue as with v6.1.13 with "cmp" but also
new ones. I need to investigate why, probably because a feature is not
supported in older kernels or because the adaptations linked to that are
not supported on older kernels (or not working with BusyBox)

  - mptcp_sockopt.sh fails because we expect the kernel to write a
certain amount of bytes. Here the userspace has been compiled with a
more recent kernel having a "struct tcp_info" bigger than the one of the
kernel being validated here

  - userspace_pm.sh: the failure is probably the same as the new ones
from mptcp_join.sh because of one feature missing


- The results for v6.2.2 are not that good [4] but the issues are the
same as seen with v6.1.15: mptcp_join.sh and userspace_pm.sh are
failing, maybe because of BusyBox.

[2]
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.12-119-gfc84fcf24fda/testrun/14895400/suite/kselftest-net-mptcp/test/net_mptcp_mptcp_join_sh/log

[3]
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.14-43-gb6150251d4dd/testrun/15204254/suite/kselftest-net-mptcp/test/net_mptcp_mptcp_connect_sh/log

[4]
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.2.y/build/v6.2.2-1001-g69fee4438716/testrun/15395982/suite/kselftest-net-mptcp/test/net_mptcp_userspace_pm_sh/log


- Having the selftests from the last stable version running on older
kernels is problematic for us and cause the regression you reported [5]:
  - It is OK to skip a test if a feature (or a tool) is missing even if
it increases the complexity (by adding multiple checks, stopping when we
detect that, etc.) and the risk of not seeing the validation is skipped
because the check was wrong.

  - Some features can be hard to detect: e.g. an event is only generated
from a certain kernel versions. That can be checked by querying the API
but then we need to add and maintain these tools to check capabilities.

  - But mainly: some modifications on the kernel side can not be visible
for the userspace application but cause a different production of
networking packets: order, type, attributes, etc. For example, some core
features of MPTCP have been added progressively in different kernel
versions: supporting multiple subflows, sending MPTCP FastClose to reset
a connection, etc. In one kernel version, with the same userspace app,
only one path will be used while multiple ones will be used later. Or
"plain" TCP RST will be sent in one version while MPTCP FastClose and
RST will be exchanged in another: for the userspace application with the
existing socket interface, that the same because the connections have
been reset, just one is doing that better.

    In other words, the checks we do verify something (exchanged
packets) the userspace apps should not care about. One one hand, we
don't see an easy and maintainable way to be able to skip such tests if
the "feature" is missing because the feature is not directly exposed. On
the other hand, we don't want tests on older stable versions to fail all
the time and loose all their value because the new test suites are not
supporting older kernels. Please also note we ask to backport fixes in
the selftests to older kernel versions.

    Could it eventually be possible to run MPTCP selftests (and maybe
all "net" tests from what I heard from Net maintainers) using the ones
from the same kernel version as the one being tested? (e.g. using the
selftests from v6.1.15 when validating v6.1.15)

[5]
https://lore.kernel.org/stable/CA+G9fYtDGpgT4dckXD-y-N92nqUxuvue_7AtDdBcHrbOMsDZLg@mail.gmail.com/


- One last thing: some tests can be unstable if they run on slow/busy
environments, e.g.
  - mptcp_join.sh: many tests where we expect some packets to be
transmitted with a timeout: most of the time on our slow public CI, the
tests pass but it is difficult to cover all setups. What do you usually
do with such unstable tests? Do you stop taking them into account? Do
you have any recommendations for us? Maybe it is not ideal to have many
subtests (>100)?

  - simult_flows.sh: we check the generated bandwidth with quite some
margins. If the system is really busy, the test will fail. Could we
somehow mark the test as requiring to be executed on machines with
enough free resources?


I hope we will be able to improve the "value" of these MPTCP selftests
you are running at Linaro!


Sorry for the long email :)
But thank you for having read it!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
