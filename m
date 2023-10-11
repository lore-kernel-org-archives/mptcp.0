Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2494A1A714
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mkwk+4iO"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1c9b70b9656so14987795ad.1
        for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 09:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697041887; x=1697646687; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJFwwMKWeMIbN0X1Um+DyhIA1lzxr5Bj/xRMay9OJF0=;
        b=Mkwk+4iOX8oBtCqhqtHp/32D7/5J57l2kQSoEp5UhBiARaCLOj9OrZlHUTQbLRdGGX
         ZAbK77ksd9ROiWlMLtjL2AFGzMpYy8vgIiKAnpUDxsOWN7UQXl9EWVG1TtGjOEkWDx0d
         IuHtUQT9XHvVtdkJQB7kXLJxX5kxg52ASfofZMbJo8oZgbvxY7oE26JW91aCLLay9A9d
         F53HKBgZgjw3go5quc3JAZUJVDAuHtRS/dPcQfyYnccqsuTSs6Xt6dlPUaKJFk/ls/1p
         4coDhe5jcl8XqOMN/LrKj0xMsf9DHf+8TxuZQ48CZR2bCaoqZ0D3iQ6aUlympFL3BdQb
         cDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697041887; x=1697646687;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mJFwwMKWeMIbN0X1Um+DyhIA1lzxr5Bj/xRMay9OJF0=;
        b=qbCvh5J6SIVk3qkO7CMnIXSl1X4gINxB1kSmfJy6cRh5u6b2CHgNaVmtSeSitj5mAN
         dJPnqbKnK3IqfOJI9RRLMhhUvFBG4H05DvOUfp6aaAmtXSCnA5Jnt1MlDHyPFsQE+vKg
         m2PN92vKd4U4g/ZoGbkyNhGH8XBFrKDe7JAZYwO8aXlnRS45FBkXk2IjLDpXNeQu6xMt
         HDr3kROpcFDIJ+hOV+dxUo5JeUV6wMlSkc+e2/phx4Aq+UcSWkxfUfO08AZlpsfmM527
         T+tgJEuUYVhinI1mmMjVmkTBzbag26cF4n6r0Xkchi8ZwwsN2oi9v234IDcZ5gpBe/80
         hiYA==
X-Gm-Message-State: AOJu0YwBodO9S/4zpC1g71cbFGj7AaNEhJge2Dx0yaEsrGaTyXJIf4QR
	/vPYuW8+Y08uOjV2pNuSpg==
X-Google-Smtp-Source: AGHT+IFBbUIwnL53bVBWrmy21nKaptxB83pw3j5EELZgmDNf7eJoQPi4LU6NQZtwZXIw99asCITXeA==
X-Received: by 2002:a17:903:54d:b0:1c6:b83:4720 with SMTP id jo13-20020a170903054d00b001c60b834720mr17235778plb.63.1697041887336;
        Wed, 11 Oct 2023 09:31:27 -0700 (PDT)
Received: from [127.0.0.1] ([138.91.87.61])
        by smtp.gmail.com with ESMTPSA id ja10-20020a170902efca00b001c62e3e1286sm33342plb.166.2023.10.11.09.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 09:31:26 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f1e771e52c4dce3db4884ac0e629d363d1676b75.1697037788.git.pabeni@redhat.com>
References:
 <f1e771e52c4dce3db4884ac0e629d363d1676b75.1697037788.git.pabeni@redhat.com>
Subject: Re: tcp: check mptcp-level constraints for backlog coalescing:
 Tests Results
Message-ID: <8863dea9-d199-bdeb-38ac-eeb531b11a07@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Oct 2023 16:31:26 +0000
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
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5873231270248448
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5873231270248448/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6659777703444480
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6659777703444480/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5533877796601856
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5533877796601856/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4619084122292224
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4619084122292224/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/8c2c2f703336


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
