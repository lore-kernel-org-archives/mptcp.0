Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794731056;
	b=KxdaEVl0+B31II3pn+PQVCo8+/qsPSXDw+nloymj65aVJEZgXKZ9truih0TZ4ZUNYZ0t
	 TZxaeiZqzGVCWELbZVo8y2iH7kC3kk0eeC8YpFnI0zbcQ1TfBpoR/bXxrXgn9SjBthzbC
	 ZftjQh7dZTYWwqbY7EPx9HngfmBSSJCbsIdCi7nV4RfzCTPApj1NaUvoM8djxpA/oHBL2
	 DzkEn7L6+LN8BrfSiNGXmriGhMbTBERjJqXfUyPTGvhMDRdjQts2969xf0C4Z6ovWX0jt
	 V0yQ0IWSAcmvsgcGp/VyDLx2Cqe+UGW6QdCzXtlMAIXMIHTqNBdRH84xU3MkdfwWkzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794731056;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Hq186HcHzYDaq7zOMRjbrOqIIwfSHvf8FBnXTnHKzXM=;
	b=vOJeRzxkOjg810jqBlblYXhtW69ANN1DSf7YQgbzem1LsdLIDGVt/WwpP6MfO0vQT0Wy
	 +NWR3CH2PCIPqiLxGsuIaK/ZZYFB/eTr26q78DL/T9v100Bj+72xsv77x/2S1VYmjcd9y
	 JvxQ1LUPxGxhbLrssK36cYHA3J8EbIgMoKF7s4cPXEngNcczME5sT9ZSoy8/YFMowiKNF
	 e0lgkBgWk8WMpjWpFvSPpuIhm3hxjSL6ag4W1id/V3ruqU2BuqHCBWaxoCVVHtdCtF3sp
	 YpT9tM5uHS3+en6oNvPd12NCqNBN8A969kQoEPdl1sVOqlLXu8UcT/TrsWLdaL9L1ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQ8gElEn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA01606A33E
	for <mptcp@lists.linux.dev>; Sun, 15 Nov 2026 08:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQ8gElEn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C171F000C8
	for <mptcp@lists.linux.dev>; Sun, 15 Nov 2026 08:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794731055;
	bh=Hq186HcHzYDaq7zOMRjbrOqIIwfSHvf8FBnXTnHKzXM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EQ8gElEn+s4NqzNS5KqWN3kSvI6ph+XLoMLW4SuYbcAC77irL5Rw71hMl13khtfUC
	 w/gIGMyyc+vrbb7oLdzYstdCjZfP9/gMb9wiiQKElbVXKIKfIVdst8L0/+kydgakjs
	 qXw08gATlgXosPffII6Y1uup1yPUH+oOmv6+5B414pvzBSbaY3KWV4vtkrtB48mABm
	 CwE2LQA/C5nsXoPliB+lWKfZsFLgBQop65lbqrGoj/L3yqoFkcilsUandcT3MTiLyg
	 iXLECPul4Vq06LWyyG3MokQoMrqwKQ1QuQpv3zWbTGjiOr0RgfupJLBjp2yFcHqPfX
	 E8T7MWklGOt1Q==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6d68de53053so1511049eaf.0
        for <mptcp@lists.linux.dev>; Sun, 15 Nov 2026 00:24:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErF9tdDYj5rJtV7d6wHOlwTVvSLQgHdik8XyWTHCj3vIiuo3IT341NGXOoI4WBzQ196wi/uJGw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/yptPVuGNeXf3q+1DcEmqDNmFn+zZysHGBvNiAmOCj/Uow4FWZ
	SwPSazPAlcrISVFSmqRWBWmCUIjeDBAhKoEGfr+nSP2Hhohs/kqrV6j2tdHU8QtUEBIGTFrkT1b
	0+ujfjw9M0fmpbyo9jziCTnxM/gZabCM=
X-Received: by 2002:a05:6820:a70c:10b0:71a:eea9:8173 with SMTP id
 006d021491bc7-71aeea9868fmr74562eaf.85.1794731054847; Sun, 15 Nov 2026
 00:24:14 -0800 (PST)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <cover.1794672619.git.x-professor@outlook.com>
In-Reply-To: <cover.1794672619.git.x-professor@outlook.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Sun, 15 Nov 2026 09:24:04 +0100
X-Gmail-Original-Message-ID: <CAL4WiirENP_SBccpu3qq51f6u4E7BwFoadEARZctwm0CGNCusg@mail.gmail.com>
X-Gm-Features: AclHuK-t99I7UXoH9TmlU6O0jB4ekfdvLqJegkYIbqioWircJJ73o_0Q7EGKhbQ
Message-ID: <CAL4WiirENP_SBccpu3qq51f6u4E7BwFoadEARZctwm0CGNCusg@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] tcp/mptcp: prevent blackhole timeout
 arithmetic wraparound
To: Yingjie Wang <x-professor@outlook.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>, 
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, "rdunlap@infradead.org" <rdunlap@infradead.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "ncardwell@google.com" <ncardwell@google.com>, 
	"gang.yan@linux.dev" <gang.yan@linux.dev>, "kuniyu@google.com" <kuniyu@google.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>, 
	"matttbe@kernel.org" <matttbe@kernel.org>, "martineau@kernel.org" <martineau@kernel.org>, 
	"geliang@kernel.org" <geliang@kernel.org>, "ycheng@google.com" <ycheng@google.com>, 
	"weiwan@google.com" <weiwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le sam. 14 nov. 2026 =C3=A0 17:12, Yingjie Wang <x-professor@outlook.com> a=
 =C3=A9crit :
