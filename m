Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3D53FEF
	for <mptcp@lists.linux.dev>; Sat, 27 May 2023 15:28:56 +0000 (UTC)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-19f3550bcceso161890fac.0
        for <mptcp@lists.linux.dev>; Sat, 27 May 2023 08:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685201336; x=1687793336;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WeMrTuizvAzhz0InUeKELCW7SxdTQDLrktw5UfEGlc8=;
        b=GJAPv2Fnw56wvSPwakPcb1/ru8YBw3vSXQ8ZTR09eZNGY13xfo6wrK9fJb6dko4C6A
         8I78zxbht/l/o9+RnnOrRcN1W4uVUvbvGhviqeDtjXoo+ITy15E+O74iPJ4FMnYrmukM
         wTH4TH25BB2H/oFy27CFDDEDrS1NzJbbQ1wUOiImf9ChSuAgWDkcg73eB3d/uTkWzmkD
         RisWTOcIOtLc98LIuso0XoSzLUOUgHw4x+ZlfLh2TeQhlOcKr7CFqN1B8QeEsUcDUhYs
         PgM9/8z/axq3/14CBUcjZ7OQcggt+pnY4rfdn6QAbnjgJS2eG++VB9/74uucdvCfGN2/
         JcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685201336; x=1687793336;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WeMrTuizvAzhz0InUeKELCW7SxdTQDLrktw5UfEGlc8=;
        b=GezYQkcaHC8+a93TiiFORiWRaRSAlg3a4NLff8/IPKkpCRpJF1zUZocwyR/LC/pmYM
         a+GSNEwm3A9mfMrgjsFhgg/Taz6CzG8L9BvDJooVl7HyNnaj+DCYHUgQd0CiM5BqMIyT
         2/jSHKiEV+ze1aqn+K20Ni1U7UKbtJerfaK0Lt/GY2n3pyZ3bWkVmR+CZs8P/9LCAfww
         99XLMYTF9HQ62mRfLqIlxoajjGUGWrC20H8QYxanPPjzymuOGUD4a/7rlUZqrMubl01k
         7Ry+6cx/FTy0WF1icG16cixOIfNPcSjrXm93lyQhE9uJypthWOUfKM93Fw8QnaW5skkX
         Yq9A==
X-Gm-Message-State: AC+VfDwY7N+85uom3VZlqD7jOKpqYxmM6U98H40wCwVBGxRNXsYpDcxm
	w7JBunc12k5GZhkR9z9kPR4Q81ReTg==
X-Google-Smtp-Source: ACHHUZ5ql49ijhlJ3iHF+vt7qdYfxLOIAoUZSXj1VNBi/z/qmI2HWatMGSv1csmSdPqK07Uh2eAplQ==
X-Received: by 2002:a05:6870:4407:b0:17f:7388:4c69 with SMTP id u7-20020a056870440700b0017f73884c69mr2492648oah.30.1685201335678;
        Sat, 27 May 2023 08:28:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.65.246.135])
        by smtp.gmail.com with ESMTPSA id dt48-20020a0568705ab000b00195e943f958sm2895345oab.1.2023.05.27.08.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 08:28:55 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ef47cf1485fc292a8f613c3f507dab8c6e7c7a65.1685191581.git.geliang.tang@suse.com>
References:
 <ef47cf1485fc292a8f613c3f507dab8c6e7c7a65.1685191581.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests/bpf=3A_Add_?=
 =?UTF-8?Q?bpf=5Frr_scheduler=22=3A_Tests_Results?=
Message-ID: <3ea4474b-df97-b641-4f4e-fb24b84570cf@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 May 2023 15:28:54 +0000
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
  - Unstable: 1 failed test(s): selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6601570566012928
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6601570566012928/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6707669310898176
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6707669310898176/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 3 failed test(s): packetdrill_add_addr packetdrill_fastopen =
selftest_diag - Critical: 1 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/5897883124236288
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5897883124236288/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Critical: 1 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/5003560975335424
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5003560975335424/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/f83d4fc5e61e


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
