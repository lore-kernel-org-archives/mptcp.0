Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB4836EAA4
	for <mptcp@lists.linux.dev>; Fri,  7 Aug 2026 08:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786089945; cv=pass; b=HCz0uATC32Z+pFIeP9TQN3QXmDHLFgaPyyr/cY6uzDwZbjEA6WDVKd/VDDP8zdOhCgxZQK0obu1WHmKGYjVPR2NwlTC0gtmMeHwiEI/s5ot9HSe9P8zehADcTe5p4MMUAPgFmf+pic375PFu9GfhTmDKI3rdzsW/CRJXsoaivhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786089945; c=relaxed/simple;
	bh=oBSLUeALxK2mQhj3ycbejPHmkcN2bDUHj3PQWDuwt4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jg5aKjHzf2/8KdXOgel04vZO3NQQCNCXcc0cWN3TTwBn4hWXX4NUlCDFsNRNG9aOdLFQGHSBQwKUGFqejnrek5l17kPSJnLDlnIk2t0dPZwtW620RqKduQO3P8vXWfwiUW2z9kuDe5NMizi+W9AGIpMse7FNdREiB0tMflTxEtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=RJZClcKV; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="RJZClcKV"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39c7ce122c7so25994451fa.2
        for <mptcp@lists.linux.dev>; Fri, 07 Aug 2026 01:05:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786089942; cv=none;
        d=google.com; s=arc-20260327;
        b=jN5Ba3oFWmx31Lq8kTHyQLodc+poIwi+vrIwyYadngMIc0hd/BeM2IsqrMclnXYcA4
         rk3Tssx7ejaGLOjAK9aWwpzMuBdoo4zLJ+U7l4KXHgPm1EBwGo2q6nR85NnL7UUT/kgi
         2L8pCW1DYQ1mJyrXe/XIIe3J0QatKv56QvoPe6t32HJJGjs356f2XvzS+1vMDkwp1wFU
         mCcEte05m+XRYcWCrR5Bmq7G/4SwTujYS3BZmz8IVnZcPp62VztfMYkeWf1tSx5HS+lB
         qMsjw0T5eq8n7h5/5Q8qt4UtZfCj4m3JpYUTZg1+fJxVH3rC6qFKH5bWCL/unHliyMQF
         TuZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OKakl6P7JpAsPOM14zRfjMCdXJDFaGYpoI2nR2ruN+Q=;
        fh=+YdJJEV3pd1b/J+WyCuQ67dT6dCO3RM5BsEQqB0hTa0=;
        b=T2KCzQ3PvwMUgGs7M01Qz/79wsX+Vmi61SazSFGY1sc9cVG83Yy5zGtExU0k3RiiB+
         GvkbqkCn0FwG9ScdLrvo3XJ2YIbSX81dANVJVtTqZ4LVF5v4/IihL4/BGakVUlsENx2R
         Q8jlU0TPwsbM8DxNp3FgzrqgoH18RJNt5REQx+K+swB8J57VmJ32Otmmi1fxlmLuqVfO
         N0/8XJ6YsLzosToDsg86ZhyWQg4gimHC6DCsqD5jIB5yilq5eF520mpwtq7IdGYtsOf9
         iIQDNzGyozZ+9wTVebR/wvOsO8uZJ1Acb+aTojSBMi4488XMmETqoxz3QtqDIU46qzWi
         bo+g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786089942; x=1786694742; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OKakl6P7JpAsPOM14zRfjMCdXJDFaGYpoI2nR2ruN+Q=;
        b=RJZClcKVFbYZyUBL2RFAwlDO7dCezXJaloJjRwFv8Bowh0HHR2xzUzLgYkIJkjbg8M
         M0EaJwsb+gsLhi2yHb6QS6SpHM4KcKvMGwXqz2b/hVFHso0VI82Z9NlbZxd14DDNyocq
         BZBK0f+ZrLC2KpKWlxSIck1WvIjEzyXmmFkuZgZ1BJbXIBVHPlyLXNx7TXedZm6rRQEA
         WuPkiQMbRMm7wu1wotCri5OUqFpt3kPrWwyJyod0n0PDNtRzRMXMKrG4rn89oItHRVuc
         /ZlqAWetEqJpr1zuu7XP9qqmhaMrzZ2KEzH7RvMBZmOyt85O54GX/AKMVz/yEo7iKVyD
         w+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786089942; x=1786694742;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OKakl6P7JpAsPOM14zRfjMCdXJDFaGYpoI2nR2ruN+Q=;
        b=qZ4nlQKyTMXhUrn3ax3YT3J58ayZ/7VVFiJBwBCBc8hIPet85ud1c6Xiu5aqtTsUlE
         kxLSOkFGCSCxEbKJlC+rH3AOBwd3QZW0ShcBohgx4g4p9hlyYhLfqbWAena3FNnXrWy3
         8MvWWPMXprxej0cEQx1rD9LanNe1CVWCJvvTsmreb9gykDUoiMX9FfM+A/cTAxnz0n0U
         VnlhRpnWZm2hjse6GziWvrgiteegjNm1CMXiG+Y1m+J9AHWuH8oqt20GffiHqgFWXjJx
         /Yoz+a9hG0O8nEk6FcNqJ5Sl3d++LLsoHIlYE6dSjWVWiBCtXTpTb9uoiNkwKjhBxvCH
         c5yw==
