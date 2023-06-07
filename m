Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B698234D94
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 15:57:28 +0000 (UTC)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6b16cbe4fb6so3152241a34.1
        for <mptcp@lists.linux.dev>; Wed, 07 Jun 2023 08:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686153447; x=1688745447;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoaG5Rzvduo8yscTgK4u6u9Sk4UMkfK+tm5Z+vecUKg=;
        b=iTIpX+vKZchATZMC4Qv8Ck5GZX0ICQVQFvWMYd8cqhu/OOi9W3flVGj88bXtK055O6
         A5bD/Co9rlfoenOHJ6VeQ+JSCGDKj41sH/+r8EfN0Py7lHvulcBIpdAnSSW0n3I4YBla
         4kF4ZVYQDJdMRvHF9MrzUWsmJitRESVrwlS7+wL/3lqer4ntYMHrIUjx7PRCzCDqHkwB
         mu5RO2v1teyDdQi6xEmRtBLhUojJoFYwol2Me4frrCTTb+rTT7jzpwb+pB3HbAzbO+Vk
         EkwOoE7N/l2UDw6xzLHgXM7ZFTw/8btv2dPamqHc086ykx17hQArbgJV01uq2e9qfwnR
         T9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686153447; x=1688745447;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zoaG5Rzvduo8yscTgK4u6u9Sk4UMkfK+tm5Z+vecUKg=;
        b=WtupleJ754JSLfT8w+TRP1cykiZ/6AZLRHRCBIvmu7FyRKyi2MJxQ2TfRHt4mr5A3K
         tVIK2LRNpvAGq6779Bta1YeaLMW/RuofH362kPcIM7YXQPnZsj2rOgSbkVPlwVDPpHJl
         pIjD2ySRoFk+BvPja+LZaBrlrMBA4l+n5Ympv5tUdx90R/W/Qj7P/YCS7bOkPUDYY/4s
         JPKttolZPqMTW/ecAW/rWvgxkDoYp/q+4Rwt1nN52HhFkB6bELhIvt/Nost1yq3z8AKN
         AnQzhPWi/hh6uX5cB+DgaOg9CaejOly2kCSXhZtV6Y+bOYJ1WXMcw047jxDXte6GYcuG
         5F0w==
X-Gm-Message-State: AC+VfDwHKqqD7adgaqbHznxlgSpg59ZUAOHitxhOb+B5ix35qY+mWz6p
	FVv+CXfaWZXgu3+7vK19xw==
X-Google-Smtp-Source: ACHHUZ6PsYTp7esfUTcpd5droC4cKzkAefAII9qNLrruFoBYJrgc8tA3ESZrwZKd9fKpM3pOMnPcVA==
X-Received: by 2002:a05:6870:76ae:b0:1a3:32df:eddb with SMTP id dx46-20020a05687076ae00b001a332dfeddbmr4086936oab.51.1686153447567;
        Wed, 07 Jun 2023 08:57:27 -0700 (PDT)
Received: from [127.0.0.1] ([104.210.132.89])
        by smtp.gmail.com with ESMTPSA id u1-20020a4aa341000000b0055b100649e4sm1443526ool.23.2023.06.07.08.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:57:27 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230606180045.827659-1-leitao@debian.org>
References: <20230606180045.827659-1-leitao@debian.org>
Subject: Re: net: ioctl: Use kernel memory on protocol ioctl callbacks:
 Tests Results
Message-ID: <db5b406f-6fc2-d439-6f0a-7d1f54660d5c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Jun 2023 15:57:26 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Breno,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5342605223919616
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5342605223919616/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6187030154051584
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6187030154051584/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5061130247208960
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5061130247208960/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6468505130762240
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6468505130762240/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/99a1c47994a4


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
