Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0EA1FB5
	for <mptcp@lists.linux.dev>; Thu, 23 Feb 2023 06:57:43 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id a14-20020a056830100e00b00690ed91749aso2153932otp.7
        for <mptcp@lists.linux.dev>; Wed, 22 Feb 2023 22:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWkl6MjlViDZgtJ8Rj7Gzp0NX4WfyzHdOsuUqT3va2Y=;
        b=RK2f50LdJhtDO1Q/bHU3inBxi1/TzfEQBYggPF88ojHfzhrWsxz1YlOPo23HzWucUv
         kVLC7aROVLBrWXG2H70YbARoEwWb+hc6YC4FdXFGB98inY/RdGyZJ0UMsVN7slcfoNih
         oZjRez6e/ZmRn8jrflLB3x4JqoEUbslvRA91PMePgrdx4J84WcLviFCWN7K8PvKqHo2q
         vLvGY8RS6inr4/GgwwoqsiiiP3NwpuMubicBcoJzZ1Ua+Fbhf/t7aI/VkdxQcxuaxrgi
         TFT3zI+q3gWQ97YNE1QF1vAKw4nagHx/qlzgk7zhj4TFmpJS/9XFAvcbBD+x0A57COnf
         41xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cWkl6MjlViDZgtJ8Rj7Gzp0NX4WfyzHdOsuUqT3va2Y=;
        b=a8xY/J70UdIE8pcdJddUBRpF7hBlvoYWlR32RBvo8oSMtJlmMECuIdIsnndKyp/rvY
         O8CLcI2S41OoEZcPFwnRvhlpnSxlWfgSUiQFUoybb/ZOCiETYn6Z6tCaHgnjWZp0IOwM
         CJXXk5vWJDKKOLRywcEvfDhhi9teiY53ZkPQNGReLGyK7tUDViWtfYV2TxGNP7lLX8sm
         s9grDqsHUJSI5cdgW2jEBFCG7NDi//g3yGt9Zao8CuZGc5QIjsXZJEHc/msRIBsnRk0a
         ARjmZqBkYAptTgaO2LayyKd+XLi0w6oLbrEuN+QXb2OlRzmEzBV3rpJWNjwzKQyATUxE
         FWNw==
X-Gm-Message-State: AO0yUKXq6VBSR4gaCtBvys8Ffd0BiHZZUPKN0Z9L/laBqJZpre4REXtV
	DYPZjds5nOn4TC5h5xdj7uBQ3nbUFlMY
X-Google-Smtp-Source: AK7set/AM9l0mJtwHLelWgrBtgdN5J6UTnFX8SUV3fS+PWweS27Mx4rvHhJEVeDzFNQtt+sbn4/WvA==
X-Received: by 2002:a9d:378a:0:b0:68b:dc52:10f9 with SMTP id x10-20020a9d378a000000b0068bdc5210f9mr1329635otb.5.1677135463025;
        Wed, 22 Feb 2023 22:57:43 -0800 (PST)
Received: from [127.0.0.1] ([40.84.170.49])
        by smtp.gmail.com with ESMTPSA id q4-20020a05683033c400b00693bddab6b0sm2757048ott.31.2023.02.22.22.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 22:57:42 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230216-mptcp-selftests-userspace-pm-typo-expected-v1-1-e004734154d6@tessares.net>
References:
 <20230216-mptcp-selftests-userspace-pm-typo-expected-v1-1-e004734154d6@tessares.net>
Subject: Re: selftests: mptcp: userspace pm: fix printed values: Tests
 Results
Message-ID: <f787046d-aea4-fe89-cc2f-1048a133c493@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Feb 2023 06:57:41 +0000
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
com/task/6591063087906816
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6591063087906816/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4761475739287552
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4761475739287552/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5324425692708864
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5324425692708864/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5887375646130176
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5887375646130176/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/dc0521329467


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
