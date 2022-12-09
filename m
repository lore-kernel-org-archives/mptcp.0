Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9B4802
	for <mptcp@lists.linux.dev>; Fri,  9 Dec 2022 06:01:35 +0000 (UTC)
Received: by mail-qv1-f51.google.com with SMTP id a17so2537279qvt.9
        for <mptcp@lists.linux.dev>; Thu, 08 Dec 2022 22:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqvOiK2s4bccAsy902pc5YGDGWL/7gxoE2Bk2CEFVkE=;
        b=apLlxTMF0h/KP+rrSP/SeKBq0fVd/bSaqJqtuKkQY7UPF5779CW6U69ayiwJRZXZlU
         KfeEjPBx8nxe2AY/MInnRw4Zg6NMYCrF/q79/5BolluhkOXEKcba4BQRsTc6YSgAUSeh
         0i+WUFQnriZ5cfeQTzG+KkLiwjOoke4JKfdndfUbBo/N1Upj8ayViTB3uL9sWKwbtQph
         1KvMPrhULnWPt3WKeUWIc1gv+XtyxGKijtZ+N9YTJJyiZk/2wrVfeXP5beprgGiS3DIw
         GzmCMWdyCWNNf2xPefcWbZFtvMgNC4WABsUvxZPaFKGYNR9M6GWJBV43yA8le5n4NYeY
         OYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LqvOiK2s4bccAsy902pc5YGDGWL/7gxoE2Bk2CEFVkE=;
        b=6fX3Ij7lT6N7u64/63Xo49vHlBh5tNRlMhCdRCxHONfL62253LUqMu1Ilt3PUF2PJi
         eKherDXHOi7o8tQLq6Z1orqYnYPo3utrpodyvK9F7zWD+lrNUMG+b3uNiMSSgxc+wwzI
         quSHbqk6iBtsro63l0AGiZ/VRgFwhGEXPtrmIkdsssVAWe3MPGXDbgI96t1Jwv9JQ0Ne
         sWKWfbNF1FEUAIhvVgvTaU8wv5s/2cfj90xFECkscV3TplwjSRnzqHeDYBb2NqOWOZRJ
         kSeOsrAWrr/kJ6wgqrJHZFtOhYkv9BWMo2xYq4pZQwKZr3EkdUABmzEjprmvoBcdqXe4
         0jmg==
X-Gm-Message-State: ANoB5plrxvUoOBJhyR4j8wxm0++mjSJZy+ndH+TqmcnFbowexfROxND0
	hK6iHjp7qpNJu2yyPj+qKQ==
X-Google-Smtp-Source: AA0mqf4laVNmqX1xz2aW7TXadjvFHwvVVrC0RRO4HgbUUwEK/LDu9sc7faSbPQYWw1Zbrx7FWHEk6A==
X-Received: by 2002:a05:6214:584e:b0:4c7:8094:ecaa with SMTP id ml14-20020a056214584e00b004c78094ecaamr6000326qvb.44.1670565694513;
        Thu, 08 Dec 2022 22:01:34 -0800 (PST)
Received: from [127.0.0.1] ([172.176.196.114])
        by smtp.gmail.com with ESMTPSA id b18-20020a05620a127200b006f7ee901674sm475901qkl.2.2022.12.08.22.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 22:01:33 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221209045925.20408-1-geliang.tang@suse.com>
References: <20221209045925.20408-1-geliang.tang@suse.com>
Subject: Re: mptcp: use msk_owned_by_me helper: Tests Results
Message-ID: <f1c1a70a-c182-d1f3-d82d-5e6ce49a2004@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Dec 2022 06:01:33 +0000
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
com/task/5565945023299584
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5565945023299584/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6691844930142208
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6691844930142208/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5671498139566080
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5671498139566080/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4545598232723456
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4545598232723456/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/6584c376da35


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
