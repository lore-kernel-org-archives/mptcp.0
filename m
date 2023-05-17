Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04CB5255
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 06:03:52 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-75791a035b8so25089485a.3
        for <mptcp@lists.linux.dev>; Tue, 16 May 2023 23:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684303431; x=1686895431;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0p3DQioNG499aQChiCCkOiKQmSkAyz2LLT6To+2wgM=;
        b=JLB2lRzV1X9955ut/V66Jt1DYOO/4gCisv+8CiKzJ55lSbyFvq4V4figZrIWL+jNrJ
         PpOrOuk2vkhw1pqvSZ9gWwq/kXCQnIXsq+aA2CHVrElT/eFj9jtFxQ/JrqYMSQoN8aJN
         R7U35siafPyM0JzSyBAlMY1AHENOkb9wssyABLGkRh24Zz0+pDDR8dNY73wKb7S4+/eq
         UGY/N1IsQxCFe806ApyxOqXW9ilVdOwe2wd5NeaoWIipItqDXsfrDO82p7FWteeX1y0X
         A2bMFWeG2nz2LX/CvntQnQ6rcovvfkBp31t7HnxaaR4aj87qsi895uR5g1L6uY1K2c3U
         n7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684303431; x=1686895431;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H0p3DQioNG499aQChiCCkOiKQmSkAyz2LLT6To+2wgM=;
        b=QSIllGXtSUv4hIoXjL0pAtDaXZW5O393EsTUL8Zvp5hODcTSJgsscBMxDmi5eLEBt8
         tuQsTUKiFRZ5WOC2DJwSRjt7KCLm9Lu6WT1kcyWFlhbxcAQgCcxT6o4Up5Ckh/YV6h9B
         JO0xX5OpqJ0y+fEYOqliV8AVqq/vUbkGRZ5R2hZ3dj6gsOHEzn00Aq8B1jclfDcfpshJ
         /9iLyNK8qMPNTX5WZC6BYffEQqYLJM/9tCW85zZ+Vj0AUbjmQqAMiuPeLwOwVvpAtzXd
         vKvWVhEoSKfR/nhtfw2RcYAyRwn9uxlpp4jbiARJz5aB6n5rn9XMK1pKu5ziwUnF51Lu
         1y9w==
X-Gm-Message-State: AC+VfDw/3Oe8jcdnYI0DkQz0kvJaFOMnF3Ba97RwguRbgsZkFp9wkFUk
	e3DSMvzAKSyB0VhUeP5i8E52eLJ+aA==
X-Google-Smtp-Source: ACHHUZ7vThfAUH2Cz04d4ONUXbT8oSqXlOU7l9obAJAxTYJGARFJ9fAEuuKnjTCYNQNXnuAymamrNA==
X-Received: by 2002:a05:6214:c6b:b0:623:66ee:79b2 with SMTP id t11-20020a0562140c6b00b0062366ee79b2mr14412103qvj.36.1684303431519;
        Tue, 16 May 2023 23:03:51 -0700 (PDT)
Received: from [127.0.0.1] ([172.176.205.124])
        by smtp.gmail.com with ESMTPSA id h18-20020a0cb4d2000000b0061b7bbb7624sm6152249qvf.130.2023.05.16.23.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 23:03:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ffa2a0c237bf2046ae89bfe8334a4cf88953112f.1684297911.git.geliang.tang@suse.com>
References:
 <ffa2a0c237bf2046ae89bfe8334a4cf88953112f.1684297911.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests/bpf=3A_Add_?=
 =?UTF-8?Q?bpf=5Fred_test=22=3A_Tests_Results?=
Message-ID: <0d8538d2-cf03-42a4-6968-e803b2f06922@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 May 2023 06:03:50 +0000
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
  - Unstable: 1 failed test(s): packetdrill_fastopen =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4555438918729728
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4555438918729728/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 4 failed test(s): packetdrill_add_addr packetdrill_fastopen =
packetdrill_mp_capable selftest_diag =F0=9F=94=B4:
  - Task: =
https://cirrus-ci.com/task/5118388872151040
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5118388872151040/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6244288778993664
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6244288778993664/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5681338825572352
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5681338825572352/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/38f1f1e48833


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
