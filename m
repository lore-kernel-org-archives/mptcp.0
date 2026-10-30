Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793336080;
	b=fJ0nE/WJXxuyCePoOS6Q0WpgbnbjH8OomDVQVK+2pTGee6M5VGtWzshfYeL9ahSipH31
	 G/T0eZl6TsaZCks71dJunvgt2wJd8MjgYetcMlWvJwAfFI7/hqIHwNlzKhWxx9H1AilNr
	 dRVZ7xO7V8OW4EhWjB2ylE1J1TV91AP0Z1KUhR+2v3WTDVNPhQNkJsPUXjQI4YfXDvmIl
	 BDemtEtmQwKdJg/khWe0isbUK69khcoG5/3ICwDVmu7Zmt8E3NWVjU6dJVjORD8GEzXmF
	 HLZYyyV7SNa7cyWf3z+LgOjhVTg9j1pnLH4t9jlEY9s+C93TPP5fwaQIovjmyBoHItQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793336080;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8G+Wdiu0CNp8zD7jFaY699IlOhNzG7xjGtoNljCfY0I=;
	b=f0Njm/B7stoXiopz0tL+mPc6MitwWUzkqVLby+YELPi5cye70cuWpz+G9gEbwbjvIm34
	 h6N5tv8/FzR2GFC/pEIuiF23WJHJMTbxkI0/T8vo3e6DfSvCsfbJ8PzjFpC0ZaYAUuhjw
	 Ii42z+9DckzlXUOYY4DmH6kUsq4leoLg+39wHoWS8HijVE1/EhtESRS3u4M04OIeMYwfw
	 RsUmU437EjfAQD8vwOq3FjHwEizwU8rmcQXoOK0g9xoFH70g/uBAxjb6GVaXbtpRwxPaE
	 AqV7++mFhOHkFMGoJ26U6K0QoFEisV6vFvFRqP4EjFhQTMDsIpusy4/F8Pv5BXv7dBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c9X3Vi9n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F75D606A31C
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 04:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c9X3Vi9n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039F31F000C1;
	Fri, 30 Oct 2026 04:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793336080;
	bh=8G+Wdiu0CNp8zD7jFaY699IlOhNzG7xjGtoNljCfY0I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c9X3Vi9n1n2Q4cWCVvykB+YfIGgSU9XcIDl4IpZW6s/9UNC7hIFRtVWkWE/W+ZCZf
	 7kTuymc6QcZ+cDdaSkuXa7PpFmjdKXWqRux440t4sjBNuhugO4CgD4mD9nisoaN/UQ
	 5MVi3UX2wM/QhBFBrg7hiIuj3GOsyiCHY7HTr8XlGsFgPAG+cIFStEfiqvfB80GDNG
	 WmWgL9c6JyDmA/9x+uuLjNj9KX61ZDuze2KCG6/qRp0/5H8tVpz2Z4W9dQoPz1wLc7
	 WGggbJ+b2vFG/ICJf2GXaWY8km4pNOgLTMrx4NEfMZoU7VcoMJ+mpgaGTkwykg8hwP
	 sGrmcVmhwPxrA==
Message-ID: <sashiko-outbox-190538@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/2] mptcp: keep delegated subflow contexts alive
 until socket release
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cen Zhang" <zzzccc427@gmail.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <pm-mptcp-objects-candidate-0010-v3-14c229ea28a7d31f60a0-1@gmail.com>
References: <pm-mptcp-objects-candidate-0010-v3-14c229ea28a7d31f60a0-0@gmail.com>
 <pm-mptcp-objects-candidate-0010-v3-14c229ea28a7d31f60a0-1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 04:54:39 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] mptcp: mptcp_subflow_ctx_reset() clears delegated_status while=
 node is queued
- [High] mptcp: subflow context leak when mptcp_subflow_drop_ctx() races wi=
th poll
--

commit 9ef5cf9c57c696888614efd45592ee8ab775f65d
Author: Cen Zhang <zzzccc427@gmail.com>

mptcp: keep delegated subflow contexts alive until socket release

