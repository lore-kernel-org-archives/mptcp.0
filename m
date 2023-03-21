Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12D679C7
	for <mptcp@lists.linux.dev>; Tue, 21 Mar 2023 09:28:49 +0000 (UTC)
Received: by mail-vs1-f53.google.com with SMTP id c10so5674572vsh.12
        for <mptcp@lists.linux.dev>; Tue, 21 Mar 2023 02:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679390928;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zBV38xcXWJoVzRUnCOJWfLmH0mBLN8K+k0s2KDqCiw0=;
        b=sAuMlk7OWHuiRpLY3XT3SrtTjtVKAoq5kc/V7dZ7aDjCLna5Y5Rr3ZuxItR4fiqMYS
         9Up3DeNZ1nGCgl7MCOE8C7GTcqjsRqjL1Lou4I44M6hCAJ1KWswSh2MNITtO7fACOq+k
         cRurzwHIvyX3v6+Oh1SD1FiGb0iYXhUDOuwoT/UALjBJnYI2xOwvTRWOqNMm+auudt2H
         sevHan05vUlPsGf/qKReXN5mQSdMNdLcj1F/PFi6OcrOzSj1B+iPVK9vZcN5oUJMmf2V
         KPunebILOHU29Qi/RaYJihUgWb24i6eEnPZ/o6YrwmWGlfiC2PeIRZI9soc/7VL1nuSV
         RaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679390928;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zBV38xcXWJoVzRUnCOJWfLmH0mBLN8K+k0s2KDqCiw0=;
        b=B4a5qBfEq3PF9aQYuhwvuKGkgFhd1UnCbqm+/i2YY2vIjiEE6E9DA+unK4ZEpgWwo3
         2tqg8gZIiE8U00NKKy5GcIN3Zi13eZBF4xLnqJG+9QS3DYTeahukWhX01ap/rzdAfI5/
         cw1v3Pryd2Upmjr8pFcH/jSKq4ui4leOnkwipxhmp+PKF2By8bpySMXqowe1vZT7TYvJ
         WeQcoHtQWVUJWjBqu06wuNt6r/HiBGL1/YNuvWRupOqbnlYQxvThqmRlm6iEQJ6KABpP
         sSMR0iuuVwqwD6pNYiklIROKTDpv3eajLfBwyfwo8wDL49FZfg2ySJysvWXV4RZAZc3r
         lAsA==
X-Gm-Message-State: AO0yUKUFG08nZ3CIie2JYmMx+/k9wj1SxDyVR4OZs5NqEZKHIuhy8zyE
	FzzAtV7mR+egUZoRBY/GIGWdtkiagljDa1pNj1i6GQ==
X-Google-Smtp-Source: AK7set9INITy/LYPbvh//RND2moiF3ineiKxHHUBmnZZQRVwmMX1g3NKYVBXpBb5h4h/fDcCd1XWhvyg9KJjMIXXurA=
X-Received: by 2002:a67:d29b:0:b0:425:e623:360a with SMTP id
 z27-20020a67d29b000000b00425e623360amr1126527vsi.1.1679390928411; Tue, 21 Mar
 2023 02:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <d90817bf-3721-349e-017c-3df5e8cca5f0@tessares.net>
In-Reply-To: <d90817bf-3721-349e-017c-3df5e8cca5f0@tessares.net>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 21 Mar 2023 14:58:37 +0530
Message-ID: <CA+G9fYu8z_yp5xSuYT6AusCL1pVg9+zPevsgJ3BZvAA-uTnMCQ@mail.gmail.com>
Subject: Re: Linaro tests: kselftest-net-mptcp: how to improve stability?
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, 
	Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Matt,

On Fri, 10 Mar 2023 at 03:58, Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> Hi Naresh,
>
> TL;DR: I'm contacting you regarding the MPTCP selftests you are running
> as part of the LKFT project. I'm part of the MPTCP dev team and I would
> like to improve the stability of these tests and their "value".

