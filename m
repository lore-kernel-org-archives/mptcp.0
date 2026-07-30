Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44691FECBA
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 19:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785441524; cv=pass; b=TR0ggO6u6itN5VVeqMK0YYbDfcL02D1Q+ajaADMnrP0CYlB4fliX2TTS9Jev3xZIEFS+MZ9iVqp2kbpixNQ7eMQGmszPS5AZBQzlh3mkAjQdxGDg9cMtzSgEBOvFUVlRtFqsZlmEAnkNSUkX/r1T9sh784ftMudEjaKlJk+fj9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785441524; c=relaxed/simple;
	bh=7Cednh6HquBPiU9W3Km1kMvqqC5DEB4MFkVgBiTNJT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Izkj0lGxuJQCQ77gR0pN83RkzuMuUgvQhduLRUenO3Hq+U5+jk0HG5aDUPm2wAE1wWauhW3h9CRpDDEzti6HBehYCDmpgoE+wjh1ScmPJYFIPQDqUnIZpl+04Lq0yJHPM0H2XY+ybb1y16i2yzy0P+DY8pte/USGzsY2tZfFnRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=amDNyn9Y; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="amDNyn9Y"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so335181b3a.2
        for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 12:58:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785441522; cv=none;
        d=google.com; s=arc-20260327;
        b=TOKHiu+rhrjvwrPwUUMvqL/lEFGdbUEW/aOrD3Sw+qQr++YGla6ZUhZ0bK7aAAF0cy
         PdkgNvf5tsdqxA+xJNqTXLZwyn+IKbtzsn6uCEEFVSbSCZyutkx3zs5k0F4shTb9gFK2
         SC066VIQPLbQas0f8baAYqWKstkac+xJ0WWhyHRIE0pkcUtOjOAoUhkQA5TbsUp0uThW
         Wso9wYBpB3RvKd/AyVdingFlVKm+Om2JbfeevKsU5TAtexdagK4TIk0YRSbES7Ge4u36
         stYMbBV22emdANl2uvO0EKBf2AcCCV9uv/zg0m71AuuAtVR7Vdt/Um2wnDMH6VG84LYY
         QVFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o1ChQe06Osz0DBqXcvVnbkdB0plpgG2sLn5i4gN44QM=;
        fh=S838d+qgWRVrI5cJeKHYAgsCRyTww3d4eGM23PXkwsQ=;
        b=Uvo663gQw5OqFcZxi5HWjisNri4aobPQsAFmM0jwBT0bHORPPJ4VF9WR4cqa3x//r9
         647x89y2xs1vk8eO6TlSCxG4HoI1uMDYAlNmCzKBd1oak7gEVidCaHGtd6jWHkRWqs0g
         nEV/u9hrSJiyY9u6vnsYVrO1kU+kChHMQ9DpTxEBrhgtdNJxaFIHu6A5WJLhrhqAAp4i
         rBi9+5UtKJcWg7NcJcYHGb3TK8yUsYEbkvcSnuxh8+Ux1B1hZqi1JA1fy7RaN074CIdU
         uO98kExBwwLizSwFYlM9QTE+o6SL6ajIW+02Ipxu2WjRIzvooEqBu8VNKqimCkZyo1Qw
         9q0g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785441522; x=1786046322; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o1ChQe06Osz0DBqXcvVnbkdB0plpgG2sLn5i4gN44QM=;
        b=amDNyn9YMY+HUhM+yajTbmGh99+vP4rFVSgaQL+gHgQRKg4HXfjRryZieTDtrNPx5P
         sTiLqfAHDB1d5fxiJ4f6fopi7CcDo48NHXGYkg/yl6xomOjFiODbzGGa9v5VUGTA3iZP
         Qa7SMrsWaiR/LM9IW5nuOa31PY8n9pOvByD/9sai7FedV/eNOVBEw40Pe+VlRtacGdqD
         Dl1ST+HsXXQhtyv41/JvBnUTzfoJqLrPgDXdxD8/AExA6UbwYvXU4BTSC+6Z9TFWoYm3
         Fa67Lmi5XTY5PgbcokWpzHQYvDMjOxT6xxv0EohaclXXtSH3RYMo4ji9vBE0MKNHywQ5
         V5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785441522; x=1786046322;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o1ChQe06Osz0DBqXcvVnbkdB0plpgG2sLn5i4gN44QM=;
        b=NioT0BEoCEAPNdlJ+8CToed9UxOa295pxXUsxLLAd/MBQChu2c22PoX26xiKAMXkWL
         QyiwZ4ztw9QdG+eKFcD94gk3RmdbBnvKOjshDM0duQrSoi1UN8XqN2OYN/8+qxgNrX+g
         lZfKySY/fHWlaVrz3z3uCH7UFN3FwH500DGUE+0vIlnVnf5yeuffpokYUopUaWZtSuQv
         vX8oJsJTcHr48l8+ov2yiTC/pb/HYu4sZ6vc5+UAcqkKNdtO2LBChPdlBmFuA3hAKGw7
         0VBfLX4s8ILdenY+bMm89s/fpqaAw9velZXAH9TDoLtaNrAhvx7x2A7uIoOP56R22Fwp
         ewhw==