This commit defers freeing retired MPTCP subflow contexts until socket
destruction via a chained sk_destruct callback, or hands live fallback
contexts over to mptcp_napi_poll() via MPTCP_DELEGATE_RETIRED so queued
delegated_node entries are not freed before being dequeued.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 7a22e9388e0e9..01b94a280c810 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -4793,6 +4793,21 @@ static int mptcp_napi_poll(struct napi_struct *nap=
i, int budget)
>  		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> =20
>  		bh_lock_sock_nested(ssk);
> +		if (unlikely(!READ_ONCE(inet_csk(ssk)->icsk_ulp_ops))) {
> +			/* The subflow was retired, by ULP release or by a
> +			 * fallback to plain TCP: nothing is left to process.
> +			 * The ops pointer is cleared with the socket owned or
> +			 * under its bh lock, so a racing read lands in the
> +			 * owned branch below instead.
> +			 * mptcp_subflow_drop_ctx() leaves a still queued
> +			 * context to us: free it now that it is dequeued.
> +			 */
> +			if (xchg(&subflow->delegated_status, 0) &
> +			    BIT(MPTCP_DELEGATE_RETIRED))
> +				kfree_rcu(subflow, rcu);
> +			goto unlock;
> +		}
> +
>  		if (!sock_owned_by_user(ssk)) {
>  			mptcp_subflow_process_delegated(ssk, xchg(&subflow->delegated_status,=
 0));
>  		} else {
> @@ -4804,6 +4819,7 @@ static int mptcp_napi_poll(struct napi_struct *napi=
, int budget)
>  			smp_wmb();
>  			clear_bit(MPTCP_DELEGATE_SCHEDULED, &subflow->delegated_status);
>  		}

[Severity: High]
Does this race with mptcp_subflow_drop_ctx() and leak struct
mptcp_subflow_context when a read of icsk_ulp_ops lands in the owned branch?

When an unaccepted MPTCP socket is force-closed during listener teardown via
mptcp_subflow_queue_clean() -> __mptcp_unaccepted_force_close() ->
__mptcp_destroy_sock() -> mptcp_destroy() -> mptcp_destroy_common() ->
__mptcp_close_ssk(), __mptcp_close_ssk() acquires lock_sock_nested(ssk,
SINGLE_DEPTH_NESTING) and calls mptcp_subflow_drop_ctx(ssk):

net/mptcp/protocol.c:__mptcp_close_ssk() {
	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
	...
	if (msk->in_accept_queue && msk->first =3D=3D ssk &&
	    (sock_flag(sk, SOCK_DEAD) || sock_flag(ssk, SOCK_DEAD))) {
		sock_set_flag(sk, SOCK_DEAD);
		mptcp_set_close_tout(sk, tcp_jiffies32 - (mptcp_close_timeout(sk) + 1));
		mptcp_subflow_drop_ctx(ssk);
		goto out_release;
	}
}

Because lock_sock_nested() only sets ssk->sk_lock.owned =3D 1 and drops the=
 BH
spinlock ssk->sk_lock.slock, mptcp_subflow_drop_ctx() runs without holding
bh_lock_sock(ssk).

If a delegated action was scheduled on ssk, mptcp_napi_poll() on the
scheduling CPU can concurrently dequeue subflow and take
bh_lock_sock_nested(ssk):

CPU0 (mptcp_napi_poll)                  CPU1 (__mptcp_close_ssk)
bh_lock_sock_nested(ssk)
READ_ONCE(inet_csk(ssk)->icsk_ulp_ops)
  (sees non-NULL)
                                        mptcp_subflow_drop_ctx(ssk)
                                          subflow_ulp_fallback(ssk, ctx)
                                            icsk->icsk_ulp_ops =3D NULL
                                            rcu_assign_pointer(icsk_ulp_dat=
a, NULL)
                                          set_mask_bits(&ctx->delegated_sta=
tus, 0,
                                                        BIT(MPTCP_DELEGATE_=
RETIRED))
                                            (sees MPTCP_DELEGATE_SCHEDULED =
set,
                                             skips kfree_rcu)
sock_owned_by_user(ssk) is true
clear_bit(MPTCP_DELEGATE_SCHEDULED,
          &subflow->delegated_status)

In this window, mptcp_subflow_drop_ctx() observes MPTCP_DELEGATE_SCHEDULED
set and expects mptcp_napi_poll() to free ctx, while the owned branch in
mptcp_napi_poll() only clears MPTCP_DELEGATE_SCHEDULED without checking
MPTCP_DELEGATE_RETIRED or calling kfree_rcu(subflow, rcu). Since
subflow_ulp_fallback() already cleared icsk_ulp_data and restored
ssk->sk_prot, neither side frees ctx.

[ ... ]

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 78e886b202585..8dc0677dc5514 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c

