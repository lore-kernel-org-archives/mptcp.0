Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CF3E554
	for <mptcp@lists.linux.dev>; Mon, 11 Sep 2023 12:22:57 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-68fb70fca9fso863914b3a.2
        for <mptcp@lists.linux.dev>; Mon, 11 Sep 2023 05:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694434977; x=1695039777; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWJyEvvC2xhjCVgSapfu26xdcIhtxZ6WFxHeGFVg5Hg=;
        b=Ei7hJyWgsqaGjOoUmARprHanwqSFHWkzw+5IrqcFMcsM+fCstgtVMT3X7tUvMW8uov
         y52aSUuBMfc/LSEdyY2DMmcjwlJFMoJ1Yjl7N70u/JdsxSuatUGnUWzVGbtdoAvaO9Ix
         ndNKdpxd2+3WEf7pSNOpb5m+3uiWuTV7ZIn1mq3Bjc34cJcy3l5YpvHuDId5zYtRfbMJ
         L02EdELfAOGMM697Jf/SBpwLHel0FtLrqFjo3mN9KUDmCUWPhhJbZmee/WzKAtw3ICh1
         eL2qC9D5Yx5VHWrK753xs04o53b7qhKlvTNwr5s4fTcDOpVJsGn0CVgzYSeFMJpMPgZs
         /RYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694434977; x=1695039777;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oWJyEvvC2xhjCVgSapfu26xdcIhtxZ6WFxHeGFVg5Hg=;
        b=bp1fpQhaN7Otw9hgMLYxh80K/8hguSwGhlexnihV3QsBKh2pAIbMvMSLopm4kDpo7C
         kYeZv0tdn3AD6R+zxDyAHfOQ61LzENO7iD7oRut1neq/pyzhcuxZhLjH80Ztob1J2pKV
         U0k0jnOqhsNrwBUpqkdYATKtATUrj2PMpY5rMXVZGJbuKUL0AU+tY7xnnOiXUViaF/ux
         ceh9kel9SJh94nALPS2L1KmxWTa6RYT2h6/MYagJzg6cWMsIbhx91Fb/batLDWl8pyJn
         izASh9CFr3Pv9bp+jNlsWRehiTPQTwK4fu84rjZTb6Rzd6R/+6MZpgeUwonekqYtXzpT
         9c9Q==
X-Gm-Message-State: AOJu0YyzNp0F/UeUWAVDGwLvFFup3GpaWUlv1QDOWWdQdRID83EEsGdU
	3OdxraNFtPVFoU2bnYt6KQ==
X-Google-Smtp-Source: AGHT+IF/Dn6n7Jl0lrrEfjJSNT0wYgH6/mmMvowwCOOs8tTgpl20UqFw6jzjbFdkq12Wv6Z+72ChLg==
X-Received: by 2002:a05:6a00:b85:b0:68e:390d:8693 with SMTP id g5-20020a056a000b8500b0068e390d8693mr8748159pfj.13.1694434977192;
        Mon, 11 Sep 2023 05:22:57 -0700 (PDT)
Received: from [127.0.0.1] ([40.83.243.136])
        by smtp.gmail.com with ESMTPSA id p4-20020a056a0026c400b0068fb8e18971sm2545126pfw.130.2023.09.11.05.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 05:22:56 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <fe8c2c5502b7a924bdcba6621486e1e68861f9fd.1694426964.git.pabeni@redhat.com>
References:
 <fe8c2c5502b7a924bdcba6621486e1e68861f9fd.1694426964.git.pabeni@redhat.com>
Subject: Re: mptcp: add a new sysctl for make after break timeout: Tests
 Results
Message-ID: <082bcd92-2a41-2848-8e5e-c6cee1edb178@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Sep 2023 12:22:55 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5354374893928448
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5354374893928448/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_mp_join - Critical: KMemLeak =
=E2=9D=8C:
  - Task: https://cirrus-ci.com/task/4650687452151808
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4650687452151808/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6480274800771072
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6480274800771072/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Critical: KMemLeak =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/5776587358994432
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5776587358994432/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/32d268a633c7


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
