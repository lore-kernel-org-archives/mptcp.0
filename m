Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CF06FCE
	for <mptcp@lists.linux.dev>; Tue,  4 Jul 2023 17:25:38 +0000 (UTC)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-78362f574c9so203721939f.3
        for <mptcp@lists.linux.dev>; Tue, 04 Jul 2023 10:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688491537; x=1691083537;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L24mKMQCg5Zk2nHthf3Ji7aGf7F4xiOa2w+mZ5q704A=;
        b=bEjMc3iLjJel8q45QL/S9CigKv+2wrXbtcILvgnLF3gqX0dAGtcxB3/fGpjGY/o7A+
         mUw0PbMLrfcWYQ/ZmgEYs/5gvOcNy1V1EqGCq2Iq2sUGeWH0V4TvtmxO3EMEA/odkWyo
         +MEMOiUUxALRnkMkh+qj2j7YaTyOMEVKDCsmWjMHd/t+j35NeVRkEz/5SQZZMxS3XssP
         gHOLQA0liiAVjx0qF67hxZUd5WMd0XYptn1gSEBq39wLfeRqHyBC35UOFZ+JQ1DHqaRq
         ZexilDaM1n54TVBpJMENc630azMpQdj0GWSYJmX6UdfGtJMGXN94ynV6/ey1i5yQeqzw
         s0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688491537; x=1691083537;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L24mKMQCg5Zk2nHthf3Ji7aGf7F4xiOa2w+mZ5q704A=;
        b=VTSG76r3NrBeDt7vkK556Upwp5pIt9ld0acZUMWXlcl/8oC64VEex/b95k9Qp+PJE2
         WPQVz2SXE8fktPtQrtOf/zeawy1rJJCSIwaxbw6Fda2g5LWkogFB21qe0rURmfHqBqFq
         91e9cL/S5ry+04NEOlvU888gEEFfzqA6JPq0KYrC5JEUYnLQUDZPQmSqyCd5gy6m9Exu
         piBXi+DnTcGperw5iTsjIS/67lgeTop5Pcd8qeE5tVIJ0S5DrhvCidPrCHTqnn93ePFM
         Wot9Ymm24IjJDGx45VZ72e7JU9N5SOD3AXiCgLpa1pNhAT7rrYFZBP2PzWWprOMnx/jt
         xvMw==
X-Gm-Message-State: AC+VfDyc7B3pBzHPS8AuBVuzmeDU5qm3YY3kZ7brOaAjQZZMuF7Ifjcw
	cPVt5ASLfSIETg8OVsciEi0VNW8/o7Q4
X-Google-Smtp-Source: ACHHUZ6z4mu8FpEQsbVZ7u9qvKl/QZLD+WUjBZS64yx+RWsFYZ7kc6IoxUspkWAu/yClKECW9tmZ3g==
X-Received: by 2002:a05:6602:8e:b0:780:bf50:32ce with SMTP id h14-20020a056602008e00b00780bf5032cemr12814717iob.19.1688491537214;
        Tue, 04 Jul 2023 10:25:37 -0700 (PDT)
Received: from [127.0.0.1] ([40.122.243.80])
        by smtp.gmail.com with ESMTPSA id d25-20020a6b6819000000b00777b94e8efasm5952043ioc.18.2023.07.04.10.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 10:25:36 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230704-mptcp-issue-368-selftests-32-bits-v1-1-f4262dc1b07b@tessares.net>
References:
 <20230704-mptcp-issue-368-selftests-32-bits-v1-1-f4262dc1b07b@tessares.net>
Subject: Re: selftests: mptcp: pm_nl_ctl: fix 32-bit support: Tests Results
Message-ID: <b0e66026-c16b-6625-fa55-d867d09d2f0e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Jul 2023 17:25:36 +0000
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
com/task/6567450087522304
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6567450087522304/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5863762645745664
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5863762645745664/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4737862738903040
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4737862738903040/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5300812692324352
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5300812692324352/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/eef9a133eddd


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
