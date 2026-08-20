Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E973425892;
	Thu, 20 Aug 2026 11:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224694; cv=none; b=FaV9x2PP+OnbWccqGh/8IW3X3CU0WbHlnIK3g9KFEor3KtofkXNG4pw6Cv+3qPXDhzMsjY4uyNxKKiDx3O51cojadFwHB6z1hcSJAODNSaYpXcsw4TUlXE2Nvo7WG25dK404jdbUWxz6VTDhjoGOi2DlEAB1RJeUPrDnJisRDAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224694; c=relaxed/simple;
	bh=sLTaeZfP0SG2jq+VzwAPPjwq/xPY7NET5HHO3jIHyZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYVuDW3bwe7C/BgYak4IsTPxN0WM1+G75jVcOFeKp8TCJ0r/WHbXHfS1lDTNxbH2uctu6pHWMKdKpqzbvfTZjSH3QCpXoAvyYiDrYeXJd295JG8ExjRHfraDerMUaPpugYGYnmWSIEYnrdrXJZTXnd36iMM8aBQW6mQ20aZnug4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMGQLara; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMGQLara"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723001F00A3A;
	Thu, 20 Aug 2026 11:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787224690;
	bh=bCrsoBXRJVNNKyFZtLbvL/RvGlM5V+pKLgvQiK3QdJ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WMGQLaraXwhvQ6ctmEWK4O6l2q7qX+JWZDFGCUZdSwjzm46WHuRlDdoh9mj6LAELI
	 iDBi2E9kHBCCQRNtZAOVELk4i1dockWYMTvndCDuZ2Frz97FtnXEmvoNFEaaeSnAIF
	 tZSROEAmyTRyPzw45WMbYoWQDPl8GQ6v/oGb3pq8YrVagDIhpzFOlvCcg815YqcJBd
	 2d9ttK5bPcw8hlIqpLU2k5d8cH3Myda6rQLn8TstKzquz1rATMGd+0pun4rCSzhZKT
	 zYayIVZqqRrr0s8NyA/TzUkhdPCG4rjGA6XToXFiEhd06CM5S2J0jBhcnm5Sfwl4CH
	 42EqEd+DTDoZA==
Message-ID: <21819722-39c1-4a69-abc7-98ec0f06fafd@kernel.org>
Date: Thu, 20 Aug 2026 13:18:07 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v4 1/2] mptcp: hold MP_JOIN msk ref when cloning reqsk
Content-Language: fr
To: Wei Ren <weir@nebusec.ai>, sashiko-reviews@lists.linux.dev
Cc: mptcp@lists.linux.dev, netdev@vger.kernel.org
References: <cover.1786497414.git.yuantan098@gmail.com>
 <e3aeafa4dc2afb7ea36143eae163635eee23395c.1786497414.git.yuantan098@gmail.com>
 <20260813065630.908AC1F000E9@smtp.kernel.org>
 <CADfOeh6F-PngQB-F4dYds2CpqBCTfJHpBYLD+0ZhcWNiBtPOeA@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CADfOeh6F-PngQB-F4dYds2CpqBCTfJHpBYLD+0ZhcWNiBtPOeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ruide,

(+cc netdev ML)

Thank you for having replied to Sashiko's review.

On 20/08/2026 12:58, Wei Ren wrote:
> On Thu, Aug 13, 2026 at 06:56:30AM +0000, sashiko-bot@kernel.org wrote:
>> This is a pre-existing issue, but does this clone helper also need to
>> handle the migration of token_node for MP_CAPABLE requests?
> 
> That is what patch 2/2 of this series does:
Indeed, Sashiko Gemini didn't look at the next patch. Maybe adding a
note in the commit message to say that a similar issue is visible with
MP_CAPABLE and addressed in the next patch? Still, that doesn't feel
natural to add that...

Do you mind also looking at Clashiko's review, please? The suggestion of
replacing sock_hold() by refcount_inc_not_zero() might be valid (to be
double checked):

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1786497414.git.yuantan098%40gmail.com

------------------------------ 8< ---------------------------------
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index 6257459bcee2..896f472dcba2 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c

[ ... ]

