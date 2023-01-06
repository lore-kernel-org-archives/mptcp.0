Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31412770E
	for <mptcp@lists.linux.dev>; Fri,  6 Jan 2023 17:39:19 +0000 (UTC)
Received: by mail-vs1-f41.google.com with SMTP id i10so2149334vsr.12
        for <mptcp@lists.linux.dev>; Fri, 06 Jan 2023 09:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBvW3o6PsOoEMy8Z5mOyMMp0dmDcTc7D7iqeAn6UGB8=;
        b=nUtllRjI6ZjEaqTg0qv7wqfRhi9ioVnnT9HtDwQE/zHH83A2UeUuesTOawprzL1IdV
         wrygygsdPRzksmsOBuv3PeQt2vFPMf9MW1txZYTkJbxJZrn/WEvEJuetfyR6CouXo5Dh
         b7784jVC5vBmlbAnljn8Qwo25Xt4POZ8Yglwehkn8DbBBUwzilP8nER7PQSW5bcwBGu7
         Q1UzbpkOpRPKV13AYJpxCtG09okxMS8UKZ2D4JtHuYUb83u8ijPmNZ48jScNJc3V2y6E
         TQKSycHBebeykd9a1qxYodg/qasu+uZqpCHlVT1RV1iDKiHHxO+9BnhCBe+XH68oRD/5
         XQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aBvW3o6PsOoEMy8Z5mOyMMp0dmDcTc7D7iqeAn6UGB8=;
        b=wNkldxQyDNtKXl1KYPMDCrcberQ4Brbh1cPE+J+RTgUzkVL2+Zq9lopYzaKsT5Dumd
         8+rFpPy95/348dZYtdx6q+LB55YOkE+PbhsNQjAa+ZLR69efEf3xvMzcXDLL3gCqkkBg
         6ddQwL2r4FJEY+UYl298q5mR1NloKkcnapYOF2s/n8HlOpTaRyQwDia04sIpZBPspPlr
         OzzjkP4wtKWtPRLrZVwuyB30Hf8AMh0yGNFS0FDH/r2RfxnD1yecqRWEjub6rpfoc4QP
         TGMBbswOqF5LXXxC3ZEVemc0f4CGphwoe4P0c1X/mVSIGqls6A7bOkk5QcoITOP4ZpJG
         QE0g==
X-Gm-Message-State: AFqh2kqcqzMDtcO+sSSElFWAGM2l6Ljae3JuTkTfG/Tt+wKPcVnUvVkl
	7Pg9ezBBeFR9ikNgS3P6BLdjRXB336kv
X-Google-Smtp-Source: AMrXdXt0tnn99PpPZ/CgEymwQV81aKIP5EUr4pDQGG/F2CMrC717XbXjerFMX5JCPfMMzsxaLmCuUg==
X-Received: by 2002:a05:6102:661:b0:3c8:693a:8a85 with SMTP id z1-20020a056102066100b003c8693a8a85mr20711034vsf.35.1673026758599;
        Fri, 06 Jan 2023 09:39:18 -0800 (PST)
Received: from [127.0.0.1] ([172.176.145.224])
        by smtp.gmail.com with ESMTPSA id x15-20020a05620a448f00b006ea7f9d8644sm834498qkp.96.2023.01.06.09.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 09:39:18 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230104171526.1416746-13-matthieu.baerts@tessares.net>
References: <20230104171526.1416746-13-matthieu.baerts@tessares.net>
Subject: Re: selftests: mptcp: userspace: avoid read errors: Tests Results
Message-ID: <b5ab1365-f06e-9361-4993-29581e399435@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Jan 2023 17:39:17 +0000
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
com/task/5454374122553344
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5454374122553344/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6580274029395968
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6580274029395968/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4750686680776704
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4750686680776704/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5876586587619328
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5876586587619328/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/006896eb902f


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