[ ... ]

> @@ -826,9 +853,20 @@ void mptcp_subflow_drop_ctx(struct sock *ssk)
>  		subflow_ulp_fallback(ssk, ctx);
>  		if (ctx->conn)
>  			sock_put(ctx->conn);
> -	}
> =20
> -	kfree_rcu(ctx, rcu);
> +		/* The socket lives on as a plain TCP socket: it must keep
> +		 * neither a stale ULP context nor an overridden destructor,
> +		 * so the context can't be retired through sk_destruct here.
> +		 * A delegated action may still be queued for it, though:
> +		 * hand the context over to mptcp_napi_poll() in that case.
> +		 */
> +		if (!(set_mask_bits(&ctx->delegated_status, 0,
> +				    BIT(MPTCP_DELEGATE_RETIRED)) &
> +		      BIT(MPTCP_DELEGATE_SCHEDULED)))
> +			kfree_rcu(ctx, rcu);

[Severity: Critical]
Can mptcp_subflow_ctx_reset() clear MPTCP_DELEGATE_SCHEDULED while
ctx->delegated_node is still queued, causing mptcp_subflow_drop_ctx() and
mptcp_napi_poll() to both free ctx or trigger a use-after-free?

In struct mptcp_subflow_context, delegated_status is inside
struct_group(reset, ...), whereas delegated_node is outside it:

net/mptcp/protocol.h:
struct mptcp_subflow_context {
	struct	list_head node;/* conn_list of subflows */

	struct_group(reset,
	...
	long	delegated_status;
	unsigned long	fail_tout;

	);

	struct	list_head delegated_node;
	...
};

static inline void
mptcp_subflow_ctx_reset(struct mptcp_subflow_context *subflow)
{
	memset(&subflow->reset, 0, sizeof(subflow->reset));
	subflow->request_mptcp =3D 1;
	WRITE_ONCE(subflow->local_id, -1);
}

If an unaccepted passive MPTCP connection's first subflow (msk->in_accept_q=
ueue
set, msk->first =3D=3D ssk, msk->free_first =3D=3D 0) has a delegated actio=
n queued
on mptcp_delegated_actions and transitions to TCP_CLOSE (for example, on an
incoming peer RST via tcp_reset() -> tcp_done_with_error() -> tcp_done())
before accept() or listener shutdown, sock_flag(sk, SOCK_DEAD) and
sock_flag(ssk, SOCK_DEAD) are both false.

When mptcp_worker() runs __mptcp_close_subflow() -> mptcp_close_ssk() ->
__mptcp_close_ssk(), dispose_it (msk->free_first || ssk !=3D msk->first) is
false, so __mptcp_close_ssk() calls __mptcp_subflow_disconnect():

net/mptcp/protocol.c:__mptcp_subflow_disconnect() {
	if (((1 << ssk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)) ||
	    fastclosing) {
		WARN_ON_ONCE(tcp_disconnect(ssk, 0));
		mptcp_subflow_ctx_reset(subflow);
	}
}

mptcp_subflow_ctx_reset(subflow) zeroes subflow->delegated_status (clearing
MPTCP_DELEGATE_SCHEDULED) while subflow->delegated_node remains linked in t=
he
per-CPU mptcp_delegated_actions list.

When the listener is later closed via mptcp_subflow_queue_clean() ->
__mptcp_unaccepted_force_close() -> __mptcp_destroy_sock() ->
mptcp_destroy_common() -> __mptcp_close_ssk(), sock_flag(sk, SOCK_DEAD) is
now set, so __mptcp_close_ssk() calls mptcp_subflow_drop_ctx(ssk). Because
MPTCP_DELEGATE_SCHEDULED was wiped by mptcp_subflow_ctx_reset(),
set_mask_bits() sets MPTCP_DELEGATE_RETIRED and returns 0, causing
mptcp_subflow_drop_ctx() to immediately call kfree_rcu(ctx, rcu) while
ctx->delegated_node is still queued.

When mptcp_napi_poll() later processes the queued entry, it either
dereferences freed memory in mptcp_subflow_delegated_next() after the RCU
grace period or observes MPTCP_DELEGATE_RETIRED set and invokes
kfree_rcu(subflow, rcu) a second time on the same rcu_head.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/pm-mptcp-objects-ca=
ndidate-0010-v3-14c229ea28a7d31f60a0-0@gmail.com?part=3D1