> @@ -961,6 +962,9 @@ static struct request_sock *inet_reqsk_clone(struct request_sock *req,
>  		rcu_assign_pointer(tcp_sk(nreq->sk)->fastopen_rsk, nreq);
>  	}
>  
> +	if (rsk_is_mptcp(req))
> +		mptcp_subflow_reqsk_clone(req, nreq);
> +
>  	return nreq;
>  }
>  
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index e1f20ff8fdb4..8f8e1229766d 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -47,6 +47,17 @@ static void subflow_req_destructor(struct request_sock *req)
>  	mptcp_token_destroy_request(req);
>  }
>  
> +void mptcp_subflow_reqsk_clone(struct request_sock *req,
> +			       struct request_sock *new_req)
> +{
> +	struct mptcp_subflow_request_sock *subflow_req;
> +
> +	subflow_req = mptcp_subflow_rsk(new_req);
> +
> +	if (subflow_req->msk)
> +		sock_hold((struct sock *)subflow_req->msk);
> +}

Discovered by: gpt-5-6-sol, opus-5 · Missed by: opus-4-7, sashiko-gemini

Can the sock_hold() here run on an msk whose last reference has already
been dropped?

The pointer being held was snapshotted by the plain (unsafe_)memcpy() in
inet_reqsk_clone(), and the cloning CPU owns no reference to that msk at
this point.  The clone happens optimistically in reqsk_timer_handler()
before any ownership arbitration:

net/ipv4/inet_connection_sock.c:reqsk_timer_handler() {
	...
	nreq = inet_reqsk_clone(req, nsk);
	if (!nreq)
		goto drop;
	...
	/* Even if we can clone the req, we may need not retransmit any more
	 * SYN+ACKs (nreq->num_timeout > max_syn_ack_retries, etc), or another
	 * CPU may win the "own_req" race so that inet_ehash_insert() fails.
	 */
}

So the third-ACK path can be running on the same request concurrently.
There, the request's msk reference is handed to the child and can then be
released synchronously:

net/mptcp/subflow.c:subflow_syn_recv_sock() {
	...
		/* move the msk reference ownership to the subflow */
		subflow_req->msk = NULL;
		ctx->conn = (struct sock *)owner;

		if (subflow_use_different_sport(owner, sk)) {
			...
			if (!mptcp_pm_announced_has_ssk(owner, sk)) {
				...
				goto dispose_child;
			}
		}

		if (!mptcp_finish_join(child)) {
			...
			goto dispose_child;
		}
}

and dispose_child reaches mptcp_subflow_drop_ctx():

	if (ctx->conn)
		sock_put(ctx->conn);

If that put (or a later teardown of the joined subflow) is the last
reference, for example because userspace closed the MPTCP connection
concurrently, then the refcount_inc() in sock_hold() lands on freed memory
and on a zero refcount, which is the refcount_warn_saturate() "addition on
0; use-after-free" case.

The window between the memcpy() snapshot and this sock_hold() is not
bounded either: in the TFO branch of inet_reqsk_clone() it even contains
spin_lock_bh(&fastopenq->lock).

Would refcount_inc_not_zero() be more appropriate here, with
new_req->msk cleared when it fails so subflow_req_destructor() does not put
a reference that was never taken?  Alternatively, could the hold be taken
under the same exclusion that performs the ownership transfer in
subflow_syn_recv_sock()?

Also, the helper takes req but never uses it, so the original request is
not re-validated at all.  Is the req argument intended to be used?


Discovered by: opus-5 · Missed by: opus-4-7, gpt-5-6-sol, sashiko-gemini · Confirmed by: gpt-5-6-sol

This is a pre-existing issue and is not introduced by this patch, but as
long as this hook is the designated fixup point for cloned subflow
requests: inet_reqsk_clone() also byte-copies subflow_req->token_node, the
hlist_nulls node that mptcp_token_new_request() linked into the MPTCP token
bucket for MP_CAPABLE requests, and this version of the helper repairs only
->msk.

The generic detach helper does not cover it either:

net/ipv4/inet_connection_sock.c:reqsk_migrate_reset() {
	req->saved_syn = NULL;
	...
}

With only this patch applied, the clone's token_node looks hashed while it
is not reachable from the bucket chain, so after a successful migration the
surviving clone trips the pedantic check in mptcp_token_accept():

net/mptcp/token.c:mptcp_token_accept() {
	...
	/* pedantic lookup check for the moved token */
	pos = __token_lookup_req(bucket, req->token);
	if (!WARN_ON_ONCE(pos != req))
		hlist_nulls_del_init_rcu(&req->token_node);
}

and the token ends up no longer reserved.

This is resolved later in the same series: the following patch, "mptcp: fix
MP_CAPABLE token migration when cloning reqsk", adds
mptcp_token_move_request() and calls it from mptcp_subflow_reqsk_clone(),
so the state does not exist at the end of the series.  Would it be worth
noting the ordering dependency between the two patches in the changelog,
given the Cc: stable tag on this one?
------------------------------ 8< ------------------------------

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

