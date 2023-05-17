Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBA12A9CA
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 23:53:19 +0000 (UTC)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-54f812f77a7so732205eaf.2
        for <mptcp@lists.linux.dev>; Wed, 17 May 2023 16:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684367599; x=1686959599;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WU8xoPx7pd0boNPmVC/DXNOHwUZERh7pgdQGT9Ugmwo=;
        b=DW2qnF8mwj+1KyfMjP0oHqgcq2DZ4IIXJq1ZBSA6OrYdnw2DVeONNjfdeFPuhDjI37
         MxQLrZggT72lJ6JQJV6Cclj3qyR7n/bO+bxAjgY4/ZyT1HxlLnG6aIelyeJkvsrVU6V0
         00opLSmHbLWGPJnV8gh1mqlAO83FVLEYs3VXk47bgoPlcmWlg5wUZuXHkzxl5u/Jvo2t
         uTMkKDhrVXwqpGTCTRP1F4pdHDUyA1tmyJFJveWDk/gRlCEc07kBn+JYClZ0up2377Wm
         wa8CsTalwZM0C+fIaSbQizAmmCCjOmL0jemCEoPVSO+7J4qiaOw1MLHlhtijcnUk2GpQ
         s7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684367599; x=1686959599;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WU8xoPx7pd0boNPmVC/DXNOHwUZERh7pgdQGT9Ugmwo=;
        b=Y+cNqjXy3h3LNTNlQU913iLlRmteDPao/RM3ej+ND7s7V8/eVOdtGqRlJ7HzmA5Ajp
         ywOAOxF9a+Pl8/BqCQBzbz7+31b+ELj5GNuS3n0rSuNTrZ3acb7NPpn45H4m6IqFnx0d
         p9YSEHqXPrL7b7fcQEAF54pcwhpl5JSzp5LglAcJ9tva4/q4TAGbwPcR9C8GiEsDxDHg
         wS9XYOyatmJPAiMzc4qtoqwY5FrobKibFZtzcQJJ3d+radw9Dq5GoVS6A6liI1V6ppap
         u1EZe8ycDRWlm4vIkCBIiIVG+MeG/MVdiMfLa6eSOUFIdHsmCO/TY+B32dcRQYqKI1H4
         8weg==
X-Gm-Message-State: AC+VfDyNiLbWgI9SHLNCPtKsGCrpP4ECwfpN1HlM8WNgIM9IA+7LqcKs
	L2mWgdFH+0JjRvQUSgTth1lEUdMsGilN
X-Google-Smtp-Source: ACHHUZ62eGcPLRZff4kb1nSH5HSHTbrnU73/CqrGSyMNEGrEK2nDLG5VExgC+O+oX4UQJMKa4mDR+A==
X-Received: by 2002:a4a:dfc1:0:b0:54c:bd89:ee1e with SMTP id p1-20020a4adfc1000000b0054cbd89ee1emr15073253ood.9.1684367598741;
        Wed, 17 May 2023 16:53:18 -0700 (PDT)
Received: from [127.0.0.1] ([40.84.174.229])
        by smtp.gmail.com with ESMTPSA id z19-20020a4a6553000000b0054fa7ac8dabsm10574399oog.24.2023.05.17.16.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 16:53:18 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <b2f6b47d2d9d23bf00211ed098c2f0d3227175cf.1684362296.git.geliang.tang@suse.com>
References:
 <b2f6b47d2d9d23bf00211ed098c2f0d3227175cf.1684362296.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests/bpf=3A_Add_?=
 =?UTF-8?Q?bpf=5Fred_test=22=3A_Tests_Results?=
Message-ID: <1e3c3b16-2bbe-96f4-c3fb-b88ec5571bee@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 May 2023 23:53:17 +0000
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
com/task/5629867937497088
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5629867937497088/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5066917984075776
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5066917984075776/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 4 failed test(s): packetdrill_fastopen packetdrill_mp_capable=
 packetdrill_sockopts selftest_diag =F0=9F=94=B4:
  - Task: =
https://cirrus-ci.com/task/6192817890918400
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6192817890918400/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4785443007365120
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4785443007365120/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/12e66cbae9ae


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
