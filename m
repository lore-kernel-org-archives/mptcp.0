Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD12D56B81
	for <mptcp@lists.linux.dev>; Fri,  7 Mar 2025 03:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741319520; cv=none; b=a1HKZhQj/7NR60Vx7LXTcmNDpRFKqhU5gauRdqdAp5dJFpnx/MZgSWB5DDiZQqq96o8iC7lRxZRCcsPe/I0LB/mTGIOQ/UXnjg30BrfIC/XXVcrbqN711rF/An7h1qvBswlDaaXXTlMnpPqC2P5aUldOJWcwhfB7NrkUrMy0eh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741319520; c=relaxed/simple;
	bh=sanWIQfn/liNuBP+tzdXV7CW5jSf6THXePn2lMlxa70=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CpJUwjth7rC6qzCHWKNtY62Fifmd/9NaGT0/BdzU5EMr5f71ssM3oua0+1YXnv3W0fwytJR0v80WgSpUCA5Aj+dUoSuk7bWmIYESinLHYW8ekU6XIYnBcMlzBHUR7svMaKO2afO/y5zdFJlEGlTKbMMC5AKIkDca0Sdr1lRxXvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geqQeW/0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geqQeW/0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1B5C4CED1;
	Fri,  7 Mar 2025 03:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741319520;
	bh=sanWIQfn/liNuBP+tzdXV7CW5jSf6THXePn2lMlxa70=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=geqQeW/0wZqtJeQrpQjbA50rkTUGL9iH7tOSK8m13yxzRnA5SB1EvboXWezZRGqrx
	 jeDcFlwhhC1/3ATqfvDJbt0vS3Paqyr5C1KQrgyz171qPx7DcXcQ5jXm+46bVD1Zxv
	 YGW/UD2GN3kll+m+daF6EVa6meHDrXvY37+WgGx22FYa0FsFpfVMgaF7PfnszgdsPT
	 i1bpQlz376en1jgmJa+J0DK2IY2bGj7d+Bx6F4R6f7AioT76XBvF23KevUOeafmjl1
	 8M0DuYVPmNFjxzEeH65Vup1cGSscdOZKuyeykxCzeJ8KvfC9lM+3gPDgLN1sb9HzdF
	 bHyLATc+LMm+A==
Message-ID: <8bdc8ae709f4fc5a4571283876fe60241cde0943.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v5 2/5] Squash to "bpf: Extend
 bpf_skc_to_mptcp_sock to MPTCP sock"
From: Geliang Tang <geliang@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Date: Fri, 07 Mar 2025 11:51:55 +0800
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

