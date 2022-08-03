Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C7D210F
	for <mptcp@lists.linux.dev>; Wed,  3 Aug 2022 18:07:43 +0000 (UTC)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-10ec41637b3so13463519fac.4
        for <mptcp@lists.linux.dev>; Wed, 03 Aug 2022 11:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=StThdP+Sh/QGYSYfDLyit0ZaFlwLHmEWE9cJph4PTm8=;
        b=gIARyTwbh0OPgEbqP63dgNtCnV/ZXeXOAgwQLwr79vyiNHSW59DO+xvkb4zC5OECAw
         Hw5hm6LkmrQEGONaITJgsUZt2co3BGHCo7zU3SeAuZU3+85o7JUdt4QeL+6QiFv/uwLA
         +b2n87dPjMP+ydo+ywBPScKLpibJxvY1Nm2uugo9mPp4CjEHCmxdfkrvkDaHtsf3e9Ew
         Pm8S2okIsHIiL4QkPzrBqz+7b81+DksQqZ5LkhuFcVOcGgywYoggGA1AEFvkpucy0MhL
         WTu+UwWTtyIG9hK9jWAvhg0AMyra0Mz2EEsOkp1C+MJ8F76VaPmv9QQuWrLBmDNAwCIa
         uCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=StThdP+Sh/QGYSYfDLyit0ZaFlwLHmEWE9cJph4PTm8=;
        b=KYHGkY9/LjidqopPZ/38MRpD6QHkPkeLUXjcfCLJ3p1cKrNIBOrp6g5ij+o+ktxEwU
         aCmiMOHb3k2rzHCycglcoOKn/00Z8DqlTSQYoIIc5l5m22o8ib9qlTQ6seEYek8TrFyh
         +RaDhAs7/3mUjzKQPat5zHIJO7KzI3R9QPssgbC7tWpCHyEiFSTs2LDmJdr+HMLV2G26
         GNr4qhhxHhBHX5Xoyu39knOQ669ATkf5UzfbUYjjeCAQ/0tSizH4tmBbMOLW2TdLvWBM
         y98o0vWAtFK7IxQ9HElKHDJiBmsUoW2ni7fPkOvsCHRsAmJhsCXop7va1dJgriokL6R6
         5gJw==
X-Gm-Message-State: ACgBeo1zZJQCULbQdWUV02fNgevwq57Hw9zAuFkS8xLkMmf49+0lHNcd
	EpDqdqUYGuSEL5Cc63zMaA==
X-Google-Smtp-Source: AA6agR4V3I1O/ZzuOXXEyR+780RIUSdLd3RHVT/2L7yq//nXq7q20jeFTyKDM+GrJPdKrYNoXtQl3w==
X-Received: by 2002:a05:6870:a78f:b0:101:d05b:fa3f with SMTP id x15-20020a056870a78f00b00101d05bfa3fmr2396977oao.221.1659550062701;
        Wed, 03 Aug 2022 11:07:42 -0700 (PDT)
Received: from [127.0.0.1] ([40.74.249.27])
        by smtp.gmail.com with ESMTPSA id t9-20020a056870608900b0010e73e252b8sm4535134oae.6.2022.08.03.11.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 11:07:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220802163324.1873044-1-jolsa@kernel.org>
References: <20220802163324.1873044-1-jolsa@kernel.org>
Subject: Re: mptcp: Add struct mptcp_sock definition when CONFIG_MPTCP is
 disabled: Tests Results
Message-ID: <cfa3e9ca-0b43-520e-ade3-2f3ae6e73162@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Aug 2022 18:07:41 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jiri,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/4744036484382720
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4744036484382720/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5869936391225344
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5869936391225344/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/71103ca3923b


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (Tessares)
