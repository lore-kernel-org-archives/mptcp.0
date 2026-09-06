Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D151D6DA9;
	Sun,  6 Sep 2026 13:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788699752; cv=none; b=n0nH2Smlct5H1WBKsQk5Pp0bsR0TXlMJru/EF1uYJctV+X4fkii1zSUYj0S167JM+pyEKsVLGmnJDCz4y3n+AYwd687PC3NXDlz7/3OC8hnqqQrST4eDJYZHNy0HKptdzrteoISTbjB1lnFgnQlwC3RTMjWFB2K2i5lry+59pk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788699752; c=relaxed/simple;
	bh=zoOO8OKB4dVh4SZi7VLGCjrqG4ata6osQZutzsXWb48=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t2wrHAc67dRUWsVbPaDmbI4NoY1Ynnhhk53pUcFrzWwTy9IO3Qk53J0aiwDkTFDfIgHPXL6Ccccrg4YuYzpYGf4tEoz67LpZnRsBfdsNsavOmJVgDRUFxL59AG8ebtZdsk8QXBKiXqvPOdvcM2O3DLdhdY7gC+DKGPsZj3QcZDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVcnkJt9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVcnkJt9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DEC1F00A3A;
	Sun,  6 Sep 2026 13:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788699750;
	bh=/8RDjRtzgEAjSQdtLrJB8iWJaRtrmufA8cglghRfD6A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KVcnkJt95tfOhnOY0RdX8Kjh9FAMY3B94xwCCwiui7UlROOmmHaARL65Hldc6gs1z
	 VNGbDg6B0kQ9/tZQ5milBV8IjFUEaUww9RdV0jgS8OU4V7aUNfQkkuoGEEqCF81rvK
	 Zdu++WtYcAmXVj5/bESwX2H7OdXxZFTaWt67juiYrFiJCq0UebX3+iJ7o0zvdp2FKP
	 dSEqA2LVGDWZjEVY/eg5AzIgnMsjGW8UeVvzAb9Tps/avlH5KV2jomO3esbT81ybR8
	 /oBS0U4CHwPwaD7KjlUkVuImn0cSJJEyz4zYbf4BcOJaBK9+MMT7qoFHsNBGaqMcnN
	 37k4EcPCbh5hg==
Subject: Re: [PATCH net v5 1/2] mptcp: hold MP_JOIN msk ref when cloning reqsk
From: netdev-bot+sashiko@kernel.org
To: weir@nebusec.ai
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, daniel@iogearbox.net, kafai@fb.com,
 kylebot@openai.com, david.lee@trailofbits.com, vega@nebusec.ai,
 caoruide123@gmail.com, sashiko-bot@kernel.org
Date: Sun, 06 Sep 2026 13:02:29 +0000
Message-ID: <178869974902.219967.16423867343464438959@kernel.org>
In-Reply-To: =?utf-8?q?=3C12d0c7f938729d16fcdd5b46a6a0e912fb1cd2f8=2E1788202?=
 =?utf-8?q?924=2Egit=2Ecaoruide123=40gmail=2Ecom=3E?=
References: =?utf-8?q?=3C12d0c7f938729d16fcdd5b46a6a0e912fb1cd2f8=2E17882029?=
 =?utf-8?q?24=2Egit=2Ecaoruide123=40gmail=2Ecom=3E?=
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 2 (1)

- [Low] mptcp_subflow_reqsk_clone() (net/mptcp/subflow.c:50-79) performs
  a lockless dereference of a possibly recycled SLAB_TYPESAFE_BY_RCU…
- [Low] mptcp_subflow_reqsk_clone() (net/mptcp/subflow.c:66-76) uses the
  fully relaxed refcount_inc_not_zero() to take a reference on an object…

Pre-existing issues:
- [Low] Incomplete clone fixup for MP_CAPABLE token ownership:
  inet_reqsk_clone() byte-copies the whole mptcp_subflow_request_sock…

--

mptcp: hold MP_JOIN msk ref when cloning reqsk

TCP request migration byte-copies subflow_req->msk into the cloned request
without taking a reference, so both requests can drop the same msk
reference.  This adds mptcp_subflow_reqsk_clone(), called from
inet_reqsk_clone(), which conditionally acquires a reference for the clone
and re-validates the pointer, and marks the ownership-transfer store in
subflow_syn_recv_sock() with WRITE_ONCE().

Closes: https://lore.kernel.org/all/20260804095051.715355-1-david.lee@trailofbits.com/

> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 485d55b66ea67..8e063454fcf6e 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -219,6 +219,8 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
>  struct request_sock *mptcp_subflow_reqsk_alloc(const struct request_sock_ops *ops,
>  					       struct sock *sk_listener,
>  					       bool attach_listener);
> +void mptcp_subflow_reqsk_clone(struct request_sock *req,
> +			       struct request_sock *new_req);

[Severity: Low]
Would it be worth documenting the calling-context requirement here?

The safety of mptcp_subflow_reqsk_clone() depends on the caller being in an
RCU read-side critical section, because the msk it dereferences comes from a
SLAB_TYPESAFE_BY_RCU cache.  That requirement is only stated in a comment
inside net/mptcp/subflow.c; the prototype and the !CONFIG_MPTCP stub in
include/net/mptcp.h say nothing about it, and there is no
RCU_LOCKDEP_WARN() or lockdep_assert_in_softirq() in the helper itself.

