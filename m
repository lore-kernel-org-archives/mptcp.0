Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792940865;
	b=sxSjCRGITwRw2S0AjyVs9OFH8s2LaA3sWschO6uZb42Mio5G1aXaXwQd0uTXmuVXgJiK
	 MvmAioxdcveMwKcRGI06kMysfax3InFo3YCZcDcvoC3HX9wi9sgi5XH2Usaq9G7jN8Hgk
	 27LWJFdoHjHPxInz2k5fmdUiy9Bfbn1q0QACt0+dyUdmjRjKs8rj/Wj7/jP8g7p/yRojL
	 DUoStNYXhktAIdrYKiY3SSp5qEZ2n8c+nSm++FQGCfK5FHPccdaRNuKCEvA6oIGetL2dh
	 zVTqZjHYPxq+OhXxT42RY8ybp7LcWJzcDwCTqjqLg8WniHFNa4Rgp9s17+U+PCc1yNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792940865;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=y8pn24/AU+bTl6zImMQMns5f1FAUSuc77vACk9sagUE=;
	b=JeNvpZ48kwR2q8UdOT9S/Kqwqe2ukVGl2uz8Vk6gteoEBHIT3vslWL7YWaeBKzkJ8iAG
	 sdguXoHZJGTJV/IisgKm4OgEtWJDjH41FInv59RYUxqbBl+09hIVKvruCdJWLZBQxrENL
	 16BBRSjQt4CU9fo4A99xD3JC/crdFzSY5VhIMptglIF2uP2QhGEAE+dF8J201yOwknWv8
	 64sgoZ8V3pjAnCCmK6jsd96dK1/k2t+xRsd5jRcN5aQmWfqAgeYyJkkKjh4XV9oTk0UhF
	 0Zy0qOYbYr/Vr0VJLbDe1USU8Kkcn2Dp4A78S+0p0g6vbryXqqOOZNwA+tWl60ajsdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RMZVBucm;
	arc=none smtp.remote-ip=209.85.167.175
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A16F606A31A
	for <mptcp@lists.linux.dev>; Sun, 25 Oct 2026 15:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A16F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RMZVBucm
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4d7034a99a9so1387756b6e.3
        for <mptcp@lists.linux.dev>; Sun, 25 Oct 2026 08:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792940864; x=1793545664; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y8pn24/AU+bTl6zImMQMns5f1FAUSuc77vACk9sagUE=;
        b=RMZVBucmHVvXl3+gMpS1omOStnTpSG4w9zn1Wl8wlNyNK9drwV4kRkPgvt+aF94lum
         XQFKtciubeCJKqC6AqlG3iyqBqrO8aXLjBLEP42xdVExOPRXbsUx0b6lbBfmRydXbg8C
         hUOj+15M2JY5+9ALrivbUyo0Bqn677RUr5oeIRyvthbHdGsi8dhDRzV/X4vG1op5d8Yh
         z+E8VQF2Vt1fjZA+EJEXx80S6EPY81HAL7S2aZtPOlDUW3lLjd/jmJRvGR0dbt/R2IJq
         dY9fJkewlvVyG/RXR8arSTGRErBDvgxi13DE5hMSB7Ud3Z/sVrsBzmi3n5WFmuSoyZJS
         9bcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792940864; x=1793545664;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y8pn24/AU+bTl6zImMQMns5f1FAUSuc77vACk9sagUE=;
        b=kaSPxAieaTKQHIYpHN4kzoksvEIyIjlhr6Ea2eerH9xxAzEOHmHBjSGMs/dm6Foccd
         xSfTuN0mgw0NgpuLAZCmxA6nWtT7w+ogrCOT8P+UuMN5hE8fMl6VJSL7PXCOojWMrRLN
         amXL+htkCijbQOtjaM25IU7XaMg02b6uR7Z8OQIf9+aN/OFdTTIWL0B0cewF6yIVvhBn
         usunAdtCzlFgVgLPqrxXYKVuUhXu4IC0hS141nTV5h3waNllpk7fz50+qzA17+bcFt37
         zgZQjCi4SA5fjaiJny5GhziJE+t+EFFznSSIhRbUaPi3vxHf1MctK4VgB3AGuuK3pTrU
         O49w==
X-Gm-Message-State: AFq9FYLAgUYrO/bcuUN5HaQ90B/SkpM1LTCMJdhNmG5HlO6bA5kJTSJB
	D9685mG8IahyxNl976izwtxXZecTUmZK1gkZI2DSZzQCoqA05eHRd4Q=
X-Gm-Gg: AYBFou1+c4aQo1Gz5IExuPZ5UK/YA2WTQwT48sRJvz5JX9tQUq5RyXa+S/dokZa5l4G
	a3sICL3Ode1oC39XkTFDX0RGWnjPshMKaLSf/1T2Bgh5jN6HxPC+bG76niy7ASGQzkw9ZQIwSHJ
	2ICViBcgbegIbmr83mleVjgUMmlH7GDI+Kht86kK7j45WuyZncOuVr1S0AdE/zIXNfMbbQHBr6o
	NgzhJeZ9pfkXq+zqPdvI+NmY6FhfQXxD3laI9jO6ujcb9DV6lUUF9HiG4wUd7Go75HUDILaAQcu
	qiVQxEoai7eWvGHF291lXVrNSZpGqz52pbrB1IKJxRvUZqw6aXHITtF/R5fXYNRae8KuoLCqJRD
	r9ZSQbLfeTPt3ckA+GCeSPsD8PRb97o5Okbc4M+f4kynZ3e+YFp3ykiqhA/NFo7dSEDHAPZMMYF
	0m7PXV9d2Lcw+5AtqHli+qfBpqCN77puDOPrr1rvZrRedZPhrcCcFhNdtx0D5dkEEUGI7S8h71T
	sZehV1I2DpMt/G4G8RORZm40XCT0OS65D1ypKHPOAMeiohEX6by5Z0iOb78YbpE+CDZvQ==
X-Received: by 2002:a05:6808:1510:b0:539:ad19:d0cf with SMTP id 5614622812f47-55c0020b600mr2856324b6e.20.1792940864214;
        Sun, 25 Oct 2026 08:07:44 -0700 (PDT)
Received: from github.com ([135.233.180.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c04074375sm3413000b6e.1.2026.10.25.08.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 08:07:43 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Anil Kaushik <anilkaushikwireless@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261025134909.2794368-1-anilkaushikwireless@gmail.com>
References: <20261025134909.2794368-1-anilkaushikwireless@gmail.com>
Subject: Re: [PATCH mptcp-next v9 0/6] mptcp: pm: in-kernel: retry subflows
 closed after an error
Message-ID: <f75cd54d-2b3b-4984-1372-6c0f98f197a4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 15:07:42 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Anil,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Unstable =E2=9A=A0=EF=B8=8F
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/40200459151

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/65fbacd31d21
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1193019


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

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
Bot operated by Matthieu Baerts (NGI0 Core)
