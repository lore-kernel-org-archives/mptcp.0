Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792588921;
	b=pcyuJkBIYSEsHQG3Z2jFGjOXvFavoTrI6PuY6Fx15Q8Ujys+mT1jvHFfPMNShWc3W/VG
	 pdntVuOTOl6PiZ0A1JPhldX156e6Fm96g9TAuJ/92IADs5GdA3wG2GHl58itDl9tE5FJ1
	 jaSRRdFswMya4+OvAGTShjSq6KIk9kNT/7FOHkOSnoibQxv/ErOy56ZAu46Ocq3uX9x5M
	 PzL5mv/oeMeHfpqWfgWCscGCuWYMVsZd96htr571+75mzAnBLv+DjR3uS4cvN5CQsdPMd
	 87MhW+y/pcDXcaVFq1YiF7eKtQC0WjITiDNSsAwmracKqDhD/N4+gTcTjIrGu2nDbWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=WrbBC9asy8NyMY5cPdso54z0uJUxYqZEA7x4t9oAwVY=;
	b=ZmPGPL/VbP7+xV+ndQKAX1Rh2a8+TZzqKd/MTj1PrnfptzroG3ZYYl3IGMvhumY2207f
	 JgKb0PQKLweKdpYfJ0SOda7NEU92rRmV9C3Okk5ZfqjMLGJUO8NqxNf2vTLf+Sysc/aPH
	 5sYdbvrr2YWVFa0LiitSZAT3STN9Cyn5HvkGGlf5RjP7EcNrDki+vgMtdbnlJf0xoZu9B
	 sAc0q0TqweLKdiiLB4UlSOsalcdTVHx58SHWLPrennExoUF/vYD3I2UYXCzm43fhrIp8z
	 fn5+KTd0LWILKyytNOAo7dqcFa6eKaXyVVccf8QOYmIhwPhhEtz3fW6o/RAOs0mt9kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MwcGlR+s;
	arc=none smtp.remote-ip=209.85.161.48
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E48606A319
	for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 13:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34E48606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MwcGlR+s
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6aa9606ddadso432449eaf.0
        for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 06:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792588920; x=1793193720; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WrbBC9asy8NyMY5cPdso54z0uJUxYqZEA7x4t9oAwVY=;
        b=MwcGlR+sb5LR6nq0XJ8lO4Y5jwmyGpDm+b0AazqWvdMwxT5uUwM0pHsuUYrIa1i3rw
         39oslSxoV06vHiZJdHFTXdhlFIhZlK3HP7WX/5E+llKlmJu+c2gx3qhz31Ns87dLUFhW
         ASDHlfBo+bYh5GbJOCLeZrGRpaftV6CpsdMDisvD00SNFLBJiyDYC7jiWMC0taYrlnb7
         v4CV9x+B9nPdeX0I3fOsO+VXOqVvSDf2fUT5ezqBttGdW3iiF0sg5hRpAK88j45pBhQt
         9uYNY2QeAobumYbps0pi7tHNp52TVOIY6Xcc4sx0gi/KLc9Ag73c7mchqnI0lYx6l2GC
         AN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792588920; x=1793193720;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WrbBC9asy8NyMY5cPdso54z0uJUxYqZEA7x4t9oAwVY=;
        b=17ZNIy4xikIx4IuBR2j1fbfrwZQMeMOVSiE/gkvRM07L5zGfdKo/FuBo1cPYCYzPED
         GQhi7OCg5bGVDIi7gCRsHjlUQXwHIYS6Y57pD0tG6oGbXTRObIra/+xxgIX2Y+/nLjw8
         76PKwyy52w4+XyC2VorztbXdbHEELjJwQ8nKoFHGbgi7nT1OLzHWNPCnW1lsLdUjWftf
         74ocwovlNe+WRXV13NjBPwP0NMzoglIXB6Q6BSnGUm60WGiqRj/J33hZ2+HDD5JqTGyA
         AEiAP/ykQy9CYXDicMvcFlZlebapRm5vkw9lKeVYWXfJ0f55D09cCtasIFLp6ny31fQ+
         Dmcg==
X-Gm-Message-State: AFq9FYLB0XI3Bv4e+2UeU1fMpmv8qHtwm+soHU6hQ2LdloQrOdW1cTbY
	mUrv48HPcwNzYdZyg0J7cuaJ+CsGoVSzWQ2j0aBb5GdD2+rfxHtv7ww=
X-Gm-Gg: AYBFou2sh8wXoHtNXltzP9tnS65o1bFm2YClhYHmKj/Q0YaDJBnbAeKuDhTWiqk3RC5
	xYClKMqZluiStGGTAdQZ1y3LYbPZstZHbcsib4a4x4zRco5xQwhbuU5w9kNe0kwSMsRDK9eJ1Xs
	/o7SuKtylmuf2FhgxYxiN4GObfWQfmG/pdVxwyNe2Jk7GdZzwTdiETYI6cuEQwcyDbUwpTDjrjB
	YJxInkJHLelxOTiZEJuSnn66Uz1ggiyZGQypTi35nMilT/UssD98Bn/hqPgh3rGr5VaNIfYwPz3
	et3yMshdGdjKYXdNfgLnc9OQjR/u8CBVUDegfrifaKKu23lqByy7J71gBjneOMTOCdwS03Aa639
	u4qPekHHvpZXqBIEJbB2U0I+SzbeiDn0jZjZGTH6o++C1pdFr4cgmeH9W1l+3EEfa8Ab9fk4Aiv
	7q1Z0p1MaeOR5CeHPRdC5ScIZL7h2Etv2DR58o/6LtREN0pdCrcTcsL19TPoTRFLHSxQeSmgcjD
	GItwobNUIHkua3eEaQiYmFAKm95ZnifutAEE0ICAbKJXYT1Wh8MYj91lFoH148B6jA=
X-Received: by 2002:a05:6820:a502:20b0:70a:4053:52d0 with SMTP id 006d021491bc7-70a40535eecmr15577eaf.12.1792588919996;
        Wed, 21 Oct 2026 06:21:59 -0700 (PDT)
Received: from github.com ([20.29.37.168])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a7d61160bdsm2016325fac.6.2026.10.21.06.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:21:59 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Abdul Wasey <w453y.me@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261021070324.50533-1-w453y.me@gmail.com>
References: <20261021070324.50533-1-w453y.me@gmail.com>
Subject: Re: [PATCH mptcp-net v5 0/2] mptcp: pm: in-kernel: fullmesh:
 re-add of the initial subflow endp
Message-ID: <a3e6b9f3-e786-28ce-c85f-7597f0f03a76@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 13:21:58 +0000
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

Hi Abdul,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Critical: No conclusion =E2=9D=93
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/39580754081

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/2a9b455644b4
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1190258


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
