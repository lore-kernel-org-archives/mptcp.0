Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D11246781
	for <mptcp@lists.linux.dev>; Wed, 15 Apr 2026 11:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776252756; cv=none; b=B5ZlWDFg3XGifzG68S1eLyCh5ffsRgyhdrzKL/Ay6/riXF5Ps8iBNS2nK2PbP/ffYaIssZZH9TGLKCi0u3/RmmlfdSkuAZgktBBwn47YjfgrcqGtYaFtk1lfD6wEWRjavFBqmyPv+hb/jy/ZO/lEt3hOZi/vS2U31OQovPNP8mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776252756; c=relaxed/simple;
	bh=u3DEwsnw4Y+ZVOeEl5Rv8wt3AgtvO0kMxsUD6xJYSGQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=G4mlot9jgnCvI2TRNPajijziHhL3DMxFfInZkcbwvEOwbR7KBEOp0PHWyplRsrT43EpvEgGKa8kkD5bFHt/81hAcNwvReT0W2Cpe6IKlJPu8JI7fr805DRa0r3BMcYIIdnPhSDt1GIX1P2c5SvakSmq886xS0Vucqy5aYphIpog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnxUV03x; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnxUV03x"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cb40149037so621131285a.2
        for <mptcp@lists.linux.dev>; Wed, 15 Apr 2026 04:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776252754; x=1776857554; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30OJBAsjM+eRlihZfV16qq1plq/o/R5JBcqspYDzBGw=;
        b=cnxUV03xTdVAuo9MxRfcRQDJlT5FIMou8NShe4/ETNIy/gkRwaTeUljfOetcjJEeB1
         599ishI5CtU0ezkLCokQhgPcVf4wuk6tCVl94BYWb9Tx+0yPE+lRrCWiyogUFc7XOPxr
         9a1fG9G3LImsnlNigYUQYKZ17gSjoc3yP2hLLRvlGhk/htwcjDM6ghyVD7ej50xQUrL2
         XzK8pJoHufyNJrnZ6l4DSuhOyGTxthnjzujPIaWgIIbMCqt/mg+rqY1L9sjajEQFUDjr
         rnshedTvXKwpQ5VnvbmuPaYM1jF6TLhiQfDwsk23dEqJkLzjqWf3/QKCS0zk8FgG5JRw
         r3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776252754; x=1776857554;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=30OJBAsjM+eRlihZfV16qq1plq/o/R5JBcqspYDzBGw=;
        b=lBm+vRHMcwLZRzgZlbi+07PwpcrRgTRRZmLFdx5al0yzX/+rBXIJETEI3af0aTS3J1
         1RPLNWjLW/+TznOJhUU76jd3Wv8cM5wAxa7sPZKl9BZjW5IEgBFm8m3wL8LN6v+s5/nz
         NBDob9Og+SJCvJc7HVhw8Nqv1nySrBTMieBXBQuCJBhBcy7a4sQrTW/iK5mtNwts8KG3
         /POCq4efDCDDeWQi5B6h77o0n+7hjvufy64XXTRCx9Cf7z5Uy5hIQc84SDuCLD8LyxEF
         p+3YxXxO8u86dXr1iXClWE0VrjNMvv7aWnM2FyJWcFyBS4BHgvIAxF0E1b1wjzZSlZth
         XAYw==
X-Gm-Message-State: AOJu0YzTOhaXVSvV8ElWpnjG8IHwzWnkZSLnugKZKsT4ULyO8UsYSLH/
	d0FJaf560DQa9ToPD80/nxHF+Q4F0+hrNKZTJ4XzuwNZz+XlYLqx7tS8v0Rw
X-Gm-Gg: AeBDievJ1lwT9Y1vLVcjjne4qPEJdF8y5DXbzM/WyeaOYrN/8P+xM0Dbxw/0uaKoIBG
	6M90AZj6xXGSS3AmAKsDyCUY8Cp4lCI/+sY4VyS+VoG5hIQmLtDyCNOlWewig9ew0brAXTnqMYx
	XEICjvaKOQ4VB4xRd+O5uhAhQ++mWexHs2+7QjXrQLrz/+37j5g+yrUuPumkyHoVkQXXaI9YKNp
	GF58F4t93gUyohtsTOLzp9n844Y2KaYeU0bQLn4prBpOrNXtPPR45l6KV/XDzqWSKKR9o1PImKw
	P2Q6r76GSdkofQdreFziw6Xusi11R6Y6DJybKadFlSjNOCfaHtHHRQAtDo+T4c5LbvCJYzhgXJh
	cbnRGn03SAwYw7a43ocXCpkjWdTzqy3G1CNgrfUBYIjsAZNEX2UVSrWKYZrlm4kHUu9mkyj0lv8
	Lue6Q5Z82NrbSwuWYBZI/DiV7DbRbHUGj8VdR6Dg==
X-Received: by 2002:ad4:5ec6:0:b0:8ac:b677:c3ff with SMTP id 6a1803df08f44-8acb677cb54mr154550626d6.45.1776252753771;
        Wed, 15 Apr 2026 04:32:33 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.232.16])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6c974c2esm9294116d6.17.2026.04.15.04.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 04:32:33 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
References: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
Subject: Re: [PATCH mptcp-net v5 00/20] mptcp: pm: increase limits, and
 related fixes and cleanup
Message-ID: <f64bbadf-28ce-2bdc-a12e-96328142781e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Apr 2026 11:32:32 +0000
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
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug =
(only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal=
 (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/24449306485

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/68853a8f630d
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1081499


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
