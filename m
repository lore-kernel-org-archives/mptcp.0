Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794200377;
	b=Pw1bA+jDsx26Qc+ASGPaoaqHJR1LXuFUsEzxZ0tVw8APMb/0ij08Dlf6+QOPDmwSX7fI
	 I5ddAQkJy9lbwYajbzsZ3bCVaCaO93s1GwC06QJHACnqYit2I7nKCx943RR14kHKltpAJ
	 bV8DC9pfIeLX47YipUl1bGRu0ENCZ/tcQeYpssVxUVqiSPKh3XENf7dzktrYW1n2NvN/s
	 NWl4+PTKdB/VC/YRTx+AMPq9xP3q8onf0OVBaEdXvqyKDji3J4ckYZfMH+3UCm5s8Ntmj
	 RXbYeJRQ30X3vwNi122HYLVcpgDSV6yYMbZUzY/6kN5uZjeN2pY3lv+Oj1+ynM4Xvug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794200377;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=ject96LgsUV0+pEbuVinof5ve85vWhZ1SayGJtZfnSo=;
	b=k7W2PZxaFYj0mVku7TvDz05iGBiW6oxxU3xA39W0pJ6LqAF+dxDxu61t4hAAvgcIk0OS
	 vvy7J48RAP2SYmhH5BRh8RhGaQDPoPNGZ9Vp2AgyelIv6KgadPSuY0fzzgQ/+LBZkhNgh
	 iq1rANXrpkoIWW1cpa7Jbps2tgPdCq7zT4+dP5OQrSEh8FOTtFpreMc8mDE5zrOi2LT5f
	 dR7xSZykvzu0eSa+HjIE93nV4Yf4OS+W4vyLpN3igy+pO7aPuW9MFzRsgAomiFvh0MQGV
	 kKgGrNTcFgEy7NZ0BDfdx7f3trNcoTWld6Gb8uiC0ivEBCngENX209nBMCDjH0OurFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0pXpnn7H;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7CE606A31C
	for <mptcp@lists.linux.dev>; Mon,  9 Nov 2026 04:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E7CE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0pXpnn7H
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ae1b34e0d2so218165a91.1
        for <mptcp@lists.linux.dev>; Sun, 08 Nov 2026 20:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794200377; x=1794805177; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ject96LgsUV0+pEbuVinof5ve85vWhZ1SayGJtZfnSo=;
        b=0pXpnn7HbalZake8y1cEv5Wf2Gw128WamnPb0Lj+SEFAo0GL49DeTfB8NVIzhumRlW
         t78rGKk5WfYIk3cSkT4eJKaYjcgsTXoCUwDQcqcxXXEPWcFi3nElM2/GQj8SQAqiVBnY
         CeerebGX2ZkVo0T/Uyk7g4VmaCFDDwYhxJ37q1IGo7hTxdA47dWvhTktt8I6KlSEka8k
         Qa+7pjLWTjf1OVYN6yD4sFSNAqfGeM8UY56SHC0y3ZoEwZGFTm31gpX2LgtY4Ytab+Hy
         0WEfvOSOh4xxcW6C8b+pZLkjgQqle+qgtEogD7R1MhL4EQfr+S0HE4r3WXM76JOJknk3
         pIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794200377; x=1794805177;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ject96LgsUV0+pEbuVinof5ve85vWhZ1SayGJtZfnSo=;
        b=INnveEZhOwU8/INGemlKssjw09qw0O9AqN49GiWwz0M758+3QJmIY3ayO/TIASvy95
         mbkANSsq1zDhDXmIBtoJv5RBw9yBvC2ZOH/a3d2Ll+kXd+Br28gRTlqItmwdT10Q3lwN
         x99tIkehwsOAmF5hzwrxecVS3PtU0yTXYrmE53bkyAxiZOlHA6eEO9tXnl1tHD4twKo8
         EL9ZCy2G6K7DIv4cnPUnRhtTbD+U0QW3cwB7Szl6Xf1nlg8dcxHdUUzbxlg28bUY96rP
         KhJ8P99gn35t+GW0waHAwkR07v999rwgJl6LhEo6h1iKrdJPlicSUT3NvoVE02TaChcM
         9+yA==
X-Gm-Message-State: APuU4Z+mihccKHkY64wbYlBB1Mhz6jRKniKEa3mLedFoPCPFN4vZIsZH
	oU4otd2aLu/gqXtz4lkb4e5mmp8re+uZHLqpCetMrBHv7B7jXsPv0cg=
X-Gm-Gg: AYBFou08Rbba4anWU9Em+8D0Fonr0wqTrmHdvdhKNMRf6kNTfdRq2rxL2cAJVcYYZ+D
	QX9PW+kur7os8NdwjJGtZ4GA4l+5vw2zXpF+gqvyRT8TqTpA5vfmIjsZ4w37qKJnQklqB1zF2MX
	CEU4fEJuaSqbtA2fuufzib3T4dllcweVA4HWkoUXblodkra3W/U8yhby8RM/ZmiQGFSTAjajVDS
	SDWXLuPNdXa7NZdOIkiQZzdWoZZcfb5IK+aZ3SmWgeGnnRW9GoHG3mfZOu8aDek3WzuUEyphoc2
	N1Q7F6bL0vI8PIzCVxV1WtSYM9WWC5CB8/Jvs3tahd1pikaoR91jJoqoRXfBmhetblrQ7SuW9yj
	p+uk4c/fFh/iHzBqnSkXbczVZLImzdXALoLVtzKnR6qSJ+7jNRETSPS3h1MCgF4VRRPmqLP/Bh7
	/sP2zeTNvxlWPaQcfOA/UlsTc8oXcabWXkTKYEJc1J2Htsf51YKuAa61S3HcNZm1mzHyQYQYwaV
	e49GVnoLKV5YeOuzUoME5RXoBbmSGuHyu+lzcgO2Lvq/muVR4WP6SKAEW7ilWPiYfvnVa1vzhBo
	Sp/zRbO566qGC3xLf4a0yffwoO3EoY3BJdjyv2kSh21GIlN1VKE1fA02McSLsAtu
X-Received: by 2002:a17:90b:268f:b0:3a8:337d:228a with SMTP id 98e67ed59e1d1-3b12d102c5amr1931441a91.6.1794200376552;
        Sun, 08 Nov 2026 20:59:36 -0800 (PST)
Received: from github.com ([13.83.166.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b105881e6bsm9351062a91.7.2026.11.08.20.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 20:59:35 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261109025425.328445-1-jiayuan.chen@linux.dev>
References: <20261109025425.328445-1-jiayuan.chen@linux.dev>
Subject: Re: [PATCH net-next 00/14] net: annotate data-races around sysctl
 knobs
Message-ID: <af3c19b5-dd03-c31b-cd1f-4e4f3e3a63b8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 04:59:34 +0000
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

Hi Jiayuan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/42555859790

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/e9bf636f57=
c0
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1205650


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
