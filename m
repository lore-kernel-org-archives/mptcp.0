Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2559A3239
	for <mptcp@lists.linux.dev>; Tue, 27 Dec 2022 18:57:24 +0000 (UTC)
Received: by mail-qt1-f170.google.com with SMTP id c7so11094240qtw.8
        for <mptcp@lists.linux.dev>; Tue, 27 Dec 2022 10:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmuLWW9Jp6YvnjhIgS6mRxb8920U5llifF4o+wblQdU=;
        b=iz2R9zSKJCu3Aa5ZeZAbNsbNRznVeke11T5lwTQGD7U8o5egKfZA/jAE+1VR6umiFW
         4JI6aiC4qK0Xf/+BGFKeg/wHOWCfIRmh47fECOMwZOX6iAD7M2O5gfxEqs1hVyEus8yI
         XO/SXQJTVp+eM83xhCFXNPrRxVNgfjYqp2HdCkdwq30zWMjpUeB6WyZ33Bs2KZY8PGZk
         dnqOJBl8Hw+Af0tknIdmS5YCMak/0pFcmOWvUxD8aLQttV6G9XCCUjv6Oa/baeL0hkYI
         kvpEitr8kbYEmknXS7jqkhKd5xUgVBSFZfblca9YkoDLwMhAbuV4eoa7s6glNtBVmRKN
         ieoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NmuLWW9Jp6YvnjhIgS6mRxb8920U5llifF4o+wblQdU=;
        b=eqf4PruyG3oawyVy3F/l8c/QYtcHWijisIZFKxOZffnkYG16HAhSDfvTPq2aFXxES4
         /FTZgyr62VnJBG1dWZWq5MISqChBEfP81AxfvX3lkYYsXCANUI+42Cay5LfP2ZwCeg+c
         UijXbRxjNkD+RJmpuAxEwH2kOoiMPF1+fF2Wa0pjQe1HdvjQrK1VrF7Dd2guPPNIprTL
         aNqFfc3uWuAge5PzpKMCIpv39x73ydxxuCUL8C/E7TObj1Za4QSnRtrCFn/L6Ssj2Frn
         LbkV3j8ehHf4bnYMY9z0VZBh51cP112kvXgl8EO7U+ktgygCElLAcioV0dl8YdQd0Cst
         8Lfw==
X-Gm-Message-State: AFqh2kphkDHfQHkpt6GNu6I8l3bd6j+ZNhF1FPThTkuFwm2PwX4asejs
	A5kx1gbJucotepNP7FVL9Q==
X-Google-Smtp-Source: AMrXdXuvNaZbUeJc2itFBZ0/PDtqztiY7/ggKq2ioI4WeRnxQfQIV3HIYWNKY7lb0j9G2hD2BztVQQ==
X-Received: by 2002:ac8:66d1:0:b0:3a5:9267:ee07 with SMTP id m17-20020ac866d1000000b003a59267ee07mr31028853qtp.63.1672167442899;
        Tue, 27 Dec 2022 10:57:22 -0800 (PST)
Received: from [127.0.0.1] ([172.177.2.97])
        by smtp.gmail.com with ESMTPSA id cj8-20020a05622a258800b003ab7aee56a0sm5845869qtb.39.2022.12.27.10.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 10:57:22 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221227182057.2288816-12-matthieu.baerts@tessares.net>
References: <20221227182057.2288816-12-matthieu.baerts@tessares.net>
Subject: Re: selftests: mptcp: userspace: print error details if any: Tests
 Results
Message-ID: <2023624f-f4e6-ab27-59c8-d77373e4e6ec@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Dec 2022 18:57:21 +0000
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
com/task/6455355476017152
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6455355476017152/summary/summary.txt

- KVM Validation: Script error! =E2=9D=93:
  - :
  - Task: =
https://cirrus-ci.com/task/5610930545885184
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5610930545885184/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5047980592463872
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5047980592463872/su=
mmary/summary.txt

- KVM Validation: Script error! =E2=9D=93:
  - :
  - Task: https://cirrus-ci.com/task/6173880499306496
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6173880499306496/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b2729de9466c


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
