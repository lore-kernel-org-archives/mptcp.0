Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9FA2566
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 12:21:19 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id i17so1236286pla.10
        for <mptcp@lists.linux.dev>; Wed, 04 May 2022 05:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=9nrWpppwXroCCb5k/9lSyhciBsXvshlh7G6i1DDGDIg=;
        b=I+1ZrpdZnBn2vkUG+xxvJ32tkgfZqvLjlePXIv8ckdlnNv85qxTXIY5I1GHOgXQgIT
         E7jYHKTKEdOjkHkchmP1DWX0Z5xBxbuacHstC9NC1vbB5+5jSV8aBUK1+hU0Fgd8MU+j
         hOMGNsVOspdRVKhDbrM1qY7yD4mxVLhY5yf6IXGJTT7HBypTaD+yPdZXWPK0dznVA52a
         wBV5E339xQ3nXKgiqvQ0zYKqU64wO1Et7saF0dZJvG8XtYwgNOdFUx/FyfKzmknNEEhw
         XPCi+C4I8L5/tcsCNSEhQBOBecbTC3475h1pUdlD1R0oTzV+QaeFn06lq6utruSuwioI
         MwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=9nrWpppwXroCCb5k/9lSyhciBsXvshlh7G6i1DDGDIg=;
        b=0FH19A6gpLKlfbk6XLJULVC37KIDxRKUkbbIb8ecHBk7rQeRr+h54bMAfZM0ca79pK
         X5BfDcTyXJi8c5sToIOs0uB9H4X84N91m/HZU7ynrMJW5rL7pTv8HSNmx0yfId2vHQTT
         9zq6sZ4wWJDVEOwiVKBe/xjM9MRn4HBPOW41r42MV9MUI/MT1W6rPg+/G8QMKZrrITY2
         jOeJTflZ0e8vvdKDm9Qr6GAwqWr5bBo0aUKzViQPlteEHZIEqwGfsG1FFUxylGbRb5U2
         JeTlsxv/d350ZH3rpeqwsA923LcSNW1k1Mx9a0U9QJXzBevH1dztwwq/0mfdE29+Z96T
         Fy8A==
X-Gm-Message-State: AOAM530KpJqLloHn6ZTW6BZ6IEHW7zL6U0zAgAST1ew8QHPsq4Enj+oY
	+CLYytNFiRUBGHhkTjeqjkP39CYsVD6E
X-Google-Smtp-Source: ABdhPJyVimTV7eedC4CSYNQ62aScNSo0OHq9uExffQvsrkolJ/y+IFB0XLtOVvyvlhNags6/WHXBrQ==
X-Received: by 2002:a17:902:eb87:b0:15e:a144:78ab with SMTP id q7-20020a170902eb8700b0015ea14478abmr15454741plg.55.1651666879162;
        Wed, 04 May 2022 05:21:19 -0700 (PDT)
Received: from [127.0.0.1] ([20.237.155.136])
        by smtp.gmail.com with ESMTPSA id k3-20020a170902694300b0015e8d4eb24fsm8127992plt.153.2022.05.04.05.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 05:21:18 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <cdcd6b9963a1c15b20ffcf71e06b6de70f67ec4a.1651664645.git.geliang.tang@suse.com>
References:
 <cdcd6b9963a1c15b20ffcf71e06b6de70f67ec4a.1651664645.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests=3A_mptcp=3A?=
 =?UTF-8?Q?_add_MP=5FFAIL_reset_testcase=22_-_clean?=
 =?UTF-8?Q?ups=3A_Tests_Results?=
Message-ID: <155210ad-2447-998e-9706-6e31af2c7510@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 May 2022 12:21:18 +0000
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
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.com/task/5972194063810560
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5972194063810560/su=
mmary/summary.txt

- KVM Validation: debug:
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.com/task/5409244110389248
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5409244110389248/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/cd2b6a887541


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
