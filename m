Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB2D320D
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 18:40:01 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id on15so15717963qvb.7
        for <mptcp@lists.linux.dev>; Thu, 06 Apr 2023 11:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680806400; x=1683398400;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBsOOKpeGqm4631El5NA6n61bfNjG8qfJLvEntmo2g8=;
        b=dIHyuThCW6pb1EOsX+f7CaPIUfxiiLCrhMiU+5yVvayqldyYKbgxE7UNmOyHd5WZbN
         aNNVNJdLKR9uiTkFDCvXb+SUlR1eUPhMAwFLhytSAyn+VkmXj8LFBKmmERj4mroSl8wc
         P/dKSYGaInrGMzoDfzvfgAbw3ByTVw9ZihVS37c/amhnoF3Lhz/NGH2YRvL9ogB3U1cU
         HXUsj4fTyu5uYGiwx0SOR5OBMVzAW/aoN3oHX7NR09J9Wi0OSBXbgU2/mz/gFbZosBx3
         ADh4tlOp59VtZigjFNgz7Gxx1e6f51haqeGSyrmVkYwlN9wc6uQPmjipL1Aq2S8x35qi
         PTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680806400; x=1683398400;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lBsOOKpeGqm4631El5NA6n61bfNjG8qfJLvEntmo2g8=;
        b=6PdWmtkZacm+2P+f4xUd50n/htJoyEpQC3p3nuT62y5kr2CNqNXNDQUgApSOChzU8z
         PXEMyDDozBGD3ztCfc5n+gb5/u0p6Og6jqGAsAs6vFRx6OhjgRc3TzWDvwj7nBBAdTFg
         T5BDosbRnFKKVWYFO5jrydeX9l1K5ZGDT5ICI9e63qml2fP2Kyb0vEP7yf5hVcsiOIDM
         u4na5B/I2uPZx8QafhBfoMnan702c6w05STZgxxk17Yz5PByACwnHq8EaCxGVs0ZFDyT
         H7g3eES8h2rnkEeY9c7fHRJd7QsC9dk4Iv0nNN90OauGSgGq0HSs8XK7hiGPMtmkOTyC
         wQAw==
X-Gm-Message-State: AAQBX9c7a8WxPUw5gkZbskTQtFyC8C54YGfky5AS5lW7RoYkQsTNip0s
	GGnksMl/Uik/zxcmT+HyXA==
X-Google-Smtp-Source: AKy350YbS0NaTqsTplAS+gpxEdkSvSNUgK1u+z13Q1loprNb1bTMkudI1syAzUs9S9bkdAUodsTuRA==
X-Received: by 2002:a05:6214:5085:b0:5e0:7ecb:8ffb with SMTP id kk5-20020a056214508500b005e07ecb8ffbmr29880qvb.8.1680806400592;
        Thu, 06 Apr 2023 11:40:00 -0700 (PDT)
Received: from [127.0.0.1] ([104.45.200.58])
        by smtp.gmail.com with ESMTPSA id z11-20020a0cfecb000000b005e45f6cb74bsm697946qvs.79.2023.04.06.11.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 11:40:00 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230406173159.vjKk7zJ6cyrQl9c5RwemQMbWO6eJd8GHzW-3jvtoa88@z>
References: <20230406173159.vjKk7zJ6cyrQl9c5RwemQMbWO6eJd8GHzW-3jvtoa88@z>
Subject: Re: net/mptcp: use netlink policy generated from YAML spec: Tests
 Results
Message-ID: <a2281cc3-5667-4c68-225a-b66eff447fb7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Apr 2023 18:39:59 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Davide,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Unstable: 3 failed test(s): packetdrill_add_addr packetdrill_syscalls =
selftest_userspace_pm =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5911521633501184
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5911521633501184/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5348571680079872
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5348571680079872/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 3 failed test(s): packetdrill_add_addr packetdrill_syscalls =
selftest_userspace_pm =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6474471586922496
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6474471586922496/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4644884238303232
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4644884238303232/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7d20481ccf26


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
