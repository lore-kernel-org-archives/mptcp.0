Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612C13E7625
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 23:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786750206; cv=none; b=aWxMmeut9fgqmdDgTgyF8KTw1+K5FxdiM4r61k/yx0rqELpYpssKNG0Vi5PeqGw0M1BFKUJSnnX3ld4gUGxN79yphbTNpmv/IoDIlPunKFAzCMUEoBtVxEKjysSP6VPbXZQ/ZTw8i3Gvva1NCYu2WTYll4wz2+oHNCmxFtCJMCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786750206; c=relaxed/simple;
	bh=IoxDCdBXx63gp8wLq06si9OncxXbDoNI/X4ev44NH7k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=JM7iq051qJPXmN8VlcGHtBHWZDRhOrvUrstlqycXlIIkUeT7/SBkYH7nnfyCHowJlKW289ldddD32Mitg2zMBgqpYycl6Ql2DX+8gmlzJqPVWGyVi7SAPAPj4Y94frGeuvFVvKlg4BXx12hO8PQud/LGhJ2zWIbB8/4Y95jYsk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgccBkYR; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgccBkYR"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-382ef647e20so1561012a91.1
        for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 16:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786750204; x=1787355004; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=z07sfJNL+mvYLFsvuxjoMXC5iNWH/O2hGlb0wd+osRM=;
        b=MgccBkYRzF89LJBBdp8dLT5Bo/HkEULPy9Z3Vx+TwLIUnOnUB9ZlMIvDZEccbxgRgm
         +XYL/AG4E1CmnzGrk86FNl7rXBLfg70UTfyvcvoBKR+jQ7flp0TGE8Kbww5nSa8Ykuo7
         TK8c6TUo7LZQsT3AATMUC0Jp+ZfNN+u7S02C32hdss3306tHvbjC2pVeHi+xCbzm5wSJ
         jyJ2H0lPvivrSRuiO+MR7SYm30aZM6crTNXhPCjsJCv3rQDYfumAVRP2vVBuaCxclU1N
         NmCBLfZBf2r0oWlf/5yrm9NOjYthytwO81bvh7yCJaMntBd0OPdI5UUq1tNGYazJqmgp
         fNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786750204; x=1787355004;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z07sfJNL+mvYLFsvuxjoMXC5iNWH/O2hGlb0wd+osRM=;
        b=lDMUiZAo+kQBgl9cgtekhGyln2aYccCcgmwPOSpFczl22CqhrZH7wH4nwvCu3g38Nu
         Uze+6xtFePUmcJut1CY6mu+GmRzaroHf7JAcoxuocFFY60iyynviTFHgmHelC//oNXdX
         jxQYlpQ8ox6mRdzCORrYOA83I23GDghLCxhqcU8MSqFo4QRnKEkXnTJ8Hpq/g2O3iLM1
         UBnw0IK+018A3aXGk4EcpAjRDq1Ry3xcV7BKwNJ4HPFWYlndYXHG73HF6vFsOWnc3PQv
         y8U3AhvonET/YqU0frKwV6Fw2TF03HjJXwgw6rn90fKH2zk4/SEZukkVwAf53votUQH6
         gftQ==
X-Gm-Message-State: AOJu0YyKH5D0yhABbTrLcLy3kB0Tlq+mKgYF6hlMnRe9O3PdGV72YREi
	OjukxJW7h2RC+kdm+JN2PRQ857pLjnyiRyJL5HH42anic7DqHJIkNsI=
X-Gm-Gg: AR+sD13OWpACKn8kq/kwS54QDrKtgkm3nnU4Q/tS+tgo/sSeUexM7SlfzrWVkH1yVdI
	aTl6FEOT2ahAi0v6AuhoUtB12K0R/YHHNtHxxvt6xkCAV7l53qsfmBcb0WpvJEsEjfgBfnRiGrG
	tGH8vgFBCheL6xo9rgDTNaMA8dv4xhjv7nzgLyZsbLH5aoL+/WyF2ZfjJafI8hiF2ClEuwICZV8
	f7MQHovAMu1JcSnoQrb1mmlQPyM0uegiwqTxINSCm5XItYPa0MPgv3Vejo9olvMoDqhVnyWPu4X
	xMjIqKynXhYhrL6+2ZiekwQIUxaDYfiIZ5ootHTgOnoCX76ucSLvgMaOUVNoZBYuBAEf4u/L320
	jBXVpLno5M5RU5TrwIXhiTt9ODlPssqHzBGrzDgdnjZcz3pjyKxADRm6gaJsP5fHUCSZxYJ9XWW
	6ViHVkBypCo3AS/gq5AxPBUWuq8OJI/tFY6XDEm1li08qhf8ZRhLi2xZhmI5yyNP+TC/iT2KU=
X-Received: by 2002:a17:90b:53cf:b0:381:1c96:829b with SMTP id 98e67ed59e1d1-3933bd204d0mr11076393a91.3.1786750204110;
        Fri, 14 Aug 2026 16:30:04 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.6.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea7fe465sm8783677eec.25.2026.08.14.16.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 16:30:03 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260815-sft-mptcp-stats-b4-close-v3-1-ccd9af14cf73@kernel.org>
References:
 <20260815-sft-mptcp-stats-b4-close-v3-1-ccd9af14cf73@kernel.org>
Subject: Re: [PATCH mptcp-next v3] selftests: mptcp: print stats before
 socket closure
Message-ID: <e0e7554b-0d50-49ee-799a-4c4d0a680e98@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 23:30:02 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/318477=
44292

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2da643328f05
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1146325


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