We have been noticing new developments in MPTCP and LKFT would like
to continue testing and validating MPTCP subsystems.


>
>
> First, thank you very much for testing these MPTCP selftests!

Thanks for providing the opportunity to validate the latest MPTCP selftests.

>
> A few words about our QA strategy: we are trying to cover a large amount
> of our code by writing some selftests but not exclusively (we are also
> using kunit, packetdrill and syzkaller). Ideally, new tests are added
> when a feature is added or a bug is fixed but that's not always easy.
> Our test suites are running regularly: when the code is modified or when
> someone sends patches. The tests are executed by different CIs,
> including one [1] which is public (but slow).
> In other words, we try to have test suites we can rely on to track bugs
> and regressions. It is not always easy to avoid instabilities because
> most tests are expecting events that can happen slightly after a certain
> timeout but we do our best and we are trying to improve reported issues.

LKFT test plan also includes LTP, selftests, kunit and packetdrill.

>
> [1] https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export

This is an interesting CI and I have checked multiple test runs and verdicts.
Do you have a reporting emailer ? if yes. Please add me to the CC list.


>
>
> I looked a bit at the different builds that have been executed on your
> side and I have a few questions:
>
> - The results from the validation of v6.1.13 were quite good [2]:
>   - only one issue with mptcp_join.sh selftest because BusyBox is used.
> The error is "cmp: unrecognized option '--bytes=1024'". We don't use
> BusyBox on our side and we didn't notice this option was not supported.
>   - Is BusyBox common in CI environment? Can you easily change or should
> we adapt our tests to support it?

As you know Busybox is a common CI environment but not enough.

We have our internal rootfs Openembedded and Deabian projects. By use of
these projects we are testing our test suite. Like any other test suite
the userspace tools  / commands / packages are needed. Here We will add
required commands like "cmp" into our rootfs projects and that way test
coverage will be improved.

>
>
> - The results for v6.1.15 are less good [3]:
>   - mptcp_connect.sh fails because a new feature (TFO) is not supported
> on older kernels

Noted !

Let the test detect that feature is not supported on older kernel / not
supported architecture and exit as SKIP instead of fail.

 - test can check for feature availability on running machine by checking
   file : /sys/files or /dev/files or /proc/file
   grep CONFIG /proc/config.gz
   if not found then SKIP it.

   or

   Like LTP test suite have API to check kernel_version()
   selftests might need this way of validating kernel version
   then act accordingly.
     - tst_kvercmp.c
     - tst_kconfig.c
     - tst_kernel.c
     - https://github.com/linux-test-project/ltp/blob/master/lib/tst_kvercmp.c

>
>   - mptcp_join.sh has the same issue as with v6.1.13 with "cmp" but also
> new ones. I need to investigate why, probably because a feature is not
> supported in older kernels or because the adaptations linked to that are
> not supported on older kernels (or not working with BusyBox)


We will keep you posted with the latest results after solving the "cmp"
issue. Thanks for investigating the reported failures.

>
>   - mptcp_sockopt.sh fails because we expect the kernel to write a
> certain amount of bytes. Here the userspace has been compiled with a
> more recent kernel having a "struct tcp_info" bigger than the one of the
> kernel being validated here
>
>   - userspace_pm.sh: the failure is probably the same as the new ones
> from mptcp_join.sh because of one feature missing

Same as above.

>
> - The results for v6.2.2 are not that good [4] but the issues are the
> same as seen with v6.1.15: mptcp_join.sh and userspace_pm.sh are
> failing, maybe because of BusyBox.

We will re-validated after rootfs update with required userspace tools.

