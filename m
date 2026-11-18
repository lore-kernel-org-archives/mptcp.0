Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794994365;
	b=dcji4v/nsCcJAcbTqxcGnoMkOxxPSI0MXKPQEA302s3OZjVOZcFsMThdyP28TERxflFi
	 bJAhgIjm9LC+rZGXSJ+v/WbpuTiZuueKk5B5MZQndA30D/zWFayI7ms1+gd7V24i7bGE4
	 6tgBkdidvZ377vR/F73wbuDfAr0YtwV1gsx2CKTsNbNgoHelf9Ac4fuhsjQjGTcRleVal
	 8ig0fSbkOMe5HkHp4kHnK4Nn+DclzE3s+VnX3x6TKB0pNThBAa0jV84X1NHHH1JPzt5J0
	 nAeb7xVj8xLtSzt6+eCAkXT6gVck9ruHEkDcclk8wqwKj2zfnDYPWMnGHipXsgNzW+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994365;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=92Ae2UA/ThkjRIkaOHHIEHGFfNjO6oVcabBPN3MHc+M=;
	b=PUwDpxDAY2pAA4lZL35s1lOVG5SzLw2G2LDkGV65HfP89AUgvXT2tcJAnPWDKId9XVzs
	 3jyDd36iZD5nqDK+zmidO5TcSunD2W+c4IFST9+x0kcn3QcUAipyan7MrmeLUmOw3CEPc
	 t6b/xyTzospwwQGEOSjIK5gezeLlu4QPSpyHIl6yY4it4ipo+9e40P7fJ7exR81BlGU5s
	 nSkEkfP80jGVLnBXkD9CIyWAWTXN5sc1tGzs2Bn6OCWEW8xqAAJq1dY5kDVBV8v1MBHuS
	 FH9SSioZzwrtn9cxaEZh9r+H2ceWuGvSE52jfn7V18jDsi6jlftLJkHj0KqC+NVja+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RcSO/IhF";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36827606A325
	for <mptcp@lists.linux.dev>; Wed, 18 Nov 2026 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RcSO/IhF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960001F000C7;
	Wed, 18 Nov 2026 09:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794994364;
	bh=92Ae2UA/ThkjRIkaOHHIEHGFfNjO6oVcabBPN3MHc+M=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=RcSO/IhFUmNAfxJheNawCPdjiXn9Z33NVqDc10nExplQHGfLnpStqUx7KV5P29lCz
	 ZLwuSRsoQg+OCksfLgi9ov75691LRjwkjJudOo+nP05l8KxnemHEZnq0EPvw26puez
	 ls0DmxU2iyhBB/qfmYOIqkyzcKmfkv9ws3g9JTUTT9nxjQeD49LIYyJwGuh+caQGLo
	 VSvAakJYd3YvjJiUoOWLNghw9TsFVesOwHegWspZk1vH9BZn79PBDNZwhC6ekS70y4
	 5MdPhBUyD12VSbwXIGR3yJPpGEkNWMDANCNj6o5SaVB7YvyzukI6eMCdG9j9Pmj9tm
	 h3O6U7iSUdS9A==
Message-ID: <sashiko-outbox-220577@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v6] mptcp: bpf: fix NULL deref and UAF in
 bpf_mptcp_sock_from_subflow()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kalpan Jani" <kalpan.jani@mpiricsoftware.com>, mptcp@lists.linux.dev
In-Reply-To: <20261118084011.4051683-1-kalpan.jani@mpiricsoftware.com>
References: <20261118084011.4051683-1-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 09:32:44 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] mptcp: NULL deref in mptcp_subflow_process_delegated() after
  ULP release
- [High] mptcp: NULL deref in subflow_data_ready() racing with listener
  close
- [Medium] mptcp: bpf: UAF on subflow ctx due to uncleared icsk_ulp_data
- [Medium] bpf: missing classic RCU protection for
  bpf_skc_to_mptcp_sock() in async cb
--

commit aa822fb1b36957331db4325cd8176b3636136b92
Author: Kalpan Jani <kalpan.jani@mpiricsoftware.com>

mptcp: bpf: fix NULL deref and UAF in bpf_mptcp_sock_from_subflow()

This commit updates bpf_mptcp_sock_from_subflow() and MPTCP subflow
lifecycle paths to use RCU and acquire/release operations on ctx->conn,
enables SOCK_RCU_FREE on all MPTCP parent sockets, and disallows
bpf_skc_to_mptcp_sock() in sleepable tracing programs.

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 29260951aa871..c6032fe843627 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1746,7 +1746,7 @@ tracing_prog_func_proto(enum bpf_func_id func_id, c=
onst struct bpf_prog *prog)
>  	case BPF_FUNC_skc_to_unix_sock:
>  		return &bpf_skc_to_unix_sock_proto;
>  	case BPF_FUNC_skc_to_mptcp_sock:
> -		return &bpf_skc_to_mptcp_sock_proto;
> +		return prog->sleepable ? NULL : &bpf_skc_to_mptcp_sock_proto;
>  	case BPF_FUNC_sk_storage_get:
>  		return &bpf_sk_storage_get_tracing_proto;
>  	case BPF_FUNC_sk_storage_delete:

[Severity: Medium]
Can a non-sleepable BPF program still invoke bpf_skc_to_mptcp_sock()
from a sleepable bpf_wq or bpf_task_work callback without classic RCU
protection?

A non-sleepable tracing or networking program has prog->sleepable =3D=3D fa=
lse,
so both tracing_prog_func_proto() and bpf_sk_base_func_proto() allow
BPF_FUNC_skc_to_mptcp_sock.  When that program registers an async callback
with bpf_wq_set_callback_impl() or bpf_task_work_schedule_resume(), the
callback runs in sleepable context under rcu_read_lock_trace() rather than
classic rcu_read_lock().  Looking up a TCP subflow socket in a sockmap or
sockhash and passing it to bpf_skc_to_mptcp_sock() inside the callback then
executes bpf_mptcp_sock_from_subflow() without holding either the subflow
socket lock or classic RCU, racing with kfree_rcu(ctx, rcu) and parent
socket destruction (and because bpf_skc_to_mptcp_sock_proto does not return
a MEM_RCU pointer, bpf_rcu_read_unlock() would not invalidate the returned
mptcp_sock pointer either).

> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 4cc16cbeb3281..f6d6d31395eae 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -14,8 +14,19 @@
> =20
>  struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
>  {
> -	if (sk && sk_fullsock(sk) && sk_is_tcp(sk) && sk_is_mptcp(sk))
> -		return mptcp_sk(mptcp_subflow_ctx(sk)->conn);
> +	struct mptcp_subflow_context *ctx;
> +	struct sock *conn;
> +
> +	if (sk && sk_fullsock(sk) && sk_is_tcp(sk) && sk_is_mptcp(sk)) {
> +		ctx =3D rcu_dereference_check(inet_csk(sk)->icsk_ulp_data,
> +					    lockdep_sock_is_held(sk));
> +		if (ctx) {
> +			/* Pair with release stores publishing or clearing ctx->conn. */
> +			conn =3D smp_load_acquire(&ctx->conn);
> +			if (conn)
> +				return mptcp_sk(conn);
> +		}
> +	}
> =20
>  	return NULL;
>  }

[Severity: Medium]
Can bpf_mptcp_sock_from_subflow() dereference a freed ctx after its RCU
grace period expires while sk is still alive?

subflow_ulp_fallback() clears icsk_ulp_data and tcp_sk(sk)->is_mptcp, but
the ULP teardown paths in subflow_ulp_release(), __mptcp_close_ssk() (when
icsk_ulp_ops is already NULL), and mptcp_subflow_drop_ctx() (when called
after tcp_cleanup_ulp()) schedule kfree_rcu(ctx, rcu) without clearing
inet_csk(ssk)->icsk_ulp_data or tcp_sk(ssk)->is_mptcp.

CPU0                                  CPU1
__mptcp_close_ssk(sk, ssk, ...)
  __tcp_close(ssk, 0)
    inet_csk_destroy_sock(ssk)
      tcp_cleanup_ulp(ssk)
        subflow_ulp_release(ssk)
          kfree_rcu(ctx, rcu)
  (RCU grace period elapses;
   ctx is freed, while ssk stays
   alive waiting on sk_wmem_alloc
   or refcount)
                                      bpf_mptcp_sock_from_subflow(ssk)
                                        sk_is_mptcp(ssk) =3D=3D true
                                        ctx =3D rcu_dereference_check(
                                                icsk->icsk_ulp_data, ...)
                                        smp_load_acquire(&ctx->conn)
                                          <-- use-after-free

Clearing icsk_ulp_data with rcu_assign_pointer(icsk->icsk_ulp_data, NULL)
before kfree_rcu() in subflow_ulp_release() would prevent readers from
observing a dangling ctx pointer.