X-Forwarded-Encrypted: i=1; AHgh+RqBbtoPWA3EZT9v3OLVXrwwyB6JZJF2Qfa+gsWwv7+HhBRfbZrWfToydqwpM1NSLvPpgTYSUw==@lists.linux.dev
X-Gm-Message-State: AOJu0YymgfcatPlkHke/Ma94Cz4Cn1EGz0jF198Y/GoKymqEP7DB31ze
	7NfVyzzIbfbO9LpdUGNoq4DWftOGCHUGzdUGhjEj4Gpetj9+Jfe6c2AoSV+n5DEXPq5SQgDxJN/
	XcrFa9bgCgSj9SbyO0gIGKDguq4c2H8B8YI/w8YlvaOdI7bU6wVmcHwmRgKpFAw==
X-Gm-Gg: AR+sD102pSopxD71jq9tfmKgRM+hrfmzvfOHfTsSVBrOZPfxPTCu5gR9WGyVtqnsFWW
	dwj4L8AiKltgqxR9Sv07cdgvqCDcEvNEiqotyyMirRvd3ss47ibg1daqoJiB5ACb+jFVmnLaJos
	5A6CXrdUvzrCvTMxhnK6Nsm91TcbDQtFgAB90Txgdv+ej+eJJLuTSmfp/ZbABz+mxOMOWuJ8mG/
	gkgpgha4fEWwWGUry7facVFphcgrdHF2Jp6co9tUW8kToEy0tQVPaoYpt2+ELmqzMvAkFxdpmES
	xPOieYgIypslbPOWCPf20tF8QhbDFF263FPJyRH/FFxun8158m8AgAkIGdrdHPasrVFtJ3WXfCD
	Oz08MZ4+2b9hTl5d3YTJfaY012M+PCWQRY2Q1KUNN7PiqRbOWCXyaJU1ZVtY6UaO6x0oz
X-Received: by 2002:a05:6a21:6f8b:b0:3bf:b8d8:8296 with SMTP id
 adf61e73a8af0-3c90d44c15dmr1630970637.26.1785441521698; Thu, 30 Jul 2026
 12:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1785307984.git.zihanx@nebusec.ai>
In-Reply-To: <cover.1785307984.git.zihanx@nebusec.ai>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 30 Jul 2026 21:58:25 +0200
X-Gm-Features: AUfX_mws6f-Jk1VhHbkEH5LNm4teTltMrpUt8ATwGTSQqakWg2aBeHgGXcQL_QU
Message-ID: <CAAVpQUCLAk3qwGuxg1nHeRR5XX6jFt-9PF+Qq+1TZZTEA+DTmQ@mail.gmail.com>
Subject: Re: [PATCH net 0/2] tcp: diag: fix unbounded bucket lock hold in diag
 dump paths
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	ncardwell@google.com, dsahern@kernel.org, kees@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, fw@strlen.de, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 1:29=E2=80=AFPM Zihan Xi <zihanx@nebusec.ai> wrote:
>
> Hi Linux kernel maintainers,
>
> We found and validated a issue in net/ipv4/tcp_diag.c and
> net/mptcp/mptcp_diag.c. The bug is reachable by a
> non-root user via user and net namespace.
> We've tested it, and it should not affect any other functionality.
>
> We will provide detailed information about the bug
> in this email, along with a PoC to trigger it.
>
> ---- details below ----
>
> Bug details:
>
> inet_diag TCP dumps currently execute attacker-controlled
> INET_DIAG_REQ_BYTECODE programs while still holding the listener,
> bind, or ehash bucket locks in tcp_diag_dump(). If the bucket is
> heavily populated and the bytecode is a large reject-all filter, the
> dump path can spend an unbounded amount of time under the same bucket
> lock while walking attacker-arranged sockets.
>
> The reproduced listener case places 131072 SO_REUSEPORT listeners onto
> one colliding listener bucket

This sounds very unlikely to happen.

If you cannot trust your users, you should audit them
properly (e.g. limit # of FDs, use BPF LSM, etc).


[...]
> ----BEGIN crash log----
> [   18.495442] watchdog: BUG: soft lockup - CPU#0 stuck for 3s! [poc:1034=
]
[...]
> [   18.495449] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S unknown 2/2/2022

It seems the soft lockup timeout was deliberately set to be short to
trigger a splat, but 3s on QEMU should be much shorter on a real
machine and it should not be a problem.
