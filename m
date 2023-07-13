Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94F6612F
	for <mptcp@lists.linux.dev>; Thu, 13 Jul 2023 23:54:51 +0000 (UTC)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-635f1c7412cso7939586d6.0
        for <mptcp@lists.linux.dev>; Thu, 13 Jul 2023 16:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689292490; x=1691884490;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24StIoVByJ0SU1J3WE14VnpysgGi/YiT8e9wvVX/oMc=;
        b=A/4mlhrN3MADdc98D0j+dTOGXzxcg/dW4atC35KtCpSoLR+7kMD2qUq5rULOuT2p14
         767mM7pt8PPKMwMCRdTmdBqSH+BHx3v+74hnKjdmSz62LKyxDYhnILFXgg9VI2QNBblf
         IBS/OIqUXBLaCV8UTXp5J5LmFIlBuhAA8h0rlMjXrdEphF6VZu4G2Z1RSWBct81wR8CG
         lvCMCdKuKru++LnnLKlrR1I72OSRJyMILAqQfhFzyc0slCwAbI0OsafjlYsmjtsLCNYV
         Ychl/wUPSqyPVHFFUd2kzWJVO/qiWZOYRnxzZHieMapyB7Tm8fawV1bVplvh004YnODe
         2rFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689292490; x=1691884490;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=24StIoVByJ0SU1J3WE14VnpysgGi/YiT8e9wvVX/oMc=;
        b=ckoby/wCCj8kEIeUw+HT/DoKo7jq7HnUBplfcloTZSszWLrPZwIsusYUlPKIS6yaUQ
         aavorCnUSvBlhALJ/yEQSLS31Ef1c9+MapnBV/yNtIP6WcWo+IM+sxp+m82FDfYhyrX8
         iMO8abVGtKOuaeVlg0bu4ontYk74N3YZcdYaIlZ2vRd0pSqd0XzvINi9RFuiZrqd7Y2o
         5Z4Ql5rovFCdyPhniMwrxGhVycB158iiLRTFTl/caUghCJXEoEq3HiU7Q05R3aPnuu3a
         2dL+HoVF1VZT9yYr67B//w6VODIdjkyajWf4sIv0JLtzJs5PBbm/nQHd8bpZeMNn0cc0
         XDXg==
X-Gm-Message-State: ABy/qLYxtlefw3a3VEas9fqyjJtn9/hhOecwc3g8sBGhqfy5J64LgxTY
	UPX3HCaabQ5KED9x9J94e+FSQX9A9dYN
X-Google-Smtp-Source: APBJJlEAhmCS2pD6g1vwNsNOZBfaN2IXk2xh/LxLmLAoRDbacOhJohBTmk8TQz0ZuNx5VmMPJRjbRw==
X-Received: by 2002:a0c:f004:0:b0:62d:df48:baf0 with SMTP id z4-20020a0cf004000000b0062ddf48baf0mr2744915qvk.61.1689292490547;
        Thu, 13 Jul 2023 16:54:50 -0700 (PDT)
Received: from [127.0.0.1] ([172.177.154.107])
        by smtp.gmail.com with ESMTPSA id x26-20020a0ca89a000000b00621268e14efsm3502229qva.55.2023.07.13.16.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 16:54:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230713-tc-selftests-lkft-v1-3-1eb4fd3a96e7@tessares.net>
References: <20230713-tc-selftests-lkft-v1-3-1eb4fd3a96e7@tessares.net>
Subject: Re: selftests: tc: add ConnTrack procfs kconfig: Tests Results
Message-ID: <4eb97917-c7f6-55fe-e5a7-703989eb07f7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Jul 2023 23:54:49 +0000
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
com/task/6025571512090624
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6025571512090624/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4758934116892672
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4758934116892672/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6184348131524608
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6184348131524608/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5462621558669312
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5462621558669312/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/57effcf7cc5e


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
