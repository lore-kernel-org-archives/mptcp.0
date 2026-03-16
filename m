Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07259331215
	for <mptcp@lists.linux.dev>; Mon, 16 Mar 2026 18:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773684215; cv=pass; b=NmEMiq5ul1j3RrbHRIskKkZOk4/sC/KCGeTu04ywAUmWPdx6+twQPnEyejeDS/2tSNU9cbkh9laFnadI0Wg0rQ/wVtaASC7jytXxEXlKjqlzmFdDbIKThux3Wcir5YsY88lsH+mge6pbtrWuegn5xttX9GBthetLK3Yrv/uxues=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773684215; c=relaxed/simple;
	bh=KNzIzyFdGwoJAVx7hy0kRK+gY5zPmTyPzd0Wd0WQTas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJHV0UvQfQy1bC6y+RVF0QTzBO+7H1OM2JQmiJIIcdHGG/MlInkIGaBJE6iorVaNohUyfiTbFB14wL1Y+t2TmXA8Z+9BF7KRf4AYR0kK6cvytf/rFy92oe5oXxflEZTGunQPdV0n2GdHq4neM9BgCnuBZZaWRXOWtp44kAWgzUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQ3/+2LP; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQ3/+2LP"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1271195d2a7so345370c88.0
        for <mptcp@lists.linux.dev>; Mon, 16 Mar 2026 11:03:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773684213; cv=none;
        d=google.com; s=arc-20240605;
        b=EE8qnbRDkYmV+xCFC8cieLaG4zn0JFTIshf1e34acQDGeQZauKQlV2zCFxM68wXDuI
         aK2tTm1Oo678ewEpi/YlPeJOu2l2xh4o9qtvx1KAtaFeXAnz9sH6w6hrhfLexGNGE1aC
         bJWR8o8iFaRgzr7TvIiOu1geqIloyr8fQ8tXn93oUojv6BBGtk0S2WKsUf3X22/XS4tN
         f/kaKA0yvc5TtHA09bxmLRxMvCoa906BYVgNxg2XuQgskpV7TeO81Zp8p0pvxVanFbbr
         hOJkYJre5F2lnmoDROWDSm0TLBZkFb7sNiRhjKb8bFJwm6lMDObAAhCkR4t9U4HkRBC0
         dqMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KNzIzyFdGwoJAVx7hy0kRK+gY5zPmTyPzd0Wd0WQTas=;
        fh=ecMVgNp0MzD77MnHLbhi2uTHtMpCIr0qi2SROikjXXU=;
        b=D5oNK6dL5US+z21ygnP/zyvE0jrQqmyc04+hq4ZZV7S3ldT3tup+/Mx7g4VeeIiTI7
         UYXp4PqgaZY7tYdqIDWP4AmNDRHI7QG7bO6vZUBMHZVpQblWk/enN2uCgvNF+m5rAVZu
         fTK9bwytRMq1HcS14Z/OONIPn2g7vklgvq70cb7rbiZ7hlpVGGgLSqboRLqnYWcLH/+p
         XAWUQIQJcG8C1lqRzVNxZwqej0iFuAMVcAhQeBQ7SOAVNSKZjrvpcxHfWbESD/oOFNsy
         oyDGSvGHoib/vNshfAfE2eKM8s60qe9pLzzNHQ40lc01dkF14HHWY3p/ofdPIOSK4mVL
         GnJg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773684213; x=1774289013; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KNzIzyFdGwoJAVx7hy0kRK+gY5zPmTyPzd0Wd0WQTas=;
        b=hQ3/+2LPPgPU2AcoBhqCim6Rpfdmky/cS2g6DILP8MF0AdkkKM8k2S4gG26rrgAM9B
         wPFkXlC/7WLmJodpRCAZXSl5M7mc50tKEkIxFM59LztLF963Axb4W0/Rj37G2p18q3RW
         foEv9UdWLyWpjLIN5APgVodYNuQhRvmPsZNXRTVN0F7EDmTqpqakTIdODoIf0y3thbpa
         sktpn84bZlSOtbXq0z9QtjJCR/M6FjPumemxMJTiDwI4XDdJQz+HXOK8x/mjLdtSKFpD
         tZVomqqimlz1xBE/QUbUIxH3DLLgeeJPaZKonhz2U92IFTt3YXc1tQXG3bN2yQ/IroDC
         3HQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773684213; x=1774289013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNzIzyFdGwoJAVx7hy0kRK+gY5zPmTyPzd0Wd0WQTas=;
        b=mCAVFl9WDWSB5QbnQTHQA4VcH9c4u+Et2/ToX6g5PiQA/wKS81RHkktCXlD4gg6QBU
         wWjX+EvRepwCwFPa4KUrdN2r5GJhca3/QQ9PtCJQL8EP4IM2q8zr4g+V/0hl7UhnskZT
         OguuB7C0Q2+Ol/dSp+PDz24UzQgbwf9WB2h6UMbE1YdSdwuP5lDxqRWfgeQh0hGyxMLw
         bYQYIaFpUTCd+ZjZT+o4Oc4IolmyauGcq0fSM2WZlztY3nz2r6G4Wv9dcqOti1E+ZwRc
         bnV5WVbZ11HUjFPn9Kata9v9fAj2Xck0nNMtvV+6xyvAtlfKcD77Gy0hqKYJiAYzp+u6
         NH5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxAzFOT2eBKbjkEYsd+0nr9bfy4RBI/NLV9ZA58fQdzV5P2Kp5rtqdQB9C25JSbUoTrrVbNw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2aSNL1G05xnyeXTsJysulZYKyCSATEZl5yMgtLosgiiIZLV+d
	QlYi6LPYwInru5QDgKJ4VjASn8Bw7fDeABjPso7Wg1xDZOhbnNAjlkgxQlmfiRtsW8J2/q+G9yg
	v/izsDFs/xV/lwDUcI+9Dt96ZwiOVOf8=
