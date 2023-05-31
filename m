Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC20171D5
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 15:44:47 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6260b578097so30190496d6.3
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 08:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685547887; x=1688139887;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5diMM8tZIqFSPtCsOBBVNtFiz2CFhKxqlEmUrHwM8PA=;
        b=SC6lUxR1+N29QHfnd0nkGyYChgOPBF1MpIY9BetvvQTwAfuqn/IN2fPDmJewJI11Sa
         OCaXIv2QizKVuy9BPS2vk/vIdR4KUFaMExSsZHBHM9aCaVNwNsEMSyZKqiYpNfJbM2ql
         u1N+odGmpODncDxdgi+i2rIa0GEhnF71J/KzEkKiqsCHvNhEfpKzc7Zj7J/uvb1rtU64
         OFEBrU+uNe9hQWC0AkVAP+6vyNfu5TyewcZqDz7qoD9Ys08pKQh1VecpuW3Gc1Fzg/hK
         /ZDN6EJX8MrtBHWTb3yeQCaIW9+5/b84VWQpXBdLPWPsSJs63+GZoruq03f8Sq1QJLfq
         JE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685547887; x=1688139887;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5diMM8tZIqFSPtCsOBBVNtFiz2CFhKxqlEmUrHwM8PA=;
        b=aAXLsqOJLOm9twFvnMbzfAQTOouRCl4L8wpBIl+rB0H0GlLbsEO6d0Q3CmDoevvBTk
         xp9H0Emg+m468nD/7GOaHZDi9VcRrUnaG5ChigW7YJCD4Vr7znE4Rqwt2q6VUHBbkNB4
         GrAOdna7ApuxbYG2if4V38uDBChhtLQ0evdO4gATKV/9mgOk3yGlMKZJa3uxzhvd95xi
         rolCNqwi+vQjhtp45+BzJh9jPdbjz03cyp5tGSt0jKSybEMwih6iQhb84TDmUzOM0Oka
         Eo4l1ptThiqg9gsxJuOb1NMlJkLgvgYzRfPUYtJHSwTYuJdLTjxBpFJleWfjMeXXkQUU
         oAYg==
X-Gm-Message-State: AC+VfDzk1n0pC2LYHqrrWle84HOhOjrHp/aM7o0Ms94vyqF0dRKPyHpW
	1kgfFP1OecylUwOW5ZI/58ocqE5C9Oeo
X-Google-Smtp-Source: ACHHUZ4D32iZgtqMftBD6H8dXUXJ/gOZRzjCwJYwm+3ThPOwG6DSY4P88KJo8lar6z/AWtWcUzGUgA==
X-Received: by 2002:a05:6214:2a8f:b0:625:aa48:e628 with SMTP id jr15-20020a0562142a8f00b00625aa48e628mr7203682qvb.56.1685547886558;
        Wed, 31 May 2023 08:44:46 -0700 (PDT)
Received: from [127.0.0.1] ([52.190.17.193])
        by smtp.gmail.com with ESMTPSA id y2-20020a0ce802000000b006255bcfca88sm2478295qvn.7.2023.05.31.08.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 08:44:46 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230406-mptcp-issue-368-selftests-old-kernels-v3-32-a1f05258292b@tessares.net>
References:
 <20230406-mptcp-issue-368-selftests-old-kernels-v3-32-a1f05258292b@tessares.net>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests=3A_mptcp=3A?=
 =?UTF-8?Q?_add_MPTCP=5FFULL=5FINFO_testcase=22=3A_?=
 =?UTF-8?Q?Tests_Results?=
Message-ID: <ca8df417-dccf-c45c-e4be-e272b806537b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 31 May 2023 15:44:45 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6481418017046528
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6481418017046528/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4651830668427264
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4651830668427264/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5214780621848576
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5214780621848576/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 3 failed test(s): packetdrill_add_addr packetdrill_fastopen =
selftest_diag =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5777730575269888
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5777730575269888/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/8702aa095b78


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