>
> The TCP Fast Open and MPTCP blackhole handlers multiply writable timeout
> sysctl values before adding the result to a jiffies timestamp. The
> multiplication is performed in 32-bit unsigned arithmetic, so a large
> value can wrap into a short delay even on a 64-bit kernel.
>
> With HZ=3D1000, a timeout of 6912213 seconds and the maximum multiplier o=
f
> 64 should produce 442,381,632,000 jiffies, but the current calculations
> truncate the result to 512 jiffies. Both patches compute the delay in u64
> and cap it at MAX_JIFFY_OFFSET before adding it to the saved timestamp.
>
> The issues were found using a static analysis tool. In the v1 arithmetic
> A/B tests, loopback reproducers induced 12 blackholes, waited 1.2 seconds=
,
> and then made a new connection:
>
>   TFO:   base probe 1.026 s, TCPFastOpenActiveFail +1;
>          fixed probe 0.000 s, TCPFastOpenActiveFail +0.
>   MPTCP: base probe 3.087 s, MPCapableSYNTXDisabled +0;
>          fixed probe 0.000 s, MPCapableSYNTXDisabled +1.
>
> The TFO counter records another failed active Fast Open attempt. The
> MPTCP counter records a connection that skips MP_CAPABLE and falls back t=
o
> TCP while active MPTCP is disabled.
>
> Changes since v1:
>
> - Add a reasonable upper bound for the TCP Fast Open sysctl, as requested
>   by Kuniyuki Iwashima. This version proposes one day (86400 seconds),
>   using the existing IPv4 one_day_secs bound, and documents that limit.
>   Keep the existing MPTCP sysctl input range.

The one day limit, the u64 computation and the clamp look fine to me
for the TCP side: with HZ=3D1000, 64 * 86400 * HZ still does not fit in
32 bits, and 32-bit kernels need the interval to stay below 2^31 jiffies
for time_before().

Why is MPTCP left alone? Kuniyuki's remark applies equally to
net.mptcp.blackhole_timeout: nobody needs a multi-day initial timeout
there either. I will let MPTCP maintainers decide, but having the two
sysctls behave differently looks odd.

> - Clarify that the multiplier is limited to 64 and the final delay is
>   separately capped for safe jiffies comparisons on 32-bit systems,
>   addressing Gang Yan's comment. Keep the READ_ONCE/WRITE_ONCE pairing
>   annotations next to the timestamp reads.
> - Identify the original runtime results as v1 evidence in both commits.

Please do not do that. The changelog of each patch should describe the
problem and the fix. Version history and test notes ("In the v1
arithmetic-only test...", "On the v2 kernel...") belong in the cover
letter or after the --- marker, not in the commit message.

> - Retain Gang Yan's Reviewed-by tag on the unchanged MPTCP arithmetic fix=
.
>
> v1: https://lore.kernel.org/r/cover.1794325665.git.x-professor@outlook.co=
m
>
> On the final v2 x86-64 HZ=3D1000 kernel, TCP accepts 86400 and rejects 86=
401;
> MPTCP still accepts 86401 and INT_MAX. Boundary tests also cover zero,
> negative and oversized values, failed-write preservation, defaults, and
> network namespace isolation. The large timeout used in the v1 TFO test
> is now rejected by the TCP sysctl limit.
>
> The MPTCP blackhole test was rerun on this v2 kernel: all 12 clients
> completed, and the probe used TCP fallback directly (0.000 s,
> MPCapableSYNTXDisabled +1). The full x86-64 kernel build and affected
> object builds on x86-64 and i386 passed. The upstream TCP and MPTCP
> selftest suites were not run. Full allyesconfig/allmodconfig W=3D1 builds
> stopped at warnings promoted to
> errors in unchanged lockdep, coda, and x86 callthunks code;
> the affected objects passed W=3D1 KCFLAGS=3D-Werror in both configuration=
s.
>
> The patches are independent and have separate Fixes tags.

About the Fixes/stable tags:

This needs an admin to set a timeout nobody would use, and the only
consequence is that active TFO (or MPTCP) is retried sooner than
requested.

Also patch 1 now makes the TCP sysctl reject values that were accepted
before. I do not think we want that in stable trees.

Please drop the Cc: stable and target net-next.

Thanks.

>
> Yingjie Wang (2):
>   tcp: avoid wrapping Fast Open blackhole timeout
>   mptcp: avoid wrapping blackhole timeout
>
>  Documentation/networking/ip-sysctl.rst |  1 +
>  net/ipv4/sysctl_net_ipv4.c             |  1 +
>  net/ipv4/tcp_fastopen.c                | 12 +++++++++---
>  net/mptcp/ctrl.c                       | 12 +++++++++---
>  4 files changed, 20 insertions(+), 6 deletions(-)
>
>
> base-commit: 30c71476d842b094651bd7712f6c8ee8716147d0
> --
> 2.43.0
>
