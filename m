Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E061B322E
	for <mptcp@lists.linux.dev>; Wed, 28 Jun 2023 17:08:26 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6b72c4038b6so4141498a34.0
        for <mptcp@lists.linux.dev>; Wed, 28 Jun 2023 10:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687972106; x=1690564106;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pazsLZwNktyE24Ii29qgx51lGkLqOLJuMxm6aN6ty8=;
        b=ZTLYEm8Os+FJZxc6kkiwtj2HIwx2dHreHaIXkhDRi4pyMBod6wovzcj2cp8cwxu4FO
         R4nylo4y5tgbK667XcLUN3wPCc1EAVES0vQu3xNkdFiGWA/5IZE4zHzq3zA8i+qRR9AA
         Z4Qk6jyDLe1VnFmGwKgSzt6bZ0+xt4mqZZZOpp3iJCtXCeCqH50TXIPX2Yl/6snskvvi
         kmkMx9Y2mAW0/EZkgXFeK4rILjZWkf/PJ2EzyUj3OIcgc7KwOESag0rEgkeMHKINrCDr
         HciWVW4eTGrpAIgZbN9GYVou7BPwy6tUh5KZIp7EgoVcP08bHXluDPzBe2YnZErkMI4Z
         AXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687972106; x=1690564106;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4pazsLZwNktyE24Ii29qgx51lGkLqOLJuMxm6aN6ty8=;
        b=PGIed27PUsqYpLZoTbN+DOIroZX67vxfEnqzTiBk1K58mtG/ZcGPnBKvajYpWVTQ6j
         JUeB8flcmDqX6mcmqtDt1EGgSk+4KIiBiVvPmHlmwLVrEo7bD1Vx87H4ZhuCU5/EF0se
         qOSr26E6W/Y5hEh9m7tTM85WZw+W+C4d8lHVTaKVULpl4JYhAPxqH1T3ykg/jkj1gSjA
         CGADvPUud0EQ1moKdoLbid2ExylQUwQZvWm5DXYHusYHo7zjJ/vI7/GMCijTJCoznFNi
         g4XB6cw83pcKsfVkBeS3OJBvcNF44zmygnVju/kWT6tFnmLykfGrIGswFZ/98z7o/XOM
         L/QQ==
X-Gm-Message-State: AC+VfDxgVeIei8xub67oTAVnOnihflRxPKByQ8nG+7GZE7FxpxgYRjmd
	Zbg9ymV6sq6e4JOuT/Um5zZsMosKLw==
X-Google-Smtp-Source: ACHHUZ53IAIms4ekvOS5+ngRR+kmC0xZs5Rf1pAO+f71HgxG9GRExETrSIDq7NZAgvyW9cWF9alYEw==
X-Received: by 2002:a9d:74ca:0:b0:6b7:44a8:cbbf with SMTP id a10-20020a9d74ca000000b006b744a8cbbfmr9391939otl.29.1687972105789;
        Wed, 28 Jun 2023 10:08:25 -0700 (PDT)
Received: from [127.0.0.1] ([40.84.172.115])
        by smtp.gmail.com with ESMTPSA id bt23-20020a05683039d700b006b29a73efb5sm4781404otb.7.2023.06.28.10.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 10:08:25 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230628144927.828117-3-matthieu.baerts@tessares.net>
References: <20230628144927.828117-3-matthieu.baerts@tessares.net>
Subject: Re: selftests: mptcp: join: colored results: Tests Results
Message-ID: <547d4737-16d5-74f4-5abd-60e291387175@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Jun 2023 17:08:24 +0000
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
com/task/6223547677278208
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6223547677278208/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4816172793724928
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4816172793724928/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_sockopts =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5942072700567552
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5942072700567552/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5609745210408960
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5609745210408960/summary/summary.txt

Initiator: Matthieu Baerts
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/07c93e69ca2a


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
