Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFC916A95B
	for <mptcp@lists.linux.dev>; Fri,  7 Mar 2025 03:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741319688; cv=none; b=BAXnyXXOTThvSb4kfF2usdHqeVUmOGt7hFXQ4A33SmJ6Ew0ymQt1oqEAnB15Iluus78KgX9y5VcZ5qtqOk7hk/Kn1dHA0faVnb1q/Q9N3T2DlsQ4GHNWmSBPC528XguTZxejvOvUjpsLoWeUfNU63cizgJMlCplqXr/O6JQDy3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741319688; c=relaxed/simple;
	bh=sanWIQfn/liNuBP+tzdXV7CW5jSf6THXePn2lMlxa70=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HvR9fIkgHeqJ7hR068VHJ0kp+aNLNU6sJi/4/VT7XcSEH1Jtjs34og5HUB4JCKm/imltY4hPxs+ZyHBy92ZadtrWqK09asMdOQe3Ap/3z3ktmPEEUBf7cNGrZdOy8JNkolTeQAfktfmMKiq+AOOGp+ffK/f3tAghU3GQnc7OXog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNT6g+7q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNT6g+7q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60520C4CEE9;
	Fri,  7 Mar 2025 03:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741319687;
	bh=sanWIQfn/liNuBP+tzdXV7CW5jSf6THXePn2lMlxa70=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=YNT6g+7qRAoDIq36uj9+rdDVogY8/wUaS3D7Ed/mVcKJHebqKjA9X7ai97VnC2pWo
	 isEm00Dtqbp9eb78tdUlDIN/bi4+uKdGE/yg7cCXWRHD8l2myRU+muYHhuKLiByl0A
	 2Whg2J3w5UIYvhgrqE29DaJdrTuQKKQZZX1FupCuERkmhAA7D/KZ+2dbViuY1Nm+rN
	 tCv9qgt9rkqXbt409EsY0hdEMXzxueLU/H+c/NWsrcpvlPDVnTDvSuNHwRr1FYCWIk
	 +1WCWJLcJb4UlntWSdsadwn55jyPn5Su4E4qMmaxw0QtQQA0qFss8AuDfTJtyF8RNj
	 I2l5z9r1W96RQ==
Message-ID: <7691b3bbc2cc5e9507a4187877e4cd821a73744b.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v5 2/5] Squash to "bpf: Extend
 bpf_skc_to_mptcp_sock to MPTCP sock"
From: Geliang Tang <geliang@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Date: Fri, 07 Mar 2025 11:54:39 +0800
In-Reply-To: <b45a0591-597a-46cf-7315-cf4dce7dbd7a@kernel.org>
References: <cover.1740997925.git.tanggeliang@kylinos.cn>
	 <c43f5e1fe8da4db01749ede9d18af1a3a2134fd4.1740997925.git.tanggeliang@kylinos.cn>
	 <b45a0591-597a-46cf-7315-cf4dce7dbd7a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Mat,

Thanks for the review.

On Mon, 2025-03-03 at 17:37 -0800, Mat Martineau wrote:
> On Mon, 3 Mar 2025, Geliang Tang wrote:
> 
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Set msk->bpf_iter_task in bpf_mptcp_sock_from_sock() to allow
> > mptcp_subflow bpt_iter can be used in cgroup/getsockopt,
> > otherwise, the selftest in this set fails.
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> > net/mptcp/bpf.c | 16 ++++++++++++----
> > 1 file changed, 12 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> > index be222fa5f308..aff92f458e7f 100644
> > --- a/net/mptcp/bpf.c
> > +++ b/net/mptcp/bpf.c
> > @@ -197,14 +197,22 @@ static struct bpf_struct_ops
> > bpf_mptcp_sched_ops = {
> > 
> > struct mptcp_sock *bpf_mptcp_sock_from_sock(struct sock *sk)
> > {
> > +	struct mptcp_sock *msk;
> > +
> > 	if (unlikely(!sk || !sk_fullsock(sk)))
> > 		return NULL;
> > 
> > -	if (sk->sk_protocol == IPPROTO_MPTCP)
> > -		return mptcp_sk(sk);
> > +	if (sk->sk_protocol == IPPROTO_MPTCP) {
> > +		msk = mptcp_sk(sk);
> > +		mptcp_set_bpf_iter_task(msk);
> 
> Hi Geliang -
> 
> The important part of the bpf_iter_task approach is to only set the 
> task_struct pointer when the msk lock is already held, and to clear
> it 
> before the msk lock is released. When used this way, the check
> ensures 
> that the iterator code is both *running with the socket locked* and
> *in 
> the same context where the lock is held*.

Got it, thanks for your explanation.

> 
> The code above will set msk->bpf_iter_task even when the lock is not
> held, 
> and then it is never cleared.
> 
> To set/clear as expected for get/setsockopt I think the task pointer
> would 
> have to be set in places where the locks are acquired and released,
> like 
> these:
> 
> https://elixir.bootlin.com/linux/v6.14-rc5/source/kernel/bpf/cgroup.c#L1955
> https://elixir.bootlin.com/linux/v6.14-rc5/source/kernel/bpf/cgroup.c#L1846
> 

The get/setsockopt scenario is a bit complicated. I think we can use
the bpf_iter_task check only for bpf schedulers, keep the
get/setsockopt scenario unchanged, and continue to use the
msk_owned_by_me(msk) check. What do you think?

In addition, I think it's better to add bpf_iter_task to struct
mptcp_sched_data instead in struct mptcp_sock, since it's more related
to mptcp scheduler. For specific usage, please see [1]. What do you
think of this?

Thanks,
-Geliang

[1]
https://patchwork.kernel.org/project/mptcp/cover/cover.1739788598.git.tanggeliang@kylinos.cn/

> 
> - Mat
> 
> > +		return msk;
> > +	}
> > 
> > -	if (sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
> > -		return mptcp_sk(mptcp_subflow_ctx(sk)->conn);
> > +	if (sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk)) {
> > +		msk = mptcp_sk(mptcp_subflow_ctx(sk)->conn);
> > +		mptcp_set_bpf_iter_task(msk);
> > +		return msk;
> > +	}
> > 
> > 	return NULL;
> > }
> > -- 
> > 2.43.0
> > 
> > 
> > 