[ ... ]

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index f0a6725d2c376..c6dbc49404100 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -782,6 +782,7 @@ static void subflow_ulp_fallback(struct sock *sk,
>  void mptcp_subflow_drop_ctx(struct sock *ssk)
>  {
>  	struct mptcp_subflow_context *ctx =3D mptcp_subflow_ctx(ssk);
> +	struct sock *conn;
> =20
>  	if (!ctx)
>  		return;
> @@ -789,8 +790,12 @@ void mptcp_subflow_drop_ctx(struct sock *ssk)
>  	list_del(&mptcp_subflow_ctx(ssk)->node);
>  	if (inet_csk(ssk)->icsk_ulp_ops) {
>  		subflow_ulp_fallback(ssk, ctx);
> -		if (ctx->conn)
> -			sock_put(ctx->conn);
> +		conn =3D ctx->conn;
> +		if (conn) {
> +			/* Clear the pointer before dropping its reference. */
> +			smp_store_release(&ctx->conn, NULL);
> +			sock_put(conn);
> +		}
>  	}
> =20
>  	kfree_rcu(ctx, rcu);

[Severity: High]
Can clearing ctx->conn in mptcp_subflow_drop_ctx() and
subflow_ulp_release() cause a NULL pointer dereference in
mptcp_subflow_process_delegated()?

When mptcp_subflow_delegate() queues a subflow on the per-CPU
mptcp_delegated_actions list with MPTCP_DELEGATE_SEND or
MPTCP_DELEGATE_SNDBUF set, only mptcp_napi_poll() on that CPU dequeues it.
If the subflow is closed and destroyed before mptcp_napi_poll() runs,
subflow_ulp_release() (or mptcp_subflow_drop_ctx()) clears ctx->conn to
NULL and restores ssk->sk_prot via mptcp_subflow_ops_undo_override(ssk), so
the subsequent release_sock(ssk) calls tcp_release_cb() instead of
tcp_release_cb_override() and leaves the delegated action bits set:

CPU0                                  CPU1
mptcp_subflow_delegate(subflow,
                       MPTCP_DELEGATE_SEND)
  /* queued on CPU0 delegated_head */
                                      __mptcp_close_ssk(sk, ssk, ...)
                                        lock_sock_nested(ssk, ...)
                                        __tcp_close(ssk, 0)
                                          ...
                                            subflow_ulp_release(ssk)
                                              smp_store_release(&ctx->conn,
                                                                NULL)
                                              mptcp_subflow_ops_undo_overri=
de(ssk)
                                        release_sock(ssk)
mptcp_napi_poll()
  mptcp_subflow_process_delegated(ssk, status)
    sk =3D subflow->conn; /* NULL */
    mptcp_data_lock(sk)
      <-- NULL pointer dereference

net/mptcp/protocol.c:mptcp_subflow_process_delegated() {
	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
	struct sock *sk =3D subflow->conn;

	if (status & BIT(MPTCP_DELEGATE_SEND)) {
		mptcp_data_lock(sk);
    ...
}

[ ... ]

> @@ -2040,6 +2050,11 @@ static void subflow_ulp_release(struct sock *ssk)
>  		if (!release && !test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW,
>  						  &mptcp_sk(sk)->flags))
>  			mptcp_schedule_work(sk);
> +
> +		/* hide the parent from lockless readers (e.g. BPF) before
> +		 * dropping the subflow-owned reference
> +		 */
> +		smp_store_release(&ctx->conn, NULL);
>  		sock_put(sk);
>  	}
> =20

[Severity: High]
Does clearing ctx->conn in subflow_ulp_release() also introduce a NULL
pointer dereference in subflow_data_ready() when an incoming handshake
races with closing a listener socket?

During 3WHS completion, tcp_child_process() runs under rcu_read_lock()
without holding the listener socket lock and calls
READ_ONCE(parent->sk_data_ready)(parent), which invokes
subflow_data_ready() on the listener subflow.  Because
subflow_ulp_release() clears ctx->conn without resetting sk_data_ready, a
concurrent listener close can clear subflow->conn while
subflow_data_ready() is running:

CPU0                                  CPU1
tcp_child_process(listener_ssk, ...)
  subflow_data_ready(listener_ssk)
    state =3D 1 << inet_sk_state_load(sk)
                                      __mptcp_close_ssk(sk, listener_ssk, .=
..)
                                        __tcp_close(listener_ssk, 0)
                                          inet_csk_destroy_sock(listener_ss=
k)
                                            tcp_cleanup_ulp(listener_ssk)
                                              subflow_ulp_release(listener_=
ssk)
                                                smp_store_release(&ctx->con=
n,
                                                                  NULL)
    parent =3D subflow->conn; /* NULL */
    msk =3D mptcp_sk(parent);
    ...
    parent->sk_data_ready(parent);
      <-- NULL pointer dereference

net/mptcp/subflow.c:subflow_data_ready() {
	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
	u16 state =3D 1 << inet_sk_state_load(sk);
	struct sock *parent =3D subflow->conn;
	struct mptcp_sock *msk;

	trace_sk_data_ready(sk);

	msk =3D mptcp_sk(parent);
	if (state & TCPF_LISTEN) {
		if (reqsk_queue_empty(&inet_csk(sk)->icsk_accept_queue))
			return;

		parent->sk_data_ready(parent);
		return;
	}
    ...
}

On CONFIG_DEBUG_NET, mptcp_sk(parent) faults immediately on NULL; without
CONFIG_DEBUG_NET, parent->sk_data_ready(parent) dereferences NULL when
state was read before the listener left TCP_LISTEN.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118084011.4051=
683-1-kalpan.jani@mpiricsoftware.com?part=3D1
