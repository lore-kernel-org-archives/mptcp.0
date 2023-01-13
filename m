Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5875A7EC
	for <mptcp@lists.linux.dev>; Fri, 13 Jan 2023 08:44:30 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id c6so22804820pls.4
        for <mptcp@lists.linux.dev>; Fri, 13 Jan 2023 00:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+ChG28JHk2yETQ2d41iDxTCEuKLbThqU8nyG0i+fsA=;
        b=JXJVKXEwKB4gp0+zYLjOYWlA24bDH3UdHyN1XwKdfUsnmoigcejLXlLLzJmBczKiot
         jOTN8u2w+qdnmVRtjdYHqBqC7HukqTvMqBlENCH057e5CuYOTCoD9SNAR5uykoyl45is
         pANqITizvALn50NG3tH5IPvFRWv7/5GVJYEv4AkKoxONIMUxO6c16tuEGE1QwicI/lSo
         /qsxcFATyxGdjQ2zjv62JuiN3PCb1NuFSUv0nFfgkBwRK0KVpZREDQDvmBbKasZtBCTG
         qJ9AOoJ+WpyAqXChDuCNaRnBFEy0I9LuZqGntuivMBW97iGA5YDxpQGcVSCsvlIbmVdP
         bwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H+ChG28JHk2yETQ2d41iDxTCEuKLbThqU8nyG0i+fsA=;
        b=1rLSSBNc04nCfiiBh1EvoYGgSjMv0yIjSuOPe9mOTmnCJxTnbMlbxFib0ifHGWQkc5
         JKpXsvbQR8u7UVG68iG84x0PiYNMNe6G4xZO84Yl76x1Ll3XDTMmISaOTwq6KeAgHNwn
         ax4RsFKOYDD6JP/79FoIySCJogwlg4TJ8BdMSbDNYIZd07TOjbqNLbtHbPFRkZ0Q0qJV
         vwkXV0gTdYiVcKugOyeK2RQo6Uh3yh9h7verCT7XYYzeT16ziXpXeiO+V8FLoWS6eqYF
         tFi08QdGLgNyYr1Ytp2dEfUm0IN/2f/bxiVSzZSFm5OxwBcU2dfm7vJf53nyq6QNhu6S
         PGIw==
X-Gm-Message-State: AFqh2kq2QsHrVbPe/hY4VhFka5+zE/iYx6MH2d1hpE5jhEjXmA6WT5cZ
	54xd7ym7U6NvHWdqSnUFavSLr3CdYQ==
X-Google-Smtp-Source: AMrXdXvpelkKnVbqE6EELKmoAezLY898zUqfk66hYUXsiqhFn5p0Mb3ELGhf/qhcETRDs8IBHBWzbQ==
X-Received: by 2002:a17:902:c149:b0:194:7532:fb31 with SMTP id 9-20020a170902c14900b001947532fb31mr280363plj.62.1673599469730;
        Fri, 13 Jan 2023 00:44:29 -0800 (PST)
Received: from [127.0.0.1] ([13.64.10.193])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902e80500b00189529ed580sm13648625plg.60.2023.01.13.00.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 00:44:29 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f54257b96e166712f86d8476cff83a0db5fba902.1673593769.git.geliang.tang@suse.com>
References:
 <f54257b96e166712f86d8476cff83a0db5fba902.1673593769.git.geliang.tang@suse.com>
Subject: Re: mptcp: update userspace pm subflows info: Tests Results
Message-ID: <11f11d82-56e7-b93e-f45b-c19196d6552f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Jan 2023 08:44:28 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4665951304548352
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4665951304548352/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_add_addr =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5228901257969664
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5228901257969664/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6354801164812288
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6354801164812288/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5791851211390976
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5791851211390976/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/a28ee0fd37e5


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
