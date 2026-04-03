Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75E53BED24
	for <mptcp@lists.linux.dev>; Fri,  3 Apr 2026 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775226317; cv=none; b=IdkSGJ62yBOdKrTejyLZWEsOBEfTTJm7g9KTJ9I96wrYx1NcQDkolYJ2fYkBMqJ4qLQQiy5lYXi/Pv/sIdNwU6X7ruRfQXVJ/nQlbdqU763DDomD4jh86ZdCsQyz6vCh4dF4Krbu6opPNi4ykaM2+Ji3rWwqqZk4QJHuELJon8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775226317; c=relaxed/simple;
	bh=G2AkWEu1Acw8mScTcOI04rM7TVn1POruGEMiOSF+7e8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=XctDSc89fIt1dAX9mjnRh3HNVkeF3tMfsmXJr2HqNUJ9jfDAOi0j6RZZY/FAfTOR8vmtFK3EbXWHJ9ddbCDkhR46d7B86CyNXOslUrKKiJ+blPBmOZ85bWlYlAUU3PtXVymePYAVFFR1QRenEdGmBGIshSBkrEZx7Rvw+soweb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVm3JsBu; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVm3JsBu"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-89cc797547fso22475396d6.2
        for <mptcp@lists.linux.dev>; Fri, 03 Apr 2026 07:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775226313; x=1775831113; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSLaIfjil8PQHAtYdIsLHVlI/5tIxGeKRKWoqcBUHhw=;
        b=JVm3JsBuMQSUVKE5RwbC1vRemk0HQO+q2vFGeyR1R6e+z20xQGTEULI7PWnRJC3Yuu
         3DL+6eyYrWplk0Ix4MPRv93aCtofUXKp73CtLLSlMNL5Ulvy3qtINdPXS23QWZGRvRi3
         X+xofxMXmtTxCI7dct7DW5jA9ibJ3LTmV8Wh4SPIF+vhwEHLjEI6OZVD1592qJPwiBSY
         4OV4wwMh+61qgiFaO1eHKYCz7HjyKgD/10VY1iGpcbDQrheJHOJYGzT1nYrrjNUCzIOf
         yGXm0Kx/+8Vj/QELGlYhiLXczNAI8qtApvMK2JdMsjQ15GE+kcVx8EhUzlaf2WrotRoS
         /5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775226313; x=1775831113;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hSLaIfjil8PQHAtYdIsLHVlI/5tIxGeKRKWoqcBUHhw=;
        b=Qj63d39sxSoFQwMQkWyPWUUkF3Dp77KbtpGs4acO6uK5zlD1cMaBvd+f25GV2zA/pC
         qmgbvPNg0iP2kcv0LCT+X4ReWDVqxISPfl/jzRp0cBOQwHJB2S7o/xapfYHco71CqUzS
         N5MYRHL9OADtlpYf7x3BfP0HOSCWdIrDHtr6dJYnHBPgRpwpyv4Ot/lq07KlbIQRVMa/
         hRJRCAZY1lXRP3JoBg1q/iDyyTeJO7u0lY3t9k/0ilQXL332ZZRLMpmb/PaiTyDGoCcd
         f/dA9zuiKVdnlqHvJBaklbIxEWANgp2b+SYS4vuly8PR6P+NpWfJ3pLj2LikreVOZnm1
         uNyw==
X-Gm-Message-State: AOJu0YzdrjRho2p58Iru0nnPWnxopu+6xD/ors5jDaacqqdqH6Vv8W7B
	cCrgjU8NNFIYg/kKJqfgQSVhRcqBB7Q7VVMNdnBUfmxkjC6Qi316DgfNUqGP9gM=
X-Gm-Gg: AeBDiete62p84ipO3//5sC1V2DPH0x1MyGB0HHiJcYRLK8A8jmZQlu4PerX36PSyXnS
	ujmvVT9JaPMbykOIiTOtp2sy9tGpQ2NZBYmpJ7cV4H2nvVoO/KmdfOH1qOqM85L32mEVgSxqrAx
	ZGNDXGd90OpxvELQkr4LDfBtXOq4j9UJrb7TekNUXE5Ps0nCB4d188irgiOxOfNyeuZbY8GvUts
	RlMb2gKKY7RXqBoH+buCibreyQ6/AOiXr1KbNvnqqsmWrrtSj3z8LzgHBVgUi+DgtWxNbaC6pGe
	YHHNoFFI6cfVc0flXy6MfURbm7mbJuC+sCJsdYfYha1/0I9n0mPGPhaYZ0mPxjOsK7hnYiZOCAh
	Ms0xB6nR61DB53Y5kBUjlfvkCGkzUC+ulCZFibvRfpjsip6fprPGk3gck0nOmggK+pl8syozKXJ
	6t5GzJuAylPfA8gRKVhym/ygSxWE6cl3W15Krm57M=
X-Received: by 2002:a05:6214:4c92:b0:89c:e371:2b4e with SMTP id 6a1803df08f44-8a7025b53ebmr48189496d6.17.1775226313410;
        Fri, 03 Apr 2026 07:25:13 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.221.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a5933333d0sm56161506d6.1.2026.04.03.07.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 07:25:13 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260403130734.93981-1-jiayuan.chen@linux.dev>
References: <20260403130734.93981-1-jiayuan.chen@linux.dev>
Subject: Re: [PATCH net v1] net: mptcp: fix slab-use-after-free in
 __inet_lookup_established
Message-ID: <794357c2-e1a9-f78e-b43c-0f454224b023@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Apr 2026 14:25:12 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Jiayuan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/239480=
54233

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/df0f3b32e603
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1076991


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

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
Bot operated by Matthieu Baerts (NGI0 =
Core)
