Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553E5137A
	for <mptcp@lists.linux.dev>; Wed, 22 Jun 2022 11:52:14 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id h9-20020a17090a648900b001ecb8596e43so7357975pjj.5
        for <mptcp@lists.linux.dev>; Wed, 22 Jun 2022 04:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=uGNLalw38N3xkUgLe6BB5i7v4qyTPGHryj1OkU1WIoM=;
        b=Qi3ZEIaIL9rT1gxIXhqIfdA3wGKCGgnvDYSu6L8TMYfRxuGcMdKuBujDfNHQxBe7WK
         kbhXvs5nzMIZylb3t0laDuJfjc5Gha3F8uwQ2I5jWU5ZtNv/CHlAd2P5aG93LuujTsdr
         HS4S/CyAfiqcDksx32B9jVT2vE4roKCa/myFwOu48Mbg7Fmj15BkQmRIMvXYpvmiDmyx
         4Hh+skkHB1hlxbLx6S8qmCrtbR2wMCGDgEd8mvLWoSEDdzNKLZWPBkYLY814BNvfzX9A
         FjrIPOVk72ARfClFa39jrW7UAw4X0elObVGZ+Ceri7WVZAMiRK/vxSEe9o3C/IhPAJV7
         CarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=uGNLalw38N3xkUgLe6BB5i7v4qyTPGHryj1OkU1WIoM=;
        b=bRBNX5VilVM3ENoe1FZ5CLgAqZqUB4lTZnUj6HatheGzb7jVNKv/wT3k2uphBymjlh
         Q9ZEMvUxQWPMJYiZ3KHBV+a081PAUkG9qpEUjVq8vdttGPkxTQUAKMoiHBzV3GF8Ws/1
         xryLXsvyEXJbocZAyzCNr/JaGNCYtJz/feOSlHoCkxtXek0Bj5Wcq8A8I4u8gU+NSYmc
         +ZZqPqbZ4hKvDHO+6RZaq5THBepcNFp1ZC8NhW8Iw4BtvCM0MGt3kgrDwmrB4dw7ZOE9
         TIOsKxMtQmC+uzGSpzBGO8G5Kl1kDbJkST2YFO11b8yU4IJSBVYx/ElaPfg5cJrZ+Th4
         V98w==
X-Gm-Message-State: AJIora/HRtYsxvlk9G9dTZ//G0AtvUmioO1rBNoZXTxBYn6MXu6shMYq
	0BbRcMnYd4ajUgCXPr5luA==
X-Google-Smtp-Source: AGRyM1tAXlzfza+v6DIVtYMmn2WiR2w6vkYStYEDgt8TkVbqEV/C9/qNrbxERHjBIZVW5KpUCxnPxA==
X-Received: by 2002:a17:902:e84a:b0:16a:1759:da1e with SMTP id t10-20020a170902e84a00b0016a1759da1emr19740082plg.49.1655898733714;
        Wed, 22 Jun 2022 04:52:13 -0700 (PDT)
Received: from [127.0.0.1] ([20.245.86.245])
        by smtp.gmail.com with ESMTPSA id jg13-20020a17090326cd00b0016909be39e5sm9076178plb.177.2022.06.22.04.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 04:52:12 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f1109179c77a14bed80be75bb297aac1ef867a49.1655891188.git.pabeni@redhat.com>
References:
 <f1109179c77a14bed80be75bb297aac1ef867a49.1655891188.git.pabeni@redhat.com>
Subject: =?UTF-8?Q?Re=3A_Squash-to=3A_=22selftests=3A_mptcp?=
 =?UTF-8?Q?=3A_more_stable_diag_tests=22=3A_Tests_R?= =?UTF-8?Q?esults?=
Message-ID: <4f2ad0c5-2667-c62c-b485-34923aa8bb28@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jun 2022 11:52:11 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6497233930551296
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6497233930551296/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): =
selftest_mptcp_connect selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5273199779774464
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5273199779774464/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/9c6d0fe8af73


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
