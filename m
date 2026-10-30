Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793363113;
	b=Z+oFkdnODUn7okFBvji/gXDGNt3uagfG3HeyhimWL0xqADKoS78F0CzJDaBkDsl0js1C
	 mQ1hACAcs5tI3jzpy77s27evlAIp52DrcFGvvVZQ0C4ZvJ9ilQqwOhB4cUCFyp4zD+cMV
	 vgJdgm3deP8Zndo4WiPkHxhRxKipLArM+wkIFhmH7bBEnQDP7xcqtonLHPmAL1jpJnqk/
	 hvV4fMKCIl0zvrmSkITD0tFIzxAYgO5cs7U6nQMqKmkX8l6rISPPTu51U3udR6S+M12xD
	 UlxoGDVdnwU37FOo67BUqTHAff3RZUjSpbeE5NrX14JsM0mV5xtXBirnrGDRVtUhKyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793363113;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=23LkiJqgraZQ3C0qET4DUDukldHjTQgox9RGCWz5tjE=;
	b=xFE+SVf9AP6Vco9wQDlWp4/YO/ANSIxl83BRi3tiFCp2pLjA+iSviZDWDGBpkd5IDy50
	 P526NXJrgEUlofLdv+AQnVH9cvxR++C21UsSmP1fMfBA+g4B8IjWtHQb5X4Y4PTUp2667
	 f/ejZ4TBaM28UvCsRg2IC4V71gEX88W2VDzi8hUVQF/doB/NxZdNKt5w8URJslYS1M/RL
	 w+sWIfnReNR+JPqOjZkUXCQ2QRTw2YzcWnDAWSVLawjuTCEkq6SlDELlUVyb+uQPSyqxK
	 +9N7kQjulMAe6VoWVlek/eyj60um5w47QaSFbFdJVF1/+s9Vct+1MZpq7GXKRiAVsEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VPs9LOOb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD84F606A330;
	Fri, 30 Oct 2026 12:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VPs9LOOb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A721F0093A;
	Fri, 30 Oct 2026 12:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793363112;
	bh=23LkiJqgraZQ3C0qET4DUDukldHjTQgox9RGCWz5tjE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VPs9LOObafEAkIgfCh0KBUw6CV63pTxlaTrjmreenP3GVHcY8nfbQ0a2EqwgIvx1p
	 vxtcTOTRFlqw0+18PjsGmzRu14e+4nw328HisPAd/kbb3VuS4onhM7YE1wx7Iw0U+P
	 UZHrDv9EkPWFU8VJKpilPsRhGXgjYXb2NJoBqnfrClg0vxAtHNCeeh4RXer7uCHdMF
	 4P4AtHLXXa9v8cCk+S3Y4qHCk6MWbG4XDHUIenPPJ3247kg5sq0lgPbhkJm2UIfbhB
	 NETQrR3avszMOOpVRRBcNVD0uXz0gD6t9tPwGUkXasDFujCNcEeWRA65H/gYB9r4qa
	 Lg91oUJ3GUrMw==
Subject: Re: [PATCH net 2/2] mptcp: release the parent socket reference with
 the subflow context
From: netdev-bot+sashiko@kernel.org
To: zzzccc427@gmail.com
Cc: matttbe@kernel.org, martineau@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, geliang@kernel.org,
 horms@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, jjzuming@gmail.com
Date: Fri, 30 Oct 2026 12:25:11 +0000
Message-ID: <179336311140.3134.6875927878730480019@kernel.org>
In-Reply-To:
 <pm-mptcp-objects-candidate-0010-v3-14c229ea28a7d31f60a0-2@gmail.com>
References:
 <pm-mptcp-objects-candidate-0010-v3-14c229ea28a7d31f60a0-2@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 1 · High: 1 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] The new sock_put(ctx->conn) sits in subflow_ctx_destruct(),
  and a TCP child cloned from a retired MPTCP listener subflow can…
- [High] The fix is incomplete.
- [Medium] The commit message presents the delegated-action use-after-
  free as a live bug that this patch fixes: the second interleaving, the…
- [Low] The comment in subflow_ulp_release()
  (net/mptcp/subflow.c:2115-2118) says the context 'will be freed by…

--

I'm sending this review as a reply to the patch on the list. It has four inline comments:

- **Medium:** the commit message credits this patch with a fix that the previous commit in the series already makes.
- **High:** mptcp_subflow_drop_ctx() still drops the parent reference immediately, so the fix is incomplete.
- **Critical:** a possible double free of the subflow context when a child is cloned from a listener that is being closed.
- **Low:** a stale comment.

mptcp: release the parent socket reference with the subflow context

This commit moves the sock_put() on the MPTCP parent socket from
subflow_ulp_release() into subflow_ctx_destruct(). The parent reference
then lives as long as the subflow socket. The aim is to fix use-after-free
in bpf_skc_to_mptcp_sock() readers and in delegated action processing,
building on the previous commit that keeps a retired context attached
until sk_destruct.

> A delegated action pins the TCP subflow socket, but
> mptcp_subflow_process_delegated() locks and updates ctx->conn. A peer
> reset followed by the application closing the MPTCP socket releases
> the parent before mptcp_napi_poll() takes its data lock:
>
>   Delegation / NAPI                 Peer reset / application close
>   queue SEND or SNDBUF
>     sock_hold(ssk)
>                                     subflow_ulp_release(ssk)
>                                       sock_put(parent)
>                                     mptcp_close(parent)
>                                       last sock_put(parent)
>   mptcp_napi_poll()
>     mptcp_subflow_process_delegated()
>       mptcp_data_lock(parent)

[ ... ]

> Fixes: b19bc2945b40 ("mptcp: implement delegated actions")

[Severity: Medium]
Can this delegated action sequence still happen on the tree this patch
applies to?

The previous commit in the series, "mptcp: keep delegated subflow contexts
alive until socket release", added this guard to mptcp_napi_poll() in
net/mptcp/protocol.c:

	bh_lock_sock_nested(ssk);
	if (unlikely(!READ_ONCE(inet_csk(ssk)->icsk_ulp_ops))) {
		...
		goto unlock;
	}

Before this patch, the parent sock_put() ran in subflow_ulp_release().
That function is called from tcp_cleanup_ulp() right before:

	icsk->icsk_ulp_ops = NULL;

At that point the subflow is owned by the user or bh-locked. So
mptcp_napi_poll() sees one of three states:

- An attached ULP, where ctx->conn still pins the parent.
- An owned socket, where it only clears the scheduled bit.
- NULL ops, where it skips the entry.

Also, tcp_release_cb_override() isn't reached after the ULP release,
because mptcp_subflow_ops_undo_override() restores sk_prot.

If that's right, this patch only fixes the bpf_skc_to_mptcp_sock() case.
For delegated actions it is defence in depth.

Should the second interleaving, the second KASAN report and the
b19bc2945b40 Fixes tag move to the previous commit instead?

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 8dc0677dc5514..ebcface15661a 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c

[ ... ]

> @@ -820,6 +822,8 @@ static void subflow_ctx_destruct(struct sock *ssk)
>
>  	rcu_assign_pointer(inet_csk(ssk)->icsk_ulp_data, NULL);
>  	ctx->tcp_sock_destruct(ssk);
> +	if (ctx->conn)
> +		sock_put(ctx->conn);
>  	kfree_rcu(ctx, rcu);
>  }

[Severity: High]
The commit message says "Every reference on the subflow socket then also
keeps the parent alive". Does that hold for mptcp_subflow_drop_ctx()?
That function still drops the parent reference right away when the ULP
is attached:

net/mptcp/subflow.c:mptcp_subflow_drop_ctx() {
	...
	if (inet_csk(ssk)->icsk_ulp_ops) {
		subflow_ulp_fallback(ssk, ctx);
		if (ctx->conn)
			sock_put(ctx->conn);
	...
}

In that branch the TCP socket stays hashed as plain TCP, so a reference
on it no longer pins the msk. bpf_mptcp_sock_from_subflow() returns
ctx->conn without taking a reference of its own.

One way to reach it is closing a listener that has an unaccepted
connection:

mptcp_check_listen_stop()
  mptcp_subflow_queue_clean()
    __mptcp_unaccepted_force_close(msk)
      mptcp_do_fastclose(msk)        <- only sends RST, child stays in ehash
      __mptcp_destroy_sock(msk)
        mptcp_destroy()              <- sets free_first
          mptcp_destroy_common()
            __mptcp_close_ssk(first) <- in_accept_queue branch
              mptcp_subflow_drop_ctx(first)
                sock_put(msk)
        sock_put(msk)
    mptcp_cancel_work(msk)
    sock_put(msk)                    <- msk freed

Suppose a TC or SK_SKB program on another CPU called bpf_sk_lookup_tcp()
on that 4-tuple, then bpf_skc_to_mptcp_sock(), before the fallback. It
holds only the TCP reference. Wouldn't it then read the freed msk, the
same way as in the first KASAN report?

The dispose_child label in subflow_syn_recv_sock() looks like a second
path. It is reached after:

	ctx->conn = (struct sock *)owner;

and by then tcp_v4_syn_recv_sock() has already hashed the child.

Does this put also need to be deferred, for example past an RCU grace
period, or otherwise tied to the TCP socket's lifetime?

[Severity: Critical]
Can a TCP child cloned from a retired MPTCP listener subflow inherit
subflow_ctx_destruct()? If so, it would run this new sock_put() on the
listener's ctx.

The comment on mptcp_subflow_ctx_release() from the previous commit says
"TCP never clones such a socket". However, tcp_v4_rcv() checks the
listener state without holding the listener lock:

CPU1 (softirq)
tcp_v4_rcv()
  if (unlikely(sk->sk_state != TCP_LISTEN)) { ... }   <- passes
  sock_hold(sk)
  tcp_check_req()
    ->syn_recv_sock()
      inet_csk_clone_lock()
        sk_clone_lock()

CPU2
mptcp_close()
  mptcp_check_listen_stop()
  __mptcp_destroy_sock()
    mptcp_destroy()                  <- free_first = 1
      __mptcp_close_ssk(listener ssk)
        __tcp_close()
          inet_csk_destroy_sock()
            tcp_cleanup_ulp()
              subflow_ulp_release()  <- release == true
                mptcp_subflow_ctx_release()
                  ssk->sk_destruct = subflow_ctx_destruct;
              icsk->icsk_ulp_ops = NULL;

tcp_cleanup_ulp() leaves icsk_ulp_data pointing at the listener's ctx.
Suppose CPU2 gets this far before sk_clone_lock() copies the listener:

- sk_clone_lock() keeps the inherited sk_destruct on success. It only
  clears it on the failure path.
- inet_clone_ulp() returns early because icsk_ulp_ops is NULL.

The child then has sk_destruct == subflow_ctx_destruct, icsk_ulp_data
pointing at the listener's ctx, and is_mptcp set.

inet_csk_reqsk_queue_add() then sees that the listener is no longer
TCP_LISTEN and calls inet_child_forget(). When the child is freed,
subflow_ctx_destruct(child) runs ctx->tcp_sock_destruct, then
sock_put(ctx->conn) on the listener msk, then kfree_rcu(ctx).

Later the listener ssk is destroyed, and subflow_ctx_destruct() runs
again on the same ctx. Wouldn't that call ctx->tcp_sock_destruct through
a pointer read from memory that may already be freed? It would also put
the listener msk a second time and kfree_rcu() the ctx twice.

The destructor inheritance comes from the previous commit in this series.
This patch adds the extra put on the listener msk on top of it.

[ ... ]

> @@ -2120,7 +2124,6 @@ static void subflow_ulp_release(struct sock *ssk)
>  		if (!release && !test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW,
>  						  &mptcp_sk(sk)->flags))
>  			mptcp_schedule_work(sk);
> -		sock_put(sk);
>  	}
>
>  	mptcp_subflow_ops_undo_override(ssk);

[Severity: Low]
This isn't a bug, but the comment a few lines above in
subflow_ulp_release() still says:

	/* if the msk has been orphaned, keep the ctx
	 * alive, will be freed by __mptcp_close_ssk(),
	 * when the subflow is still unaccepted
	 */

After this series, __mptcp_close_ssk() only retires the context through
mptcp_subflow_ctx_release(). The context is freed in subflow_ctx_destruct()
when the subflow socket is destroyed, and with this patch the parent
reference is dropped there too.

Should this comment be updated?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/pm-mptcp-objects-candidate-0010-v3-14c229ea28a7d31f60a0-0%40gmail.com
