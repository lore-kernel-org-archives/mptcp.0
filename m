Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793363111;
	b=HXa88PXwWdzU9ZeSECqnAUqLHsshXFoObWWtkoJ/KN1UVpRVjMG9bzUwI2EcMQsyeyOd
	 o359nWCMrRTMUhnGlCGfe8yFjpWctQTzmRJUY90RqgN867guKtHb2ZfpPIjUKHREngwi8
	 AlWsswQ5a03SGXj6VnhUDrU/exDeaboVjljMkjr9NIOO4hk/MbmFnsecIFzi0Sd5yBCVy
	 uLZ58r0SBdvkRsPFcB8SF5xiRQGnlT3lt2b8W+f5OJ+y4Hl0Ncv4FRDo96CrIRaitfWVA
	 3YUajPJ+5B3+ahwVtVpCmQ3lgoxibJKMjHV9XfYGY9vS4kLOyds/J09zNC/IProlNHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793363111;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=TPv9bcP5dq0AkkJRnrQeDr+wb0YAmy7jX9yKQzeQj2U=;
	b=IuJ90XwbXGWiFMNeKY0q62QuzUiUf4IK5vQjmAZdMZ4xmnuFo+AtTt2EP3TGyjxqchkK
	 2Cy03w38oLaMA3kdB6x2MUefOxviIfrmkccEY9xyNE5iQ8AN6vhi4VqaWD5FSfz3ROp9J
	 7blaQkov+zhSvGnXPZGfsDQjhalO0N9FkU0Nf1yPZXr9WJY7TCyXaQ0SJtkmTEqJGbPhk
	 dJQbVvj4Z5O5P1yAIKwWSck18e2GO6mGaIOYg+8YuTTLWL8mHCiLTvlIR6LP8T2tm1bJZ
	 /Ym2eB0JUlYNx6AoHcY3bUKoCJ5VHOQL36PY14NteO3eKOAwrcaPBd0tfZjoSZevDhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eYtl7gtu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D119606A31A;
	Fri, 30 Oct 2026 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eYtl7gtu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855121F0093A;
	Fri, 30 Oct 2026 12:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793363111;
	bh=TPv9bcP5dq0AkkJRnrQeDr+wb0YAmy7jX9yKQzeQj2U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eYtl7gtu6AjvdpnwjaSSRauy8zecwnXpsRN+JaqAuW6DQrN2m2mDjvVOHWmZGc0bJ
	 +GCoxJ7CsBSFtGaM0SIXzaydU/VKfBr5DgZe+bnzfGufa+/vw/B7/Mjq7akqP7nsM8
	 Em04ZXaSswuL7DBSFq9/5TC+vMDbPJtJ6NHUnmKr9WYy+6j2Jf3hdJb3OCqMklJnxS
	 g5DH2DKROpKY4sc6EN9Iuxyni2H4bFUs2TsmrU+vPr5GAWkwuI4gwLwkqhWAS9chzQ
	 sIuRXjytTw3JYS+hgzFhqWiuNlZB2QIRfZaeX7FC8q5p78F/K9CDoOh3ATDLunXRhF
	 HK9+R61As7NpA==
Subject: Re: [PATCH net 1/2] mptcp: keep delegated subflow contexts alive
 until socket release
From: netdev-bot+sashiko@kernel.org
To: zzzccc427@gmail.com
Cc: matttbe@kernel.org, martineau@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, geliang@kernel.org,
 horms@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, jjzuming@gmail.com
Date: Fri, 30 Oct 2026 12:25:10 +0000
Message-ID: <179336311012.3134.3850773253231389670@kernel.org>
In-Reply-To:
 <pm-mptcp-objects-candidate-0010-v3-14c229ea28a7d31f60a0-1@gmail.com>
References:
 <pm-mptcp-objects-candidate-0010-v3-14c229ea28a7d31f60a0-1@gmail.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 1 · High: 1 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] The patch rests on an invariant that does not hold, and the
  result is a double free / use-after-free of the listener's subflow…