>
> [2]
> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.12-119-gfc84fcf24fda/testrun/14895400/suite/kselftest-net-mptcp/test/net_mptcp_mptcp_join_sh/log
>
> [3]
> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.14-43-gb6150251d4dd/testrun/15204254/suite/kselftest-net-mptcp/test/net_mptcp_mptcp_connect_sh/log
>
> [4]
> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.2.y/build/v6.2.2-1001-g69fee4438716/testrun/15395982/suite/kselftest-net-mptcp/test/net_mptcp_userspace_pm_sh/log
>
>
> - Having the selftests from the last stable version running on older
> kernels is problematic for us and cause the regression you reported [5]:

We will continue to do that.
Maintaining known failures / issues test case names per kernel version is
also a regular maintenance job for any CI system.

>   - It is OK to skip a test if a feature (or a tool) is missing even if
> it increases the complexity (by adding multiple checks, stopping when we
> detect that, etc.) and the risk of not seeing the validation is skipped
> because the check was wrong.
>
>   - Some features can be hard to detect: e.g. an event is only generated
> from a certain kernel version. That can be checked by querying the API
> but then we need to add and maintain these tools to check capabilities.

You are right !
OTOH, LKFT thinks of selftests as a project and we are discussing more
generic problems.

>
>   - But mainly: some modifications on the kernel side can not be visible
> for the userspace application but cause a different production of
> networking packets: order, type, attributes, etc. For example, some core
> features of MPTCP have been added progressively in different kernel
> versions: supporting multiple subflows, sending MPTCP FastClose to reset
> a connection, etc. In one kernel version, with the same userspace app,
> only one path will be used while multiple ones will be used later. Or
> "plain" TCP RST will be sent in one version while MPTCP FastClose and
> RST will be exchanged in another: for the userspace application with the
> existing socket interface, that the same because the connections have
> been reset, just one is doing that better.

As you describe, this is not easy to handle reported cases.

>
>     In other words, the checks we do verify something (exchanged
> packets) the userspace apps should not care about. One one hand, we
> don't see an easy and maintainable way to be able to skip such tests if
> the "feature" is missing because the feature is not directly exposed. On
> the other hand, we don't want tests on older stable versions to fail all
> the time and loose all their value because the new test suites are not
> supporting older kernels. Please also note we ask to backport fixes in
> the selftests to older kernel versions.


But backporting fixes is one of the ways to solve these.

However, We will keep practicing running the latest selftests (not just MPTCP).
on older stable branches.

>
>     Could it eventually be possible to run MPTCP selftests (and maybe
> all "net" tests from what I heard from Net maintainers) using the ones
> from the same kernel version as the one being tested? (e.g. using the
> selftests from v6.1.15 when validating v6.1.15)
>
> [5]
> https://lore.kernel.org/stable/CA+G9fYtDGpgT4dckXD-y-N92nqUxuvue_7AtDdBcHrbOMsDZLg@mail.gmail.com/
>
>
> - One last thing: some tests can be unstable if they run on slow/busy
> environments, e.g.
>   - mptcp_join.sh: many tests where we expect some packets to be
> transmitted with a timeout: most of the time on our slow public CI, the
> tests pass but it is difficult to cover all setups. What do you usually
> do with such unstable tests? Do you stop taking them into account? Do
> you have any recommendations for us? Maybe it is not ideal to have many
> subtests (>100)?

Slow machines qemu. FVP and 32bit architectures are always a case to be
considered. Would it be a good idea to keep / transmit fewer packets ?
or increase the expected timeout ?
In Few cases we mark them as XFAIL which are time dependent on slow machines.

>
>   - simult_flows.sh: we check the generated bandwidth with quite some
> margins. If the system is really busy, the test will fail. Could we
> somehow mark the test as requiring to be executed on machines with
> enough free resources?

We generally run a single test case at a given point of time.
Mostly our test environments have good free resources.
But I'm not sure if it will be enough for MPTCP.

>
>
> I hope we will be able to improve the "value" of these MPTCP selftests
> you are running at Linaro!

Looking forward to it.

>
>
> Sorry for the long email :)
> But thank you for having read it!

Most welcome !
Thank you.

>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net



--
Linaro LKFT
https://lkft.linaro.org
