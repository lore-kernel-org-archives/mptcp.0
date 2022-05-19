Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820C623D6
	for <mptcp@lists.linux.dev>; Thu, 19 May 2022 10:49:07 +0000 (UTC)
Received: by mail-qk1-f179.google.com with SMTP id b20so4421695qkc.6
        for <mptcp@lists.linux.dev>; Thu, 19 May 2022 03:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=DYfxLVSAYQ96vrXi5EOTB9uqYPmKD3gGTSe0od23QAI=;
        b=C/CPaB9bPnfntZb+yWeUOZhAu4dRIPUjfdHnC1MeF2MeY6YJc7/FTHqjMbclk6V6Qq
         78FUshqYql4pwr7nXsApMYpMv/Ard75bBBhMYQJFfxCg+2cftXK0i78QysvzQM6rU9+j
         x9RVelE2WQ15u8Nd+/HA4YtwKaaeeOoB+hBRcwrTMk2qHzHyRt2qFIH8aF4SB93zAob9
         64Wd1BJyy1lD3tlkPZ/zifWn9E1Te/1QpuDsDEWxrdBGxwl90xo47L7bq4/Xr4me17wv
         pjSuXF1whgnEfTaWkspHqdKXTymEqW9PU+Wa842QB9tg1nsbsKnUUywz/gpuWBeNH25M
         m3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=DYfxLVSAYQ96vrXi5EOTB9uqYPmKD3gGTSe0od23QAI=;
        b=EW0MaWwuIS+3+hgSkC8SQNSpMjfo4dJx/sviECvPyY2pp9RC+nXlsyfoaRwAYJEnVo
         ybm5xtb6HemdEctnPrCs2kVeMKk+Qj4bBRXQ+mqWxwXmsJZ/w3eMwCcehpy9zobVE3kb
         UyXxi8fFQit0BwhP5ZievPn82GHd99Tr4MC7uBRBjH2/VHO/Kf5cBWrRih4Tji4vJJDd
         GSjDaIQWLQ0sX1yHzy5feBKrR2rIOBqi2KS5pYcuvKEpTHYWuzQlFB+OGq/WJ9z6GUSf
         HMJqskoyTpRH94mU2jaVmnj/CYSRFR7F5yG/KR7BZKA8j+QYlrHb9P5Yu7M07wCA35GI
         Zm2A==
X-Gm-Message-State: AOAM5308ZrhtwPVqxuZiXH/vIz+Vl4Nyrki7RDSvUPWE3bVZVR2UAK2t
	cqT6G3tmZUk2jh6VNzLhkZTqfmu2VQ==
X-Google-Smtp-Source: ABdhPJwvKP43fsxktMizZk7kRI48oCF161ljGf5uWBqO48iQFCviXjsMKd7kbukk4NUtf6ysXU5fvw==
X-Received: by 2002:a37:a385:0:b0:6a3:2baf:7e98 with SMTP id m127-20020a37a385000000b006a32baf7e98mr2540629qke.109.1652957346293;
        Thu, 19 May 2022 03:49:06 -0700 (PDT)
Received: from [127.0.0.1] ([168.62.62.161])
        by smtp.gmail.com with ESMTPSA id m187-20020a3758c4000000b006a3325fd985sm791197qkb.13.2022.05.19.03.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 03:49:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <5bf7f96f2668225cbf594c1c601b1b258e5f82cf.1652948256.git.geliang.tang@suse.com>
References:
 <5bf7f96f2668225cbf594c1c601b1b258e5f82cf.1652948256.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests/bpf=3A_add_?=
 =?UTF-8?Q?bpf=5Ffirst_test=22=3A_Tests_Results?=
Message-ID: <d6012f9e-92be-e549-2ad8-6247371187ce@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 May 2022 10:49:05 +0000
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
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6468726106095616
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6468726106095616/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5373927668056064
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5373927668056064/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/7137300cca2a


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