- [High] The fallback retirement handshake in mptcp_subflow_drop_ctx()
  relies on MPTCP_DELEGATE_SCHEDULED to tell whether the ctx is still on…
- [Medium] Memory leak: the RETIRED/SCHEDULED handshake loses the free
  when mptcp_napi_poll() takes its owned branch.
- [Low] Mismatched access annotations on icsk_ulp_ops.
- [Low] Stale comment in subflow_ulp_release() (net/mptcp/subflow.c
  around line 2115-2117).

--

mptcp: keep delegated subflow contexts alive until socket release

This patch moves the free of a retired mptcp_subflow_context into a
chained sk_destruct callback, so a queued delegated action can no longer
unlink freed memory. mptcp_napi_poll() now skips subflows whose ULP ops
were cleared. For the fallback branch of mptcp_subflow_drop_ctx(), a new
MPTCP_DELEGATE_RETIRED bit hands the free over to mptcp_napi_poll() when
an action is still scheduled.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 7a22e9388e0e9..01b94a280c810 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -4793,6 +4793,21 @@ static int mptcp_napi_poll(struct napi_struct *napi, int budget)
>  		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>  
>  		bh_lock_sock_nested(ssk);
> +		if (unlikely(!READ_ONCE(inet_csk(ssk)->icsk_ulp_ops))) {

[Severity: Low]
The comment below says this lockless read races with the store that clears
icsk_ulp_ops. Both writers use plain stores, though:

net/mptcp/subflow.c:subflow_ulp_fallback() {
    ...
	icsk->icsk_ulp_ops = NULL;
    ...
}

net/ipv4/tcp_ulp.c:tcp_cleanup_ulp() {
    ...
	icsk->icsk_ulp_ops = NULL;
    ...
}

The mptcp_subflow_drop_ctx() caller in __mptcp_close_ssk() holds socket
ownership but not slock. That writer really does run concurrently with
this reader.

Should those stores be WRITE_ONCE() to pair with this READ_ONCE()?

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
>  			mptcp_subflow_process_delegated(ssk, xchg(&subflow->delegated_status, 0));
>  		} else {
> @@ -4804,6 +4819,7 @@ static int mptcp_napi_poll(struct napi_struct *napi, int budget)
>  			smp_wmb();
>  			clear_bit(MPTCP_DELEGATE_SCHEDULED, &subflow->delegated_status);

[Severity: Medium]
Can the subflow context leak when this owned branch races with the
fallback branch of mptcp_subflow_drop_ctx()?

mptcp_subflow_drop_ctx() is reached at listener shutdown through
mptcp_subflow_queue_clean()->__mptcp_unaccepted_force_close()->
__mptcp_destroy_sock()->mptcp_destroy_common()->__mptcp_close_ssk(). It
runs with the ssk owned via lock_sock_nested(), but without
sk_lock.slock, so it can run concurrently with this loop:

CPU0 (mptcp_napi_poll)             CPU1 (mptcp_subflow_drop_ctx)
READ_ONCE(icsk_ulp_ops) != NULL
sock_owned_by_user() is true
                                   subflow_ulp_fallback()
                                     icsk->icsk_ulp_ops = NULL;
                                   set_mask_bits(..., RETIRED)
                                     old value has SCHEDULED,
                                     kfree_rcu() is skipped
clear_bit(MPTCP_DELEGATE_SCHEDULED)
  RETIRED is never looked at

After this, neither side frees the ctx. It is also unreachable at that
point: icsk_ulp_data is NULL, the ctx is off conn_list, and sk_destruct
is the original TCP one.

The commit message says "a racing read lands in the owned branch, which
only dequeues the entry" and "exactly one of them frees the context". The
owned branch does not take part in the RETIRED handoff, though.

Would a fetch-style operation in the owned branch close this window?

	if (set_mask_bits(&subflow->delegated_status,
			  BIT(MPTCP_DELEGATE_SCHEDULED), 0) &
	    BIT(MPTCP_DELEGATE_RETIRED))
		kfree_rcu(subflow, rcu);

>  		}
> +unlock:
>  		bh_unlock_sock(ssk);
>  		sock_put(ssk);
>  

