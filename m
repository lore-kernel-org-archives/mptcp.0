Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE8729B0
	for <mptcp@lists.linux.dev>; Mon, 17 Apr 2023 18:36:10 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id ey8so1939546qtb.3
        for <mptcp@lists.linux.dev>; Mon, 17 Apr 2023 11:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681756570; x=1684348570;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NpIow9lCZYkViv9ebApsLH6f0uNqwZFdclQ9RZpfyc=;
        b=BOD9ovTU4vcwHeZU0YMT+fhJllf5KiUn10dL3qWXBUZq8GiTr1b6orXWC0djC4UUO8
         K3p94+kouaGtVTAVAH94vbnZuEDg+3WkXteIeeAZZckJctoWAt5EmNlXsLemh/+5iXnp
         542bB7dJ2I1vYdL5dqqz5N8Q+Um4s2vxMa1y8Vwa4UnDKPEDaYkbpuXOtxKF022bqy1z
         p1tRT9Ib9xFdXW0GOqi+bw5fKgO6k7Jnv9VBd7ntYkd3WGOMgSXQDU4t+IcW5qmwphyS
         Y9MaUSiE4ahCNfBw7NMBEVHKe3SgMMwTmVGSaVGcLoa/Q+8jubT1800+rJQ6bjRqwTIz
         Vm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681756570; x=1684348570;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0NpIow9lCZYkViv9ebApsLH6f0uNqwZFdclQ9RZpfyc=;
        b=U8iVL/6M+6o37AGQNHuKylAs11PQyZ4cGzijO1hr2a/vR7iLOe+jq5qNG+CAD/ZI7b
         G1cClIdL2ffZZT6y6NL4xr6wAC4c5B+BULjddmD3niKR0XXjoc+VyaFE4GdIaZHDVTcV
         NokozG7krR1Ro0T49CjFSwb98HriDfK6agsTHRFGPII+oRhySWw434ihK05LRtIZ+stb
         zqYqDK60369CVOAthzu6UbGZscn/clc3m5JywigyX5Kpi+c9YXupoWnLrQgXoJl5xWJ0
         nL/XyYFyVKRT3KLxzm8ROtYjt5b/UPlmwaLYNdV3NV/PdLNWN7gF6T7uRETp8m+AOa51
         W9Pg==
X-Gm-Message-State: AAQBX9dk74cxe/qgw3shN7Sd4r+qtzItFFpXSrt+VJacAFsts4fCmg1+
	HbatHaIHUq4HqgntvKT4IZ7Hulns9rIt
X-Google-Smtp-Source: AKy350ZUKJLstvEKsnooPjrwydu3aW+eMpGZUawO9FuCBLms2F9su9uayT8/O7oj1D4rY6tp88Mq1A==
X-Received: by 2002:a05:622a:1d3:b0:3ed:164c:681c with SMTP id t19-20020a05622a01d300b003ed164c681cmr12416894qtw.6.1681756569295;
        Mon, 17 Apr 2023 11:36:09 -0700 (PDT)
Received: from [127.0.0.1] ([104.45.205.196])
        by smtp.gmail.com with ESMTPSA id 17-20020ac856f1000000b003e69c51cf53sm3445776qtu.72.2023.04.17.11.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 11:36:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230417-mptcp-mat-alias-v1-1-abe486377b02@tessares.net>
References: <20230417-mptcp-mat-alias-v1-1-abe486377b02@tessares.net>
Subject: Re: mailmap: add entry for Mat Martineau: Tests Results
Message-ID: <ab97676f-de2a-3c8e-7da3-d0f6f7c42b2e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Apr 2023 18:36:08 +0000
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
com/task/6474347796234240
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6474347796234240/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5770660354457600
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5770660354457600/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5207710401036288
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5207710401036288/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4644760447614976
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4644760447614976/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/e9ce416b05e6


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
