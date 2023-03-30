Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8A08C09
	for <mptcp@lists.linux.dev>; Thu, 30 Mar 2023 18:22:25 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id r5so19381877qtp.4
        for <mptcp@lists.linux.dev>; Thu, 30 Mar 2023 11:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680200544;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhQtba6acn+ZVsnsONosatDulWJ+DnRhtXsh4HwETPM=;
        b=Vr67cL2KrxgRpwnALvBWIzX78fDQZ8a55mX8ZTV3qwQhbgCFf43NdNRxhKAnnbx6lK
         2RCJtYMIZMQqAiS1QrxmdeQ4OYQfn05Mtiyl/ZdxeO4H3MWIvNgG3SKM2OZhyb5lz2z4
         InAmNgUoLvERWh6O4EHdAC1KhzA3DjtolBrYr0q26o7tRR5ZYck39FiB/sx6urgFAcGs
         8v8TqpXLEqGXISEsc43XmI1CeUxcuXts9lys4CKRBiibL6fGSqXrAvFriYt9N0ljuxeh
         gBrbtCwsP8osjK6tG+8YeTD0HTbqNstPoARwOZjvDQIj2bEGBNRwHjY3VHjdOgbXMt8K
         ESsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680200544;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hhQtba6acn+ZVsnsONosatDulWJ+DnRhtXsh4HwETPM=;
        b=ttZzQ1Guy/xMj+27DL9XoUB+FZ00XRxB9A5YvXuZNs2z+9rvp18FhuPi9eHnC9MZSm
         Spd81mew2PsEQBoO5+AO79vZcsjCfXhX7zysQAO0NeOnHu5xhylBHP73aJbY146hHbwL
         K9ZKU7dcA1gGLIBxJ6ZbRodC2yJQql1kxQdgkm0Zj/G4VKWBvs3ZAPW7HjfysZLGOdoU
         Mns47XzaDcT4U5/zRoxmewQ2bhzAEVUkDQDslcw8JgbKOc//gx9b0i8SZpvKiy12kPvZ
         wjd4kfVD8JnbIwMUyPXg1I0cnID9XVzm9X7alPJp/cKdq40Npk7NsSpH4JTnh+22XyB1
         BgOQ==
X-Gm-Message-State: AAQBX9efS4fMpCST76E3zCAmFxIWn3EuWm/PvPUcrXjMEoQo7C/Phbro
	ATltfpDAmMBReLbczXU48Q==
X-Google-Smtp-Source: AKy350ZfVdK8OPmNIWUDeej7u4bV3oFivS4LqVrdDK8a/q3priZ6bYuXIcsamyWKMsR8QgilyJkmMw==
X-Received: by 2002:ac8:5885:0:b0:3e4:d887:3e88 with SMTP id t5-20020ac85885000000b003e4d8873e88mr28118742qta.10.1680200544636;
        Thu, 30 Mar 2023 11:22:24 -0700 (PDT)
Received: from [127.0.0.1] ([104.45.204.233])
        by smtp.gmail.com with ESMTPSA id q19-20020ac87353000000b003e387a2fbdfsm61569qtp.0.2023.03.30.11.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 11:22:24 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <93685516f6f6d543c831013f957a03a21f774fd9.1680110912.git.pabeni@redhat.com>
References:
 <93685516f6f6d543c831013f957a03a21f774fd9.1680110912.git.pabeni@redhat.com>
Subject: Re: mptcp: fix accept vs worker race: Tests Results
Message-ID: <f5833df0-d567-1f40-04c6-af7da0413912@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Mar 2023 18:22:23 +0000
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
  - Unstable: 1 failed test(s): packetdrill_syscalls =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4921633274593280
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4921633274593280/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6047533181435904
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6047533181435904/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6610483134857216
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6610483134857216/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_syscalls =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5484583228014592
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5484583228014592/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1ab9c8f4a437


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
