Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453FD7E
	for <mptcp@lists.linux.dev>; Tue, 20 Dec 2022 02:52:32 +0000 (UTC)
Received: by mail-io1-f47.google.com with SMTP id b192so5738373iof.8
        for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 18:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnMLw/l+De+7XYap7Zu3fP5Dbl+C76p87kK6eKSH6sE=;
        b=ShvGzCs80vFfkBa/S93bUbarWYdAb/VTcU1TlwIMIJ8TooVorPGBGtKnM/oSKUcuja
         jUOfq89n5tGVESL8AfoYeVRMUJ+ZRDuUlXx1/BeFx9h2fqP35711mBMiezm4FcyPVrAh
         HnEJOcWnhbHikKkUfMgVCnDsBSoMwQhXIkJzV4RUsBEmkr5mpHycj6J8ik5KI1bvKWrM
         oW8qCE+M1cBXxpnEgikA7kobP1cYsGCYr3R3SMpO+ntU8QLEgnun1YFf5FsrYYri9ruU
         08rROv9GzIeWZm4oKgusdhbz72PKF7T1ESGm6f6AvrCVbPtRqxV6eDAde9A3cpFobHam
         UXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZnMLw/l+De+7XYap7Zu3fP5Dbl+C76p87kK6eKSH6sE=;
        b=h1YF4+8q7m70nY3IVya9bWrW8a034oAo+MiOGoc13LYA0Ml+EK1HpRkzePNbboLddt
         +q/my6tiohA5NKwwpCwg/yIgfOis+3T/6A1Y9mNVUIiVO8tnRJI3D4KMkRhuKqydnWVo
         haWtgfNcRiUTTnW+liFjC+AiVbpwlo9sQiA5Hps+Noi+nwrxT4dyG6Eh119rOEFgBUkF
         CWWZ4XumD2UhTJwMkZymPLVAzneObpuRTdOD2tJhHDYpcIaDKo14e3Ww8sXJEOG5uyq9
         rkSyDOW/MiDIj+l31qNy02/zMw8JAA6/P5MrGKDvyXIVpVUEGnabMh7nSCxrmZw983aw
         KGDA==
X-Gm-Message-State: ANoB5plzQVIbaSIHYDvCVhq8W5acvIsNLv7uGwCNec/XQMDqNFEklL9I
	+SXOUPW4nKM2+Dlqf2vmFA==
X-Google-Smtp-Source: AA0mqf5syD/31l5+8AiaQ0KzOJbPlEZ1erjnr8JbQfCzb0d6xnoSh3MI8fOtYzgVPXdHJLGl5YziZA==
X-Received: by 2002:a6b:ef08:0:b0:6e4:2893:2b33 with SMTP id k8-20020a6bef08000000b006e428932b33mr14153569ioh.14.1671504751209;
        Mon, 19 Dec 2022 18:52:31 -0800 (PST)
Received: from [127.0.0.1] ([40.77.123.113])
        by smtp.gmail.com with ESMTPSA id v12-20020a02b08c000000b0038a48cfededsm4023060jah.15.2022.12.19.18.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 18:52:30 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f2247b8c80e438b83f1e8d0340023bc726e80693.1671107241.git.geliang.tang@suse.com>
References:
 <f2247b8c80e438b83f1e8d0340023bc726e80693.1671107241.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_red test: Tests Results
Message-ID: <a8210358-6400-bc05-0fde-f8d408489311@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Dec 2022 02:52:29 +0000
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
com/task/5251623480459264
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5251623480459264/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4970148503748608
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4970148503748608/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6377523387301888
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6377523387301888/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6096048410591232
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6096048410591232/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4dfa4f816be1


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
