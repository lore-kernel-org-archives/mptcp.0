Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3556A7C
	for <mptcp@lists.linux.dev>; Wed, 16 Nov 2022 02:38:09 +0000 (UTC)
Received: by mail-io1-f41.google.com with SMTP id 11so12288630iou.0
        for <mptcp@lists.linux.dev>; Tue, 15 Nov 2022 18:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2/CVoWLF0p305DFSikXAm8j+yg2RqHyb3HVmjY5H+E=;
        b=IQ0I0kEcoR+dQwBwSz6jHPkVuiSPcyUKIDz7cnBKLqC1iTfaewjoXA0RxIis8vbxlr
         F+nGor22KYG/91V2c+VU7lNBc4uzbI06r1vjtqt1qbWJ78dTE66yNse9xAT2meodp8j+
         /ZwM79mx6ZtKSdSVJAXBrdg2LYsTauQlLQQsbkOilM2+BX/F1UvurwVui3/hPIE+O0IW
         Ii3wdeLQB7PcyReAsutMNvMvFS3165TloUlqg32M1As3cJ6+ZL4QNMkgLSG73zN4sJtU
         CtSptjZLY/rkb6DioEV29fxCXFTK7aH4Q3W4k7dqh5NiEt+hDVWMjN+3Qa8Bi/OE5tnr
         D7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n2/CVoWLF0p305DFSikXAm8j+yg2RqHyb3HVmjY5H+E=;
        b=qcEoC5Sq3c51AjRMcXtfFpNm5gDr2qDKXtM5WZQd/XaYGmb0qcUxU0kITaj7AZI3Fu
         HhJVRwmKbYGE1XUUa1P9s4Eb8q03iWS7I9nd05Wg/PeAFaUUxpuHvFFGz09qm7ygsdAQ
         bUZThaKQ9uD6feEt5EY0wgBUGyO0Ska6iJoz7sHdEhzGhkq0DJH03BsCIYW2t+L93VN/
         tzSkth97ZT1EF1sRRWgNUDz1LZoqVN47FhQFa0jl3oj2SRsHBb/bQyTRLQ39KpIHdQ1o
         kZgsncg2reYqqQnldshEFvzjgehB0K2XVNWW0lmMrvfDSMgQknE2VsBSkxsqQ4gGoE3Z
         mmxw==
X-Gm-Message-State: ANoB5pnDObWantmukK89JpC0+WrXaiPybrjzJf5eBVY7FPLVi8Gw+wFY
	qwRiaf/lzDcQNYTk9O02nvi89MQndBlH
X-Google-Smtp-Source: AA0mqf6YXIphdjokTd1nNBJHmlIYkAwTHmh5o6kVCuHDHRaHs3WosX4fw+R/1pKZTZTrIr050j4Q5Q==
X-Received: by 2002:a05:6638:3f17:b0:375:ca55:284e with SMTP id ck23-20020a0566383f1700b00375ca55284emr9610872jab.248.1668566288285;
        Tue, 15 Nov 2022 18:38:08 -0800 (PST)
Received: from [127.0.0.1] ([104.208.29.158])
        by smtp.gmail.com with ESMTPSA id u4-20020a02b1c4000000b003762eed554dsm210783jah.84.2022.11.15.18.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 18:38:07 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d1d8d0acb444c6ac39eb6ae945bf439d633e74b3.1668151131.git.geliang.tang@suse.com>
References:
 <d1d8d0acb444c6ac39eb6ae945bf439d633e74b3.1668151131.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests/bpf=3A_Add_?=
 =?UTF-8?Q?bpf=5Frr_scheduler=22=3A_Tests_Results?=
Message-ID: <d8170a47-05db-8c70-4f2c-b85ff0e37e78@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Nov 2022 02:38:06 +0000
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
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5459335883522048
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5459335883522048/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6585235790364672
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6585235790364672/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/4174181fc84f


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
