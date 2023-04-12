Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A0B33CF
	for <mptcp@lists.linux.dev>; Wed, 12 Apr 2023 10:09:35 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id cm23so2249283qtb.3
        for <mptcp@lists.linux.dev>; Wed, 12 Apr 2023 03:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681294174; x=1683886174;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x31IGINOPfwcN6D24cmHSpgdMvd3g6FWIXEFXx/KxxM=;
        b=Z+Slw+p66egXzO13LH/+pyheFYPTm42vLtlpfSMpOpOG2TjZLayKGhknd/RvVroNb2
         e652pjfWI94aKiDzG1YZMnGupxrg/0J5WhXjSC/PlvDo1OL3RQDzdp1pMvpkmxgNbtQI
         +zWnvlIvAcAPvmbodn7ACRHMndfNmJW4UzNHL6QPilKKs/AmNgCijM1GFFqdIGjrlBQH
         0erLZv9J4FDs6u/z3YTzp6QRsQe7rlmivELnIUrlEUWVjl/v6NqXKu9naxA1xxUvN8Zv
         zvJVzPR92m8gTmeDL91DGEt1F56t5kT6qy0i223TjbGO+BU6ChoaipUa370BSc+1w8QN
         6i5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681294174; x=1683886174;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x31IGINOPfwcN6D24cmHSpgdMvd3g6FWIXEFXx/KxxM=;
        b=ClEfcDXWfTTEZN1KgIlSOABg/5D/fxp2HZPeV8sn37eGYtWbrgYX+XaaaNnat4J8Ao
         YJ8ZLHuaFca6Z3EDVloesCms0jH/kTr7Lgcpu/YP25oTK3+AEBPToUg3VSE6Zl2gkDld
         rMsAvW7iHrizrQgx3Q5ifNwJh3wLGPZwl/JnljTW3kqt0pqQgg2YBMXHRrEp/kF7tgNd
         3bHhloNz629zpD9GeFS7U92n/flnHIz4F0bMm0DzrRM8dEKaH7KJ5i05cbg34qRtpzFP
         ob6yDl1fAl8MsbVaIX0uyvfoLBBdDksq1P4SCyyc5sRWHRYRg1Y2XvV7+PR4KGJKz3n6
         aBTw==
X-Gm-Message-State: AAQBX9ftwWijSoJs175Nv0mWL5VfOYulW1a7TDHqowQDmD0oxP92L8+p
	ca8tewJpQneUa49aI40vC3Iip1y6HezO
X-Google-Smtp-Source: AKy350ZVmWozkYrEUo/e09JEvHnKo237bJn1F8DDxMvM1J0/Xe2Rmfy9/NK5dRcyGcaphirJy6Wn/A==
X-Received: by 2002:ac8:5c03:0:b0:3bf:e15f:935c with SMTP id i3-20020ac85c03000000b003bfe15f935cmr2726817qti.14.1681294174667;
        Wed, 12 Apr 2023 03:09:34 -0700 (PDT)
Received: from [127.0.0.1] ([104.45.204.212])
        by smtp.gmail.com with ESMTPSA id s9-20020ac85289000000b003e638d0aa67sm4165335qtn.93.2023.04.12.03.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 03:09:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230404-mptcp-selftests-join-busybox-shellcheck-v3-2-eab5dd7bc996@tessares.net>
References:
 <20230404-mptcp-selftests-join-busybox-shellcheck-v3-2-eab5dd7bc996@tessares.net>
Subject: Re: selftests: mptcp: join: fix ShellCheck warnings: Tests Results
Message-ID: <a792e8f5-8d02-c4bf-27ca-2d69b60908cb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Apr 2023 10:09:33 +0000
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
com/task/6333563574943744
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6333563574943744/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6052088598233088
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6052088598233088/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5489138644811776
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5489138644811776/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4926188691390464
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4926188691390464/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/11a1e9a68af5


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
