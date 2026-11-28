Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795868013;
	b=UPqsJ9Baz4SXUN6wfcBXFCPpPgdlTyXIXT7p+uh8y2C1FrHddz1WJSGTEvDtYRNhru7l
	 fBvBd1uZ7urTrZUWiuOQL1XU4QPa+xxePokc9ezqGF0bvwX732OOlCtw59KQ2ykSbhl9d
	 dMwyfwTGVuDPvgxlIBt8GQtbHsPWaIQjGe/ce806NWP/V/QtR3Z3+8/4gLSGaMO0eRYTU
	 yVl6mso9ZCR7WlPJmcABkQP/KM5lQpfuQUza9mBAGRfNB4buQkzmS6wsmr/YHFktfBjeI
	 +7EseNTo0mAMaKVWVybU4+9TQcVvVe9wsaIzXyNvl28f8Vseqvlb528a+SwODXTiPow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795868013;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=RPb2/YGM+5n7s0bzOrXhtYpU40ym0j9lJft5pqEpsuY=;
	b=YJqpjQA/+09aMswaczsJe6nA00auAKOMwAuKM0oDrFgoHRYc21wRNGI0hIf5BV2+KyHu
	 4saR2PCVeFuhlgaNG3FHis0ZzuRfkdS8QaoPLrl4jHu/1q9Sn9wvqeVMBYAA9+BBJGSev
	 dwPXfnIICY7X+HFwe/m0Ff4Jdud/DySvtGwLiNKHCysZzfzojkkmMj7WGcaGwBWmmGH8s
	 8+bpNtlzh+SLf7aW7ehY8Dp2eFdVVa/4BJGRtcNGA8urniBtAMoZyDHwIrTUVxbqjkD4M
	 gMI293q4NtQyZTCF63m2QJvNWNZiWlvNzJeWdyhj7Hol1pIr0+YlVhroy7fENV+MH3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AbJ+iITL;
	arc=none smtp.remote-ip=209.85.167.177
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BFA606A31C
	for <mptcp@lists.linux.dev>; Sat, 28 Nov 2026 12:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49BFA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AbJ+iITL
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-571eb508ebbso4036134b6e.2
        for <mptcp@lists.linux.dev>; Sat, 28 Nov 2026 04:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795868012; x=1796472812; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RPb2/YGM+5n7s0bzOrXhtYpU40ym0j9lJft5pqEpsuY=;
        b=AbJ+iITLgkQTxJ/a4z1tG6iW5XCF3bQGmRiea8wVhB5E5nD31xLicpuy2r0CTPjOl8
         8+Fi5Q6IPi1lVsHBN6ZFGgNyzsZ3dTT4YmsT6XviqpFIiC+oi+3pNYHdwIY99oMJyKqI
         KUMiitOzLTNfihN+C1KE/4t/RxHc6wS1ORuEhI50sbMlHeqw2/wtPaKGjI8FNOz1fzok
         QReQ27r18LcdN1Fq/r3Mic6PahRRbWqi4c2xS/aIpmh3gC/3GUpgf60c8Df7Cn829oMX
         Qw+D8O3McUJDWUsDnoKAqC63c68rNky2qD6PitByr+638pPhTnYXoX+2eOU1mGC5+iHP
         vGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795868012; x=1796472812;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RPb2/YGM+5n7s0bzOrXhtYpU40ym0j9lJft5pqEpsuY=;
        b=D8yYJpJNznpP9HI37mJOJvNUWQLwJ4+AhNqJC3io637KCwr4VmOBEsWG9T2fgJZWmO
         0DEMQkUoDe2EkI44pUczM33j+YQtyyglqRNMIH1QglXLfn4K0TstZw7vgxPsXLW2WkEb
         JVA8ziMxBfibQyomdQpARDsLmyZFLOZYJ5mAswY5/nFmE8JGgUJXCO1EZQUkn8cQYWl9
         +16uY0cLiLRYVyBMJQP8Q1QUuj3dN3wQVH1CnQag4Ga24id/Opb+MqD4ttA1oqUa+kti
         2wMIqrBYKDXlsuLh+J22Wh7b+0S85z4oM0QvhPxn4IF+QkOIctWBSvc593LPcZKRI5C5
         TiIA==
X-Gm-Message-State: APuU4Z+phdUbcsMk2X8vtuf7FRUTlefceIduvT42+5fqyg6iFG8VsMzJ
	WwjU2OODgN6Ds/OErcfWxgJPa3H2JkcPoWuvxEgabIEm9fhYHKv2q4Kb1tNf
X-Gm-Gg: AZFdTZflgtYgcVbLAe6QJi+9HmVjxraeSH3KRJFeu86v7SxFm04eGYgEB9tgPPiIqIw
	RcWt4xW7Tv3ukr+3wT78UA6utXb6/JVhiW4qMM5GJ/+AoapSJi+AYSk1bin5ZfOmrrhp0UsftFG
	LO6GIQ5SkLI8alTuYcFDHA0O8C0tWqr7AlzgRJQV9nyBaY5TDnGaxNsa62E/3OK6ZwuSFLlM7et
	lECPZtaG88Kcq/iiDQ8vDRV5hYgPNKKnD7bI1Pr8QsyFjiQkhJ4bJa0sQemgCl7bAE9yS6S5qbp
	MalNFrHJgx7JATghBAvjMYAFms7LFIh+BxOq+QfPWLAoQW6PftFFczF9Ynqdkr1JYS87F0+ioLc
	nHSMyqoALfY7GXVyMh5uwy10GGJ5B9qkTdBOJIhjq3vfDKZbmecyiWuKpOmzF3dbU6AvQ8IoJ9C
	doUHyp4f8rdIQLsI+URDEFskVW4UJBWztAWDXqjtB8XfPzZv6eV7TG1Mn7gETslN/vVO4Iut72F
	/KlIa/ReYf8zqh6kemOgXggmiKh5sODvw//wTeEd6Mkym8g8i2SxNWx9RZw9r4OoDP+BLOX8v7J
	csr3W7XX9LqjTCGRC08ArK8ENfnAa0SZ/vCd0NX+Bw==
X-Received: by 2002:a05:6808:13ce:b0:4e5:c2b4:33a4 with SMTP id 5614622812f47-57a0c6c0ed9mr28535241b6e.50.1795868012125;
        Sat, 28 Nov 2026 04:13:32 -0800 (PST)
Received: from github.com ([52.165.102.85])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a34252987sm19807072b6e.4.2026.11.28.04.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 04:13:31 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1795863454.git.tanggeliang@kylinos.cn>
References: <cover.1795863454.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-net v4 0/4] mptcp: fixes for SIOCINQ
Message-ID: <f643b685-0019-cb1f-838d-d8757b78eb1b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Nov 2026 12:13:30 +0000
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

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_diag =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Perf: Unstable: 5 failed test(s): =
error:sched-mem-pressure regression:sched-bbr regression:sched-rmem(3) =
regression:sched-serverlim(2) validation:sched-loss =E2=9A=A0=EF=B8=8F  (5 =
improvements, 21 new outliers to review) | Success! =E2=9C=85 (1 =
improvements, 15 new outliers to review) | Success! =E2=9C=85 (10 new =
outliers to review) | Success! =E2=9C=85 (7 new outliers to review)
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/461395=
17807

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/052f5a5475da
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1225133


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
