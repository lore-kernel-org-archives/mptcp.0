Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8999378D72
	for <mptcp@lists.linux.dev>; Tue, 16 Jun 2026 14:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781620344; cv=none; b=qINxBvhobfPmCdSp9xL++PVsyq23EwoU+6ondRd0AB6XIFV840AaLAsPiGj2JDW1FzH1+nMB1zbATwvDwU/r8MohuiPSUl96VmCkiNZ+PSRZ7PcQefYkwp9Q57qtIk8/bBPJvAeCyPm03W9mu6SWdJg4OC9xxyAkZTqIhSzZkNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781620344; c=relaxed/simple;
	bh=o7sIPBZXb1mkdi7Y/qMj9wXfyPFsA4Rc+HgvHQz94Yw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=IUp8Dd77k79fVHuwbRj1fofGCq091BW3NMpOmOm+tP6V565976cXg08IP9KYLO3p3GjnwlxDneScBJaINJLWJptEzVh0Er1FoLQZxhbPFa3NIfBBVo5xkcQ0RaCQkj1+nAwZh9qLVq9iaOvFJQpYDC9hoL6/fSUQerUbPQv2qEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAOGSl1B; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAOGSl1B"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30b6dad2382so4599325eec.0
        for <mptcp@lists.linux.dev>; Tue, 16 Jun 2026 07:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781620343; x=1782225143; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9d9o/vRJdrvCAun+wmY5C4nEqvwHhmzuRyDGhKRSn0=;
        b=DAOGSl1B0ZjKM+gmGFMrPYfTek2L1mAsOzSN3Of21Hm4kL0zNyWQ/+Ro3+i4beJBb3
         sofkTrdlyBoouXDxPzlOAQhFfa1s7hJMF4T1jfopgYhdjxSzj9fi421rrBP2aAANakaO
         huYqHeZcPT0WXP91/7fKhcTIS1K7RZbFwR+hmUdc6ObwCxxb6JmnKMiV8ugqcYVuWk/L
         iCxmPXgaLx2qOgqq4UAgK1HycyxDUn8iKAJarFBWNK//OU3wf2kxjK5dSzCrRmimyDH1
         +a/6vIiomap2dq54GuVrXO5GBdGa1jRbAtTkRY94n/fpTloAaaRs02WJR2qpNBpihHvm
         vUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781620343; x=1782225143;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y9d9o/vRJdrvCAun+wmY5C4nEqvwHhmzuRyDGhKRSn0=;
        b=rIrqF7eoUgMreEJLb1sq9vPw6SZQKZMeD+wFaT3gUrCCE8qM+m2wcDSMaV1qKMrC8l
         Lz2cYycZDrlh97h1MJyllIRm52c6XJXyToX/Fgc59WB6J33hsjnxVPkSpESJbqrcT7j0
         q7uTacrtAlQr4C/viLwTdtw2Tpe3+f0xyFHOR9yDEGNXK2DqysOJ999wbvHKw6J6pY89
         vpj/duGPzCpTQVgYfSnCvc0u5JXSyHMbYX/1yVk86JepmzHuw/lfQiNeyfDa0CQoIgWX
         0zdEbNkYmoODUaYYDn1/50HD1Vw2kQ8YABTlh5pfAfJ8CORfCTa+5fi+HsVvcfuun8tV
         l7Ww==
X-Gm-Message-State: AOJu0Yw6S7PwVJdB512eY1mgBvBCmPjfsoeMW5Gu4UVK2+7PFeUEVqoR
	R84XEzWuzK4oKlSPiXBYb50o5WR0K/Pws+/0p8iMv+sBOoN95sOlCE1jOE0f
X-Gm-Gg: Acq92OEU/TSU+WAerzwCqpUSMU3Ixy0clai8CifWbCb32jPK7sBkuMEw96lkTffTHE0
	0RDfKIb+JkSBuu8mN/diJWJXN5nnKe1Gqrbetapfc/0UNkPwwahkRTIlJ91P72R/Zl0LFE3z+2J
	oTLws8EtO5j8TU3AvT09xRCKIpdWWObOt/kWyYRTRNjq6jW5r6U1lh8+s1fN5Zv2BkxXPIRIhVh
	Vh9rOpQumUXMNoN6BlYg3iayLSJqWytBrheNdWxX+UWB1Ipwmw+gpHQV1Y/zEBMiRCIVx9+Alz5
	uusOuBKPycRjoT0fAw06DaLriKPT8z+WoWPLbUusEuN8YOZ57uQwaPCsPO6Y2C4WEAn+Q4S2KPA
	NbF+GTUbpMdL5rfz69ypgGJlMO7QEU4440Kb5FEyGOWP1HDi84q6mjDWG9p6tSzwqODqg1V/V2P
	4UmUF5mXM1e6Giki65cFmRYC2hDAQyZD38NZZWtQ==
X-Received: by 2002:a05:7300:641b:b0:2ef:8b72:1b9 with SMTP id 5a478bee46e88-3081fcd0213mr9384410eec.0.1781620342507;
        Tue, 16 Jun 2026 07:32:22 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e91f88bsm19524868eec.16.2026.06.16.07.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 07:32:22 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260616124801.2282199-1-kalpan.jani@mpiricsoftware.com>
References: <20260616124801.2282199-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-next] mptcp: fix lockdep splat by using
 GFP_ATOMIC in sk_net_refcnt_upgrade
Message-ID: <1d48f40d-e702-4b2e-38a4-2d437bc7b5c3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 14:32:21 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kalpan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_add_addr =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/276218=
62119

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f101eea8485b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1112313


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
