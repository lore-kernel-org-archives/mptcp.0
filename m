Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFB98C01
	for <mptcp@lists.linux.dev>; Fri, 24 Nov 2023 06:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAGf/zHL"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-66d0760cd20so12508256d6.0
        for <mptcp@lists.linux.dev>; Thu, 23 Nov 2023 22:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700805951; x=1701410751; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIPlbjPJ7BhGe6FoqcpJFkBC4NlZ+sPgmcnAC0H5s38=;
        b=eAGf/zHLQyZPMmys1FEfV7PT6VQrdngvUGo9RvdpS/yGK5v6nlz6UAGFPq20VC56LM
         H4vEBAdiJ/qz5gnsXCXatKbEKpdA3ErS26ifBtRoe516MO9/XyKFI/f0hH4340KOK40t
         76smJMRt7gxXTUWgdjr5dUNg7cYUffespanI5mBWkNhnYq7KtF7G5r8Z4vnEDd+s5hy+
         yp9APo35RN/lyVOkcGzCpCnUraxpzwCfwcVLZS79U0yzP/1tvKQQmco+6eqxiJDsIL9d
         ATW9zgDY/QqFk/UoVE+89zx45g+h6g7vbNVyX/slDm7uoa2YJ2AlrLiordWesNrxaM8X
         ysRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700805951; x=1701410751;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BIPlbjPJ7BhGe6FoqcpJFkBC4NlZ+sPgmcnAC0H5s38=;
        b=p96eepQ7tiSvJlbpdu09SsEcxHkgmj8bJInPcrfemhY7uuTweZHP+j6H3L8TZSfzbh
         pdrSbonqSIC0hK8M6MqfBHEXjGPCln/HNsWnqqSIKFcafIfLwiqazib98lt8y6DvWxBA
         tB9dzWSRTzPVkuAzpJnjA7LuJsmYXiLmeje9vPpwz8yajEQKi3rufloYjrEux65/kSpw
         Gb0YA2BLu+YHDz0QP3X260Q7drtjGqkqFGKCiIkfCGirdI0nOc9mQj1+BTQ+TSP8nD2C
         mCJHZQ97aJUgEZEdzL8LAyDcghuUD6LSOMtKSQ+VVaQQJNd7Ya3+O6SpM1RwqwDMm0Jr
         SOQQ==
X-Gm-Message-State: AOJu0Yzjh2QUArmGTq0Xtn8ZzBb0pUjiysRypbLyh2tE0hFS0Vbw9s0d
	de1AqlhrCiiFelV2NMHFvw==
X-Google-Smtp-Source: AGHT+IEEvx73TerXSD7600iVb4/oDBQMI5KYDPDYu+M/u53IG6WNxgoR/paQ9OuGjRKdAabwcEIHLw==
X-Received: by 2002:ad4:58ed:0:b0:67a:315:88b9 with SMTP id di13-20020ad458ed000000b0067a031588b9mr2302063qvb.16.1700805951023;
        Thu, 23 Nov 2023 22:05:51 -0800 (PST)
Received: from [127.0.0.1] ([74.249.14.176])
        by smtp.gmail.com with ESMTPSA id m2-20020ad45042000000b0067a10a23a9csm522902qvq.49.2023.11.23.22.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 22:05:50 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f45ddf5a45d0c8052406679ccc6a10e2de0f74ca.1700801705.git.geliang.tang@suse.com>
References:
 <f45ddf5a45d0c8052406679ccc6a10e2de0f74ca.1700801705.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests=3A_mptcp=3A?=
 =?UTF-8?Q?_add_mptcp=5Flib=5Fcheck=5Ftransfer=22?=
 =?UTF-8?Q?=3A_Tests_Results?=
Message-ID: <a37025e2-32ef-3bbf-927a-aea7addcfea2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Nov 2023 06:05:50 +0000
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
com/task/4570409761243136
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4570409761243136/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5696309668085760
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5696309668085760/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5133359714664448
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5133359714664448/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6259259621507072
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6259259621507072/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2c1009a9ac56


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