[ ... ]

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 78e886b202585..8dc0677dc5514 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -814,6 +814,33 @@ static void subflow_ulp_fallback(struct sock *sk,
>  	mptcp_subflow_ops_undo_override(sk);
>  }
>  
> +static void subflow_ctx_destruct(struct sock *ssk)
> +{
> +	struct mptcp_subflow_context *ctx = mptcp_subflow_ctx(ssk);
> +
> +	rcu_assign_pointer(inet_csk(ssk)->icsk_ulp_data, NULL);
> +	ctx->tcp_sock_destruct(ssk);
> +	kfree_rcu(ctx, rcu);
> +}
> +
> +/* Retire the context of a subflow socket that is being destroyed: a
> + * delegated action, or any other holder of a socket reference, can still
> + * reach the context, so free it together with the socket.
> + *
> + * Only an unhashed, dead socket may be retired this way. TCP never clones
> + * such a socket, so the overridden destructor can't leak into a child.
> + */
> +void mptcp_subflow_ctx_release(struct sock *ssk)
> +{
> +	struct mptcp_subflow_context *ctx = mptcp_subflow_ctx(ssk);
> +
> +	if (WARN_ON_ONCE(ssk->sk_destruct == subflow_ctx_destruct))
> +		return;
> +
> +	ctx->tcp_sock_destruct = ssk->sk_destruct;
> +	ssk->sk_destruct = subflow_ctx_destruct;
> +}

[Severity: Critical]
Does "TCP never clones such a socket" hold for an MPTCP listener subflow?

On listener close, __mptcp_close_ssk() on the listener ssk (disposable=1)
goes through:

__tcp_close()
  inet_csk_destroy_sock()
    tcp_cleanup_ulp()
      subflow_ulp_release()
        mptcp_subflow_ctx_release()

That installs subflow_ctx_destruct on the listener before
tcp_cleanup_ulp() clears icsk_ulp_ops. icsk_ulp_data still points at the
listener ctx at that point.

Meanwhile, tcp_v4_rcv() (and tcp_v6_rcv()) checks the listener state
without holding the listener lock:

net/ipv4/tcp_ipv4.c:tcp_v4_rcv() {
    ...
		if (unlikely(sk->sk_state != TCP_LISTEN)) {
			nsk = reuseport_migrate_sock(sk, req_to_sk(req), skb);
    ...
}

If that check passes, the path continues through tcp_check_req()->
subflow_syn_recv_sock()->tcp_v4_syn_recv_sock()->inet_csk_clone_lock()->
sk_clone()->sock_copy(). sock_copy() copies sk_destruct, icsk_ulp_ops and
icsk_ulp_data into the child. TCP expects children of a closing listener:
inet_csk_reqsk_queue_add() handles them with inet_child_forget().

If the copy happens after tcp_cleanup_ulp(), the child has icsk_ulp_ops
NULL, so inet_clone_ulp() does nothing. It also has icsk_ulp_data equal to
the listener ctx and sk_destruct equal to subflow_ctx_destruct.
mptcp_subflow_drop_ctx(child) in subflow_syn_recv_sock() ends up in the
WARN_ON_ONCE() above and returns without fixing anything.

When the child is freed, subflow_ctx_destruct(child) calls kfree_rcu() on
the listener ctx. Later the listener's own subflow_ctx_destruct() reads
ctx->tcp_sock_destruct from freed memory, calls through it, and frees the
ctx a second time.

The old mptcp_subflow_drop_ctx() already freed the inherited ctx on the
fallback path, so that part partly predates this patch. The inherited
destructor is new, though, and it also turns the non-fallback
inet_child_forget() child path into a double free.

If the copy instead lands between the sk_destruct override and
icsk_ulp_ops = NULL, subflow_ulp_clone() runs for the child. It either
falls back, leaving icsk_ulp_data NULL so subflow_ctx_destruct()
dereferences a NULL ctx, or it allocates a zeroed ctx whose
tcp_sock_destruct is NULL, which subflow_ctx_destruct() then calls.

The parent msk reference may also be dropped together with the ctx, as
in "mptcp: release the parent socket reference with the subflow context".
In that case the child's destructor would also put the listener msk one
extra time.

>  void mptcp_subflow_drop_ctx(struct sock *ssk)
>  {
>  	struct mptcp_subflow_context *ctx = mptcp_subflow_ctx(ssk);
> @@ -826,9 +853,20 @@ void mptcp_subflow_drop_ctx(struct sock *ssk)
>  		subflow_ulp_fallback(ssk, ctx);
>  		if (ctx->conn)
>  			sock_put(ctx->conn);
> -	}
>  
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

[Severity: High]
Can MPTCP_DELEGATE_SCHEDULED be clear here while delegated_node is still
on a per-CPU list?

delegated_status sits inside the reset struct_group and delegated_node
sits outside it. So mptcp_subflow_ctx_reset() clears SCHEDULED without
unlinking the node:

net/mptcp/protocol.h:mptcp_subflow_ctx_reset() {
	memset(&subflow->reset, 0, sizeof(subflow->reset));
    ...
}

One possible sequence:

1. A delegated action (for example MPTCP_DELEGATE_SNDBUF) is queued for
   the first subflow of an unaccepted msk. NAPI on that CPU is delayed,
   which is the same premise as the scenario in the commit message.

2. The peer sends MP_FASTCLOSE. mptcp_worker()->mptcp_check_fastclose()
   moves the ssk to TCP_CLOSE without marking it SOCK_DEAD.

3. __mptcp_close_subflow()->mptcp_close_ssk()->__mptcp_close_ssk() runs.
   Neither socket is SOCK_DEAD and dispose_it is false, so
   __mptcp_subflow_disconnect()->mptcp_subflow_ctx_reset() zeroes
   delegated_status.

4. The listener is closed. mptcp_subflow_queue_clean()->
   __mptcp_unaccepted_force_close()->__mptcp_destroy_sock()->
   mptcp_destroy_common()->__mptcp_close_ssk()->mptcp_subflow_drop_ctx()
   takes this fallback branch. set_mask_bits() returns a value without
   SCHEDULED, so kfree_rcu(ctx) runs while the node is still queued.

5. After the grace period, mptcp_napi_poll()->
   mptcp_subflow_delegated_next() does list_del_init() on freed memory.

Isn't that the same use-after-free this patch is meant to close? It looks
like the handoff needs queue-ownership state that survives a ctx reset.

> +	} else {
> +		mptcp_subflow_ctx_release(ssk);
> +	}
>  }
>  
>  void __mptcp_subflow_fully_established(struct mptcp_sock *msk,
> @@ -2087,7 +2125,7 @@ static void subflow_ulp_release(struct sock *ssk)
>  
>  	mptcp_subflow_ops_undo_override(ssk);
>  	if (release)
> -		kfree_rcu(ctx, rcu);
> +		mptcp_subflow_ctx_release(ssk);
>  }

[Severity: Low]
This isn't a bug, but the comment earlier in subflow_ulp_release() still
says:

		/* if the msk has been orphaned, keep the ctx
		 * alive, will be freed by __mptcp_close_ssk(),
		 * when the subflow is still unaccepted
		 */

After this patch, neither __mptcp_close_ssk() nor the !icsk_ulp_ops
branch of mptcp_subflow_drop_ctx() frees the ctx. Both call
mptcp_subflow_ctx_release(), and the actual free happens later in
subflow_ctx_destruct().

Should this comment be updated along with the one for disposable?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/pm-mptcp-objects-candidate-0010-v3-14c229ea28a7d31f60a0-0%40gmail.com
