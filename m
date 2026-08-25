Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94703DB64B
	for <mptcp@lists.linux.dev>; Tue, 25 Aug 2026 08:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787645676; cv=none; b=Smd8Sa4w66+u+okitLHAIDwzPSdswVUD/5ESop6a7VzgzxCgIRiHVzFEAc/HEojYJyPUdSSqmMCGumrbnFDWvLF55gtqaTg0CpXypku53nofQRC7UVWToeqDOrRLNn3oZ6Pf7mKOI/ql1+xDy6DV2A65rP9FVKYvY4M3tzm9Lxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787645676; c=relaxed/simple;
	bh=2oByTvSJSRbVloa+V5MgdZBpqhrwYMCKeZYPckNaK9A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oDxwdJjnM5G+lu4HF6i7/lPjSnQqvqAPWmIWf4ss9dA0hoJ1wicc3UAKaNAXD8uxTUPJd+L48zo2d2EUqFMTmbsvIR9MmXMSRrB2BEem3E+AZlCXs8eb15+5UN+MI3u5SoD+xAMCi2B0Mtu7X3SUdBaDX1trqAT8j0vb5wJWC9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQpky2d9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQpky2d9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6278C1F000E9;
	Tue, 25 Aug 2026 08:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787645674;
	bh=SAzTfZSqe1PTxtw1z8Pt8iaqjc4rZ6vIiHklE9u3UTM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EQpky2d9b1l9QNgci1qETM4HPx4ZsWvxkUYiZav1GNZ0k+ilxGBpyolvgZY2Hbv+B
	 akvMoBw+f3Opj3Rfvm4CMjxGiEgdpHCITbtIesJcsEIE20/CGqPjl7h2yiUk0jl+j7
	 xMF0lUfgHKst4iFkUVrbKWjyobn1HIo+/E56fvFQmIsKhodnl6Q2jv675h+rrExBX+
	 OTfAioXL7zn7F5DPTV3w4Hk3EClpcZFWAUEXXbFvQ8FR0Z7MwH7DNTAPGrVvoK8rgJ
	 RA+s4Jf5Q0GZ1Gis0ueSTMm8z2ts4u+1MtVqoIQuJnda61sPetJnhzwh+qhPxxLuo6
	 afu3A30cgIK0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v8 6/8] mptcp: defer read_sock cleanup to
 mptcp_worker
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <bf15214a576effacece5f5f905c1e2226c45d35f.1787644449.git.tanggeliang@kylinos.cn>
References: <cover.1787644449.git.tanggeliang@kylinos.cn>
 <bf15214a576effacece5f5f905c1e2226c45d35f.1787644449.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 08:14:33 +0000
Message-Id: <20260825081434.6278C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Data Race
- [Medium] Lockdep Warning
--

--- Patch [6]: [PATCH mptcp-next v8 6/8] mptcp: defer read_sock cleanup to =
mptcp_worker ---
commit 428fada46f89f37bf4a52466b0f6ca0c4349248e
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: defer read_sock cleanup to mptcp_worker

This commit defers MPTCP read socket cleanup to mptcp_worker() to prevent l=
ock
recursion on sk_lock.slock. It introduces a new MPTCP_WORK_READ_COMPLETE bi=
t,
allowing __mptcp_read_sock() to schedule cleanup asynchronously when invoke=
d in
BH scope during TLS data processing.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index d0425ba96ad54..623edce84b8ba 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3141,6 +3141,15 @@ static void mptcp_backlog_purge(struct sock *sk)
>  	sk_mem_reclaim(sk);
>  }
> =20
> +static void mptcp_read_complete(struct sock *sk)
> +{
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +
> +	mptcp_rcv_space_adjust(msk, msk->read_copied);
> +	mptcp_cleanup_rbuf(msk, msk->read_copied);
> +	msk->read_copied =3D 0;

[Severity: High]
Could this result in a data race on msk->read_copied?

mptcp_read_complete() is called from mptcp_worker(), which holds lock_sock(=
sk)
but not the mptcp_data_lock() spinlock.

Meanwhile, __mptcp_read_sock() increments msk->read_copied in BH context wh=
ere
it holds mptcp_data_lock() but not lock_sock(sk).

If both run concurrently, updates to msk->read_copied could be lost or
inconsistent.

> +}

[ ... ]

> @@ -4612,6 +4621,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *=
sk, u32 *off)
>  /*
>   * Note:
>   *	- It is assumed that the socket was locked by the caller.
> + *	- Can be invoked in BH scope.
>   */
>  static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
>  			     sk_read_actor_t recv_actor, bool noack)

[Severity: Medium]
Will this trigger a lockdep warning when invoked in BH scope?

Since __mptcp_read_sock() is now intended to run in BH scope without holding
lock_sock(sk), the existing msk_owned_by_me(msk) assertion at the beginning=
 of
the function might fail when called from the TLS data path.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787644449.gi=
t.tanggeliang@kylinos.cn?part=3D6