X-Forwarded-Encrypted: i=1; AHgh+Rq4oWkq6MZ/yJJxcxbm8Po3tWGX900SJ0B8BSpbLkuXt+0JgPGBjDSIka9fTsEtVAB7AV5XpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9dNXXDbq8KmM90dFyFDoZ/xMdpSq+3iZ7bsv2vjajEMvA2zNc
	L6VCtd01Gg92PB49jdcZXGVT3l7cqTFkfHs7xHp1B2nAKmmqJlCpaikirdn5zqAut5CtoYDE4mR
	5kp720CeaZz5Ppuqoc5fOA7QxZ1pI/sJTq9LkcckY08Q=
X-Gm-Gg: AR+sD13/a3ro40keJuzykjBZH3e4KRfBaP38qRYBdiDZ6P3hQTTNjNWXszIUrVobzm4
	foLzdzCribNuWG5+vMxeYNEiiqoojhMlSKmWynWPV9CjezsDFPmGtPRLw8c0wnFuD1Dc6hhx1JF
	kubY380kP4eHe9YnQw3df/zNdEbuGEdIYYQEWPAF12VyKoGwjSsvUdmLzTfUkPWE03UXTTUNAVy
	Fu70hK+b7RJP7NPJ/j7opKBZBnCDx7F7MgT9Sc+APtjI+p1wky25eH1XdV6R5QL7hsymx9NA0zX
	9CCPH0zxzMdEcJsxJw4zGL46PTj5LU3vtIyJKwJ4ZGhMVZxDjNBDZQFPVE13eBbsWzU8/E+Gqjx
	rfrL6WIqM5vdB
X-Received: by 2002:a2e:a54e:0:b0:39a:fd6e:cac6 with SMTP id
 38308e7fff4ca-39fbb31824emr25488821fa.25.1786089941645; Fri, 07 Aug 2026
 01:05:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1785995291.git.caoruide123@gmail.com> <202a6f62-6ffb-4f18-9168-66621b2963f3@kernel.org>
In-Reply-To: <202a6f62-6ffb-4f18-9168-66621b2963f3@kernel.org>
From: Nebula Security <vega@nebusec.ai>
Date: Fri, 7 Aug 2026 01:05:29 -0700
X-Gm-Features: AUfX_mwkrsTStAIMuBqX2jClx5RWNubkdHGe6Fv8dElV3JTzKRJ9hQSS-zgSWDs
Message-ID: <CAHYtud03+zYTwFtbz5-aMNDrbijnH7v=5QXoyiCrL88hgcckoQ@mail.gmail.com>
Subject: Re: [PATCH net v3 0/2] mptcp: fix request migration ownership
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Ren Wei <weir@nebusec.ai>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	martineau@kernel.org, geliang@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	ncardwell@google.com, kuniyu@google.com, daniel@iogearbox.net, kafai@fb.com, 
	kylebot@openai.com, david.lee@trailofbits.com, caoruide123@gmail.com, 
	sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 5:43=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org>=
 wrote:
>
> Hi Ren, Ruide,
>
> Thank you for the v3! Here is a quick reaction, only about the
> reproducers, not about the kernel code:
>
> On 06/08/2026 13:14, Ren Wei wrote:
>
> (...)
>
> > Changes in v3:
>
> (...)
>
> > - Added a packetdrill MP_CAPABLE reproducer and decoded warning.
>
> Nice, very appreciated, thank you!
>
> I confirm they work well!
> > // poc for MP_JOIN:
> >
> > // Minimal reproducer for a stale subflow_req->msk after reqsk migratio=
n.
> > --tolerance_usecs=3D200000
> > --non_fatal=3Dpacket
> >
> > `sysctl -q net.mptcp.enabled=3D1
>
> Small details to help you next time to look at packetdrill reproducers
> for MPTCP:
>
>  - You can add new tests in gtests/net/mptcp/<dir>/<file>.pkt from the
>    MPTCP packetdrill repository.
>  - Then here above, you can add: `../common/defaults.sh`.
>  - And execute your tests with run_all.py from the gtests/net dir, e.g.:
>    ./packetdrill/run_all.py -lv4 mptcp/<dir>/<file>.pkt
>
> These tests will then be executed from a dedicated netns, using many
> sysctl settings: this helps to reproduce issues in a more controlled
> environment.
>
> > sysctl -q net.ipv4.tcp_migrate_req=3D1
> > sysctl -q net.ipv4.tcp_synack_retries=3D1`
>
> (detail) Here, tcp_synack_retries can be set to 0, then the sleep at the
> end can be reduced.
> > // Listener A and the owning MPTCP connection.
> > +0     socket(..., SOCK_STREAM, IPPROTO_MPTCP) =3D 3
> > +0     setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
> > +0     setsockopt(3, SOL_SOCKET, SO_REUSEPORT, [1], 4) =3D 0
> > +0     bind(3, ..., ...) =3D 0
> > +0     listen(3, 8) =3D 0
> >
> > +0.0   <  addr[caddr0] > addr[saddr0]  S   0:0(0)         win 65535  <m=
ss 1460, sackOK, TS val 1000 ecr 0,    nop, wscale 8, mpcapable v1 flags[fl=
ag_h] nokey>
>
> Also for next time, when validating the listener side, feel free to drop
> the TCP Timestamps option if it is not required (like what you did with
> the other test): that makes the .pkt file more readable.
>
> (...)
>
> > MP_CAPABLE packetdrill reproducer:
> >
> > // Reproducer for MP_CAPABLE request token ownership during TCP req mig=
ration.
> > //
> > // The first listener owns the request created by the MP_CAPABLE SYN.  =
A second
> > // SO_REUSEPORT listener is added only after that SYN, then the first l=
istener is
> > // closed.  The SYN+ACK retransmission timer migrates the request to th=
e second
> > // listener, and a later request timer destroys the migrated request.
> > //
> > // On a vulnerable kernel, inet_reqsk_clone() raw-copies token_node.  T=
he clone
> > // is not the token table owner, so destroying the migrated request tri=
ggers the
> > // MPTCP token ownership bug.
> > --tolerance_usecs=3D250000
> >
> > +0     `sysctl -q net.mptcp.enabled=3D1`
> > +0     `sysctl -q net.ipv4.tcp_migrate_req=3D1`
> > +0     `sysctl -q net.ipv4.tcp_synack_retries=3D2`
> > +0     `sysctl -q net.ipv4.tcp_timestamps=3D1`
> > +0     `sysctl -q kernel.panic_on_warn=3D0`
> > +0     `sysctl -q kernel.panic_on_oops=3D0`
> > +0     `ip tcp_metrics flush all >/dev/null 2>&1 || true`
> > +0     `tc qdisc replace dev tun0 root pfifo >/dev/null 2>&1 || true`
>
> Same here for `../common/defaults.sh`. Then I guess you only need
> tcp_migrate_req=3D1 and tcp_synack_retries=3D2 (set to 0 to reduce the la=
st
> wait), and "wscale" will always be 8 in the S(.) instead of depending on
> the environment.
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>

Thanks so much for the detailed suggestions! We learned a lot from
them, and we=E2=80=99ll definitely take them into account for our future
patches.

We=E2=80=99ve also tried using packetdrill as the PoC for patches in other
parts of the networking stack, but some cases don=E2=80=99t seem to be full=
y
expressible with packetdrill. Anyway, we=E2=80=99ll try our best to use it
whenever possible.