X-Gm-Gg: ATEYQzxZQJjP9dpEjVWYfPsUrLjYER3cRVBk0/a6/sWL6cmSpUBidIE4Y0TER0dnT1t
	GBTdOBxh2B1rOf/8KdvTSQ2Qo1xiyPeYexo78vyPx4br7+kVW3idZnwwz7+7zteo144ZSCzwB4j
	tuzDPemU0pW745N6WBqHuRSddHvlMpbPmB5wzsIyeTaaJmM4ukIKWxvRHHTIi1pIRMasEcP6zsb
	QoGTisMzPutEGhjLNpsMlOgF3qjWbvaGFLnFzKhA7LUOM/JVDFNKVG/9gkvUorMFV7ZyCI0QDNy
	bL4UF4Fz3A2yBLIRbpwR7ZTGthWROCRJGjl054f3
X-Received: by 2002:a05:7022:e1d:b0:128:d786:8aca with SMTP id
 a92af1059eb24-128f3c6b032mr6448350c88.0.1773684213034; Mon, 16 Mar 2026
 11:03:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260314201348.1786972-1-atwellwea@gmail.com> <b042de90-79e3-4976-9bbe-b6df3266caea@redhat.com>
 <CAN=sVvyNpkyok_bt8eQSmqc4f7g7QoZBUmRmNRLoFz1HasEzMA@mail.gmail.com> <e93ce797-4153-4e6e-89b6-3839a0b8bca2@redhat.com>
In-Reply-To: <e93ce797-4153-4e6e-89b6-3839a0b8bca2@redhat.com>
From: Wesley Atwell <atwellwea@gmail.com>
Date: Mon, 16 Mar 2026 12:03:21 -0600
X-Gm-Features: AaiRm50ReSwavo1j1ssacOUbWxtcgznlHmGlPHkMg2HYVcwTt0DGLUUEq90y36c
Message-ID: <CAN=sVvx8jNC-OAMkv19Wv13jTpV5_wVEabwUCjPLMwTvS4czow@mail.gmail.com>
Subject: Re: [PATCH net-next v2 00/14] tcp: preserve receive-window accounting
 across ratio drift
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, ncardwell@google.com, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mptcp@lists.linux.dev, dsahern@kernel.org, horms@kernel.org, 
	kuniyu@google.com, andrew+netdev@lunn.ch, willemdebruijn.kernel@gmail.com, 
	jasowang@redhat.com, skhan@linuxfoundation.org, corbet@lwn.net, 
	matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	0x7f454c46@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,

The link I meant is the netdev regression discussion that led to:

026dfef287c0 ("tcp: give up on stronger sk_rcvbuf checks (for now)")

The report/discussion thread is here:

https://lore.kernel.org/20260225122355.585fd57b@kernel.org

The revert posting itself is here:

https://patch.msgid.link/20260227003359.2391017-1-kuba@kernel.org

I should not have implied that there was a separate prior
regression report beyond that thread.

Thanks for the note on formatting. I will keep follow-ups in plaintext
and avoid top-posting.

Thanks,
Wesley