All three inet_reqsk_clone() call sites satisfy it only implicitly:
reqsk_timer_handler() runs in the rsk_timer softirq,
inet_csk_complete_hashdance() runs in NET_RX softirq, and
inet_csk_listen_stop() is inside local_bh_disable().  In the last case the
explicit rcu_read_lock() is taken only after inet_reqsk_clone() returns:

	nreq = inet_reqsk_clone(req, nsk);
	if (nreq) {
		refcount_set(&nreq->rsk_refcnt, 1);

		rcu_read_lock();

which reads as though the clone needs no RCU protection at all.  A comment
on the prototype plus a lockdep assertion in the helper would keep this from
silently breaking if a future caller runs in process context.

[ ... ]

> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index 6257459bcee24..896f472dcba29 100644
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

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index af81ad5e699d1..f13011f591b78 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -47,6 +47,37 @@ static void subflow_req_destructor(struct request_sock *req)
>  	mptcp_token_destroy_request(req);
>  }
>  
> +void mptcp_subflow_reqsk_clone(struct request_sock *req,
> +			       struct request_sock *new_req)
> +{
> +	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
> +	struct mptcp_subflow_request_sock *new_subflow_req;
> +	struct mptcp_sock *msk;
> +
> +	new_subflow_req = mptcp_subflow_rsk(new_req);
> +
> +	/* A non-NULL ->msk means the request owns one reference.  The clone
> +	 * copied only the pointer, while the original request can concurrently
> +	 * transfer its reference to the child.  Acquire a reference for the
> +	 * clone, then verify that the original request still owns the same msk.
> +	 * MPTCP sockets use SLAB_TYPESAFE_BY_RCU and all clone callers run in
> +	 * an RCU read-side critical section, keeping the memory stable here.
> +	 */
> +	msk = READ_ONCE(subflow_req->msk);
> +	if (msk) {
> +		struct sock *msk_sk = (struct sock *)msk;
> +
> +		if (!refcount_inc_not_zero(&msk_sk->sk_refcnt)) {
> +			msk = NULL;
> +		} else if (READ_ONCE(subflow_req->msk) != msk) {
> +			sock_put(msk_sk);
> +			msk = NULL;
> +		}
> +	}

[Severity: Low]
Should this use refcount_inc_not_zero_acquire() instead?

The increment here is followed by a validation load that re-reads
subflow_req->msk and compares addresses.  include/linux/refcount.h describes
refcount_inc_not_zero_acquire() for exactly that pattern:

 * This function should be used when memory occupied by the object might be
 * reused to store another object -- consider SLAB_TYPESAFE_BY_RCU.

refcount_inc_not_zero() provides no memory ordering and only orders future
stores through the control dependency, so the second READ_ONCE() is not
ordered after the refcount RMW.  Can the second read then observe the stale
non-NULL pointer while the increment landed on a freshly reused mptcp_sock
at the same address, letting the address comparison pass?

If so, the clone would own a reference to an unrelated live msk, and the
third ACK would compute the HMAC against the wrong keys in
subflow_hmac_valid(), rejecting the join with
SUBFLOW_REQ_INC_STATS(MPTCP_MIB_JOINACKMAC).

This needs load-load reordering on a weakly ordered architecture plus
immediate slab reuse, so no concrete failing execution is demonstrated here,
and the relaxed idiom is what the rest of net/ currently uses (for example
__inet_lookup_established() and mptcp_token_get_sock()).  An explicit
smp_rmb() before the recheck would also cover it.

> +
> +	new_subflow_req->msk = msk;
> +}

[Severity: Low]
This isn't a bug introduced by this patch, but with only this patch applied
the clone fixup is incomplete for MP_CAPABLE token state.

inet_reqsk_clone() copies req->rsk_ops->obj_size bytes, so the whole
mptcp_subflow_request_sock is duplicated including ->token and the hashed
->token_node, and reqsk_migrate_reset() clears only saved_syn and the ireq
option pointers.  This helper repairs ->msk only.

After a successful migration the original request is freed and unlinks the
shared token:

net/mptcp/token.c:mptcp_token_destroy_request() {
	...
	pos = __token_lookup_req(bucket, subflow_req->token);
	if (!WARN_ON_ONCE(pos != subflow_req)) {
		hlist_nulls_del_init_rcu(&pos->token_node);
		bucket->chain_len--;
	}
	...
}

The surviving clone is then left with a token_node that looks hashed but is
no longer reachable, and mptcp_token_accept() trips its
WARN_ON_ONCE(pos != req) while bucket->chain_len accounting drifts.

The follow-up patch in this series, "mptcp: fix MP_CAPABLE token migration
when cloning reqsk", adds mptcp_token_move_request() and calls it from here,
and converts mptcp_token_accept()/mptcp_token_destroy_request() to
lock-rechecked, non-warning variants, so this is only a property of the
intermediate state.  Given both patches carry the same Fixes tag and are
tagged for stable, is it worth noting in the changelog that applying 1/2
alone leaves that reachable WARN_ON_ONCE in place?

[ ... ]

> @@ -923,7 +954,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
>  			}
>  
>  			/* move the msk reference ownership to the subflow */
> -			subflow_req->msk = NULL;
> +			WRITE_ONCE(subflow_req->msk, NULL);
>  			ctx->conn = (struct sock *)owner;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1788202924.git.caoruide123%40gmail.com
