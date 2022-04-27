Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF297E
	for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 02:58:39 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id i24so452803pfa.7
        for <mptcp@lists.linux.dev>; Tue, 26 Apr 2022 19:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=eTeruXmy97jjI2l54wpU+wP4ySMTMSHGDLd1bmQcazk=;
        b=Az0C1enpXrLoFABtNvyf6o0w/xFn7NhcUkydzHAHwWs69foqGpuUbulciWY2I5z8NP
         QZFGjZjaplTaJXSKOIFTwwH4fliSSBXI+PKRYCGbM1MES7l+BIj+FtiDCHIp/0QWipi8
         efdlf5+BeaAksdB0ZiNWovQP7633A8I5Wwec59vlorTkU3Ns4hrs32N0qYoNuPAagr6s
         I0ByytSOInAMXhWdnvpfBO8kFIKpSDfAw0pqwpr8oF8QFllJmsgjkP1fzbnUfgz7lWUn
         U+mTR/XP/eS1UCZuz6YfWL4HpwZ1siPHEEDMzG1ilauEWZD2GcgApGx26S86CNjvP6yS
         d1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=eTeruXmy97jjI2l54wpU+wP4ySMTMSHGDLd1bmQcazk=;
        b=09O+DosZBdxcqfRFEuTQQUw7p45GWso/E5MsGCJhN4M1tW8orJkaKDqAPSe3/xjrD4
         wsSV+5nNkbvpv5KWVlkQTpeVPuc/F1PLggONeUCvF/qA+Vpj5ZeelpuCp8EzXvOH0cK1
         eepDmSk8borUILx0Ru1psuNe/bzaEmRa+YkYo4Fc0Jz5TRtU1otEXmtLJSbuD5BtnnMl
         sabrk8Up7b2hN1QTvDa6jr4T7pGgLDtK9bqeoYo7Fnaxtn6tj+r2WnoxE8pSDBE5HVZO
         K3tsMrk4i/lAt/6PKJfPdv60UIS6L3EO+KePGbq0SGfaEWbJEH98lFdKR5R1XTYDM7qM
         jxQg==
X-Gm-Message-State: AOAM532dMKSSYfbzX57n9Bow1S05YMiuLUTvSGzmEpoWzH2wHc55z/gL
	wTzihV7Sh1LBeIYy0/gHR1PCgqJmGdrm
X-Google-Smtp-Source: ABdhPJwlp0wG8dHDfayMVBdHlIpBtObh9yVH/vafklcMn+k9Llj1kGGioph6L7d+Lj1UMZwjyXvpCg==
X-Received: by 2002:a05:6a02:182:b0:374:5a57:cbf9 with SMTP id bj2-20020a056a02018200b003745a57cbf9mr21675960pgb.616.1651028319324;
        Tue, 26 Apr 2022 19:58:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.86.229.39])
        by smtp.gmail.com with ESMTPSA id u15-20020a17090a890f00b001cd4989fee4sm4428987pjn.48.2022.04.26.19.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 19:58:39 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <38168fb95c78454db24726d2bd45f2d65d977fda.1651022882.git.geliang.tang@suse.com>
References:
 <38168fb95c78454db24726d2bd45f2d65d977fda.1651022882.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests=3A_bpf=3A_a?=
 =?UTF-8?Q?dd_MPTCP_test_base=22=3A_Tests_Results?=
Message-ID: <349e46cb-2056-7041-8f05-b2075ce4972b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 Apr 2022 02:58:38 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5557640280408064
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5557640280408064/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6683540187250688
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6683540187250688/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/915cd06abad0


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
