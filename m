Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D8831352D
	for <mptcp@lists.linux.dev>; Sun, 13 Sep 2026 10:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789295894; cv=none; b=AX6ibEx6FZ0CW0d7ET6+b19OodqIClZOU76dpqgjSxZpCm3P0p8MSltv8gp+M6yFjDBQUE73sHMGyqsZkTZ89SOUW0qsg8n0oI6SrohRqbsMTjNBHswcBlrWOW96c0IKMPwWn3YVzz7czEelcu5lZra4biCND7uck8YHeyG5ihM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789295894; c=relaxed/simple;
	bh=QYBegstQV/V8Pxia/ybAXPtNqnifnh64lPMUhlgJa6w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d4xLx0jCiC1QcpUo79aLXN70Brev/PH/mMHUWBtepk75RCaiVpcwn5Zc3wp5UzVpmAJK0IDFE67LpoVtMXVuJ3Akl5uJIfBVPxN/p4Sad0YjdNsAi2QeSTs15OxP29sYTrknVjliDLSfp3Uad/zBvNmAZaB881XHBzrX7Uq7j/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nd/bT75B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nd/bT75B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029221F000FF;
	Sun, 13 Sep 2026 10:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789295891;
	bh=oj0GVCHKtvBKK+GA960Zqyhyiem9m2NEHMBBnnLIs5o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nd/bT75BZmnPquNGLp4CDHEtbXxE5ZT2eTspJO2OBA8fxFPR//qR2S/9aFoUPRcS9
	 hCYAVCqYiP5mGZmMfCTZwDKIJu92g786xvwxhwlLztWZAHKMYPEnFnGSjiFhC+HwpH
	 RxN62qAKThohfzwRCYHMfV7kQYpQw6ZOKUpf/b2Jh9rl/OyOc9fNKTPPqgwh4yD4EM
	 jwqME8Sw1aVx73DuuTmyJdngk+wx6j+xkK15oCzg5RIR6SXlzXji5Ees7fDlYwVhZx
	 sUxTDmQNsuH9HWSWv+UWm4TE7k4ATF9dnVXaJ0NffUko0a46bZocDFYxEDGioZi4Mj
	 z7z5TsldkgHHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v5 11/16] mptcp: add TCP_REPAIR sockopt
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <15960ae7fff68167e041400db0480e55950ea1c1.1789294365.git.tanggeliang@kylinos.cn>
References: <cover.1789294365.git.tanggeliang@kylinos.cn>
 <15960ae7fff68167e041400db0480e55950ea1c1.1789294365.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 10:38:10 +0000
Message-Id: <20260913103811.029221F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The check for repair mode in __mptcp_close() is placed after the f=
astclose and shutdown sequences, breaking silent teardown.
- [Medium] mptcp_setsockopt_sol_tcp() silently ignores error codes when set=
ting TCP_REPAIR.
- [Medium] TCP_REPAIR is missing from mptcp_getsockopt_sol_tcp(), causing g=
etsockopt() to fail with -EOPNOTSUPP.
--

commit 31eec098dfb51659558f320d2e2ec1abfdffb89c
Author: Geliang Tang <geliang@kernel.org>

mptcp: add TCP_REPAIR sockopt support

Add TCP_REPAIR socket option support for MPTCP, required for sockmap CRIU
checkpoint/restore. When TCP_REPAIR is set on the first subflow, skip the
normal connection handshake in mptcp_connect() and transition directly to
TCP_ESTABLISHED. On close, skip the shutdown sequence and jump to cleanup
when repair mode is active.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index c5be29767cb15..07132976016e3 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3560,6 +3560,11 @@ bool __mptcp_close(struct sock *sk, long timeout)
>  		__mptcp_wr_shutdown(sk);
>  	}
> =20
> +	if (msk->first && tcp_sk(msk->first)->repair) {
> +		mptcp_set_state(sk, TCP_CLOSE);
> +		goto cleanup;
> +	}
> +

[Severity: High]
Does this check evaluate too late in the shutdown sequence?

Since mptcp_do_fastclose() or __mptcp_wr_shutdown() can already be invoked
just before this block, could closing an MPTCP socket in repair mode incorr=
ectly
leak RST or FIN packets to the network instead of being silently dismantled?

>  	sk_stream_wait_close(sk, timeout);
> =20
>  cleanup:

[ ... ]

> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 922f6ae5c80cb..d2d1c9d1ed1d7 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c

[ ... ]

> @@ -918,6 +919,7 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock=
 *msk, int optname,
>  	case TCP_CONGESTION:
>  		return mptcp_setsockopt_sol_tcp_congestion(msk, optval, optlen);
>  	case TCP_DEFER_ACCEPT:
> +	case TCP_REPAIR:
>  		/* See tcp.c: TCP_DEFER_ACCEPT does not fail */
>  		mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname, optval, optlen);
>  		return 0;

[Severity: Medium]
Since TCP_DEFER_ACCEPT does not fail, returning 0 unconditionally is correct
for it. However, because setting TCP_REPAIR requires privileges, can the
underlying tcp_setsockopt() fail and return an error like -EPERM?

If so, does discarding the return value of mptcp_setsockopt_first_sf_only()
cause these errors to be silently swallowed while returning 0 to the
application?

[Severity: Medium]
Also, should TCP_REPAIR be added to mptcp_getsockopt_sol_tcp()?

If it is omitted from the switch statement there, will applications queryin=
g the
repair state via getsockopt(SOL_TCP, TCP_REPAIR) incorrectly receive
-EOPNOTSUPP? For example:

net/mptcp/sockopt.c:mptcp_getsockopt_sol_tcp() {
	...
	switch (optname) {
	case TCP_ULP:
	case TCP_CONGESTION:
	...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789294365.gi=
t.tanggeliang@kylinos.cn?part=3D11
