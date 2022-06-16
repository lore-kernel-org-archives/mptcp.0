Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCD47A
	for <mptcp@lists.linux.dev>; Thu, 16 Jun 2022 06:32:43 +0000 (UTC)
Received: by mail-il1-f170.google.com with SMTP id v7so308885ilo.3
        for <mptcp@lists.linux.dev>; Wed, 15 Jun 2022 23:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=5PnS9cW4d5ZUYbMagKMr9yPgd3GFs55jXrolNPdBIqg=;
        b=Ig2RaaEPfwLy/B+oVlcg44l9sVgT1/VYhEvxSqbnadep80nse/OVRO1yvMcr3niEQc
         FLCUNoKyikGD8rl/NCO/cg+7g2/p8xoZVXMTMX96r2CC5wg6jE813HfSA8vgzenPfAB3
         7YBs2Ea6xMC/4Wnk/G2PEmofcVe/HjRLyFYdQJEmsoC64JNaWnT7+crbwNAbvtUxYlrC
         kccAAEF+regafWnN8dtPdBuncuycr695RlvXLUCyCYVU3DlOAYUS5DLNU/Tpq9nJ8tXp
         hZB7svX8XrfaMA89bMGI9MPvEbEN0r9CqIZjxOv8BRLqfWtMg5CtfV6JLhgS+Km9AxOx
         yTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=5PnS9cW4d5ZUYbMagKMr9yPgd3GFs55jXrolNPdBIqg=;
        b=55WhVMseV6GwTWa6CHHdMaipyLSGYGh2gjZOive7JPEzCuDZPfmbP8JlBgTRRyFVfS
         GJyHZ/tWDdGcwsQeNR1vvN1P8l+Dh2uT1WHmApOAEXS4WnLvVF9ONXnLmg2qrMVgb6aE
         hTcWw/1OKfbseagmjYoJQepRxEdd5k2F8RSD42IIuh3pTPlcNYWBlALph7FWUcaf2aE5
         qzZH6EoBZt+jkUrLaInq1+xbXNIPtz67acVek10l9b0iRCUHqfDtY5M327atSWFYgnO4
         bv43LR4FRWzulVgV+fjJNvmPAMC10b98iIAtOXlFc04ijaLhQ2eppw4ogUrrCOYMC4nO
         yufw==
X-Gm-Message-State: AJIora/9Cm+EuSOZ1epFn24wtlHZ8KB62m4evf4BKoJ+ZKfTrOC6AMxH
	IdhuhfQAjHbT5YbrgqmgQQ==
X-Google-Smtp-Source: AGRyM1v3aEGvq/TJsHumPOponfM5z0AvDmT3ST3qQZfUxL/xcDZuBUbWijM1UlT9ss1GjzWAX8euJw==
X-Received: by 2002:a05:6e02:1485:b0:2d1:c323:18fe with SMTP id n5-20020a056e02148500b002d1c32318femr1988137ilk.228.1655361162741;
        Wed, 15 Jun 2022 23:32:42 -0700 (PDT)
Received: from [127.0.0.1] ([104.208.26.241])
        by smtp.gmail.com with ESMTPSA id f20-20020a02a814000000b0032e7bd2287asm520494jaj.94.2022.06.15.23.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 23:32:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <11468cbfc4fc4ca766094b81c544f9108e04daf2.1655355422.git.geliang.tang@suse.com>
References:
 <11468cbfc4fc4ca766094b81c544f9108e04daf2.1655355422.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: update pm_nl_ctl usage header: Tests Results
Message-ID: <453d4949-497c-21a6-dd52-012ad98b712d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jun 2022 06:32:41 +0000
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
https://cirrus-ci.com/task/6339386420756480
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6339386420756480/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): =
packetdrill_sockopts selftest_diag =F0=9F=94=B4:
  - Task: =
https://cirrus-ci.com/task/4932011537203200
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/4932011537203200/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/d4a1e2c951f3


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
