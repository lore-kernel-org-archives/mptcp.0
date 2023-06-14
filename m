Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611CC361
	for <mptcp@lists.linux.dev>; Wed, 14 Jun 2023 04:44:01 +0000 (UTC)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-77ac2eb07a3so249467239f.2
        for <mptcp@lists.linux.dev>; Tue, 13 Jun 2023 21:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686717840; x=1689309840;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFWpVilBWCHmSO8KUVgZFd28VE+gqBPvzVUWCsv/AF0=;
        b=I3qS+mGBRPR8jVcLw7owbdNI+dacPtqh7GiLmMpMoOE4Gunr38LDQMcZHLM0tmL33x
         buu73S6J6IOH8SJ7mPLapgqPMwO+f9EJR5yfWfIv3RFeEpgC1s+Co707I823H1ryhbHt
         wWJ/JJCO4NXSisSUSxvWxg3pgG771tkrtq9X0wC8yVReXcrp11S2r/J6FTQ5d74HotSQ
         VgqIhaiFFagnpHAp1uTMTqbXFxDW2uoRU/QHUoC025TA+Ok3Cz6Sj1gZROFqutVueaVL
         VGq6eA/P5s4mMsfz29GJnJk5rG5nzyg/iPz51Px3sBznJpYGnpJcER5UviVwggaEP4iR
         NN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686717840; x=1689309840;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LFWpVilBWCHmSO8KUVgZFd28VE+gqBPvzVUWCsv/AF0=;
        b=bVrnFIQkumElY5kAADKxLXnVn7cis4X99WLWHPbEjnZYc7fHGoE3GLSSJ6lSzeZv9H
         I87VyfUYB1mXiRXXDWKuaNjau1EdeLBhM4Kvy34sTaKNGVmHoouII5h9+Ye2J1pLIf1c
         sr51TbyWiduMe3ap9JxV98xMWDi0ijephFEt98LVdYxrnBtoZNJZuGiAsiqiULuDRaD0
         KJdD0mYMtirIzV6Zc6eka3LML/MJK5FsCEGzUqokfJozvSt4Ipyd4qM6EovdhUY6+R0J
         sL7ed9bvWKlOpjxT89MhSh/OW5y4yoZ3qU6nEs6/qCjY9JNYS5hagcsyz8sBBKlpap35
         1zMA==
X-Gm-Message-State: AC+VfDy9/HNvGhiWktu/66+EGU9Uu1QeN/mK6d2h6A1chMSpjZvyCAAO
	klLu7cLWu4CImJwSJKwIL1fA8RZw0Bct
X-Google-Smtp-Source: ACHHUZ5SuV4jgqfzNyFPUlwNGNXTPEg2uypVps9XZ39HQ3S8a4iw8hgk9ekqKn7i0ZVMC89y2CgQnw==
X-Received: by 2002:a05:6602:196:b0:77a:17d1:3b2b with SMTP id m22-20020a056602019600b0077a17d13b2bmr12391900ioo.18.1686717840303;
        Tue, 13 Jun 2023 21:44:00 -0700 (PDT)
Received: from [127.0.0.1] ([40.122.244.104])
        by smtp.gmail.com with ESMTPSA id k24-20020a02c658000000b0041f4bd6f285sm3742049jan.37.2023.06.13.21.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 21:43:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <cadb420a03c98ac7099fd2228745262626f8ec9c.1686713645.git.geliang.tang@suse.com>
References:
 <cadb420a03c98ac7099fd2228745262626f8ec9c.1686713645.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22mptcp=3A_add_mptcp=5F?=
 =?UTF-8?Q?subflow=5Fctx=5Fby=5Fpos_helper=22=3A_Te?=
 =?UTF-8?Q?sts_Results?=
Message-ID: <353e4d8a-e4cd-802d-8bbd-b283421c3ccc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Jun 2023 04:43:59 +0000
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
com/task/5838969158500352
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5838969158500352/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5276019205079040
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5276019205079040/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6401919111921664
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6401919111921664/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4994544228368384
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4994544228368384/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4ad44703c9ae


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
