Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B54E211A
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgQlElyh"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-77574dec71bso454512685a.2
        for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 07:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697035583; x=1697640383; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7jZpvHF/TqS3BVCiwQoLxst+B3zWbn05HQlD/1lVLE=;
        b=lgQlElyhoPUHWmp5sZ4D0Mwiwg4FiMSG1ROKm9loKlq5eQw3v1xwIuTwdabRz5ZaKR
         44EoS3ftwoS3haC0AQwp6EtirgupRcyfq/bofnEAEZ7lEuiB+8L5Ije/UJhbj3AnfKON
         gnFO1riMyGYR3qODcJBXkD/pSVEbqJYWZkNn3lHYgPvHnQSqKOV01tMHV5Nxee/l8N+x
         iA1MSm+inr66On11pYLJ8iaOziN3s0BBgiOtZC0R6MwFRYZdrcRXXF/jbwJEceC5Jq4e
         y1HnO7d3mU3x+/oPyCQ4izesoaU0bweNRbGr2CJYkl6ORX9trWyDMi+oeWBkD5wlkKLj
         V3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697035583; x=1697640383;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N7jZpvHF/TqS3BVCiwQoLxst+B3zWbn05HQlD/1lVLE=;
        b=KvVixoYxTO0Fd5G4W+83vsDFXbigDsXp9vn7gmtAkvsTDSvgMLRI9oeMIClLCnhNLG
         MJ2geypaXvh0epJi3kUOsZlUeslJeIrkBSLPNSOf07tg3GKzfdjU9DjIBqcoapeZMlYp
         EZNAmbMMBXOVndOuvJ80ycGF4lG1GtXLZl3S2DrgUPHpr3wVjpn56pwmqt4Y72V71kUp
         BuL9ZgCQ7OCFlFJRImgyGXo9+FlHRMWbtL1l9k9Luug2kR1d2C0eb1tUUCyQIbUxxgL2
         BdsVh0UXBtj0xopv5FaQS74PUVTBI5++iWfnxuad0ANCSdW1Uh33FMKR3W1Fopa1fFJt
         5SaA==
X-Gm-Message-State: AOJu0YxH3MYivMETx9iHM+LnW4zXurzywHzOuR2/TbgsJKbAN/DbtT/4
	oIo0EVAz7uMNX7N8F1uGoQ==
X-Google-Smtp-Source: AGHT+IE1zoI+5PMAt8fw7+eUWt1+iR2OL3Rb4ZFOkMogbgVIIzmEdG0ROoltqUHhgAC4NPsjf7rE4g==
X-Received: by 2002:a05:620a:40c6:b0:775:9a7f:71e with SMTP id g6-20020a05620a40c600b007759a7f071emr27307869qko.50.1697035583131;
        Wed, 11 Oct 2023 07:46:23 -0700 (PDT)
Received: from [127.0.0.1] ([20.49.15.229])
        by smtp.gmail.com with ESMTPSA id f10-20020a05620a15aa00b007659935ce64sm5250403qkk.71.2023.10.11.07.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 07:46:22 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d17f1677d7c0b65309c98f48a8b88e909c0558a0.1697031190.git.geliang.tang@suse.com>
References:
 <d17f1677d7c0b65309c98f48a8b88e909c0558a0.1697031190.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: userspace pm send RM_ADDR for ID 0: Tests
 Results
Message-ID: <ebc2d027-5234-c546-b8cb-b7de7855ac3d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Oct 2023 14:46:22 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/6688622972239872
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6688622972239872/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6432463807840256
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6432463807840256/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5306563900997632
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5306563900997632/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5025088924286976
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5025088924286976/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a5d21f5759cf


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
