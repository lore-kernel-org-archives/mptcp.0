Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795127215;
	b=KwJ9GxRME3/99tn3fcd7vRvEd3mZve1t71q79fmZL/+RmcSf0ke3qwOm4t57ZceMYWoV
	 EIum39WuWBQRlbFxEnnrRrwUr1ebAmwco/7hRDArG7MGXsg9JL3HoqhLzDKcyrMoqOsrt
	 wcAnQhq2tFweiZH9sAig8L2os0trOm1g+KHsiAeJr1Gs3ffqLGmrW5cPzmAVfVf+uYRzD
	 zIEiY43w699Owg6W09bI2VQJUKBWetHleA8PwtzS005xXlKl1gIjGUq/LJ3Cp+1LynVMI
	 OhGstnBOffIgeuCWdfJAK7X4oiWJ4kp8EqFMGzmZ9Mi8OK/JiYB+Ip+S2+XnS+Y1W5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795127215;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=eClFw6gYg0+TOGrbT4W4pgcDqpsVcnUJXQzjuUFIQD4=;
	b=IgG0b99NeDkoChth4uZ5SC4ADvxNXlSvxCJAljjQpOpjumFyN3zoU7GW+wm0eHvJSmGb
	 mnU/O51R3je/O2ddFRcL6Vm3UOvqmKN+fIEuxj0c/cluRamUmqntejSrOly+kuvVJ/IpP
	 RU246YfC1wXFJVDFG1E/4QJiSbnBPfKGbK4ST5H7A7GG4yqbE+DnOEvWlUUTbFdx5UOfB
	 3qYUG9bwvrNlKfTJEouf0FpnDcT5pl014NN0kXyPv00ymXI6CPeairgS+oq764xuFx/1B
	 Snum8CM0GHPSpkedy69cbBe5kiR5w1F3D2nTaKHNcNnA3jo7a1lQl1Sn2G2c3/9ikNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a7PR5moY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63F1606A325
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 22:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a7PR5moY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D8A1F000C6;
	Thu, 19 Nov 2026 22:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795127215;
	bh=eClFw6gYg0+TOGrbT4W4pgcDqpsVcnUJXQzjuUFIQD4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=a7PR5moYqDg+OcTqrUywOA5FFW1VXjSB3/WRcNr4t+PuibGFblqfHScRN973I5sUP
	 +mtiNj6N9tNWj5Q4M+NpYnFW7KB93T8EMdYYlktDfQczwNTuA8BeLmAwJwoz4Xk1Ls
	 fwZR6zgv4iu1Qqb1VVkLkZ8vcbiuhfihMaQSUvV5KNrbKG0FJ+B/up1uuS4xo5ZgrA
	 TeuyLkERVlAFxkwmCom4SJUipXUiX3xy/4cO03k4N6k89AarVukuwfeTh+Wg2t9fW2
	 YQe49spFlkjNjgCsFyFiFcztebvpMvRSNEcKde7GvKp3frYCcJy95SifdaZO2MvkuF
	 Fhjzu44eS48zw==
Subject: Re: [PATCH mptcp-next v6] mptcp: bpf: fix NULL deref and UAF in
 bpf_mptcp_sock_from_subflow()
From: netdev-bot+sashiko@kernel.org
To: kalpan.jani@mpiricsoftware.com
Cc: mptcp@lists.linux.dev, shardul.b@mpiricsoftware.com, janak@mpiric.us,
 kalpanjani009@gmail.com, kuba@kernel.org
Date: Thu, 19 Nov 2026 22:26:54 +0000
Message-ID: <179512721473.3133.14387325104477927814@kernel.org>
In-Reply-To: <20261118084011.4051683-1-kalpan.jani@mpiricsoftware.com>
References: <20261118084011.4051683-1-kalpan.jani@mpiricsoftware.com>
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

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 1 · High: 1 · Medium: 3 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] subflow_ulp_release() (net/mptcp/subflow.c:2057) now does
  smp_store_release(&ctx->conn, NULL).
- [High] The patch protects only ctx->conn.
- [Medium] bpf_mptcp_sock_from_subflow() still treats a plain load of
  tcp_sk(sk)->is_mptcp (sk_is_mptcp()) as proof that icsk_ulp_data holds…
- [Medium] The commit message says bpf_skc_to_mptcp_sock() is rejected
  only for "sleepable tracing programs".
- [Medium] bpf: missing classic RCU protection for
  bpf_skc_to_mptcp_sock() in async cb
- [Low] The comment in mptcp_subflow_ctx() (net/mptcp/protocol.h) still
  says "Use RCU on icsk_ulp_data only for sock diag code".
- [Low] __mptcp_init_sock() now sets SOCK_RCU_FREE on every msk.

--

mptcp: bpf: fix NULL deref and UAF in bpf_mptcp_sock_from_subflow()

This patch makes bpf_mptcp_sock_from_subflow() handle a NULL or stale
subflow context and parent socket. It loads icsk_ulp_data with
rcu_dereference_check() and ctx->conn with smp_load_acquire(), and it
publishes and clears ctx->conn with release stores. It also sets
SOCK_RCU_FREE on every msk in __mptcp_init_sock() and hides
bpf_skc_to_mptcp_sock() from sleepable programs in
tracing_prog_func_proto().

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/622

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 29260951aa871..c6032fe843627 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1746,7 +1746,7 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  	case BPF_FUNC_skc_to_unix_sock:
>  		return &bpf_skc_to_unix_sock_proto;
>  	case BPF_FUNC_skc_to_mptcp_sock:
> -		return &bpf_skc_to_mptcp_sock_proto;
> +		return prog->sleepable ? NULL : &bpf_skc_to_mptcp_sock_proto;

[Severity: Medium]
Does the prog->sleepable test cover every sleepable context that can
reach this helper?

A program that is not sleepable can still run code in a sleepable
context through an async callback. bpf_wq_set_callback_impl() and the
bpf_task_work_schedule_*() kfuncs register a callback that the
verifier checks with in_sleepable set (see is_async_cb_sleepable() and
push_async_cb()). At runtime, bpf_wq_work() runs that callback from a
workqueue under rcu_read_lock_trace() only. No classic rcu_read_lock()
is held.

prog->sleepable is still false inside the callback. Both
tracing_prog_func_proto() and bpf_sk_base_func_proto() therefore still
hand out bpf_skc_to_mptcp_sock_proto to it.

Such a callback can get a subflow from a sockmap or sockhash with
bpf_map_lookup_elem() and pass it to bpf_skc_to_mptcp_sock(). The
lookup holds a reference on the subflow socket, but not on its ctx or
its parent msk.

bpf_mptcp_sock_from_subflow() would then run rcu_dereference_check()
on icsk_ulp_data with neither the socket lock nor classic RCU held.
That should give a lockdep splat. Worse, it races with
kfree_rcu(ctx, rcu) and with the SOCK_RCU_FREE free of the msk. That
is the same window the new sleepable check is meant to close.

There is a second gap even when the callback wraps the call in
bpf_rcu_read_lock(). bpf_skc_to_mptcp_sock_proto returns
RET_PTR_TO_BTF_ID_OR_NULL without MEM_RCU. bpf_rcu_read_unlock()
therefore does not invalidate the returned mptcp_sock pointer, and the
callback can keep using the parent after the RCU section ends. The
same applies to sleepable programs in other types that use
bpf_rcu_read_lock().

Would it be better to enforce this in the verifier instead of
filtering on prog->sleepable in tracing_prog_func_proto()? For
example, require in_rcu_cs() for BPF_FUNC_skc_to_mptcp_sock and tag
the return type as MEM_RCU. That would also cover the non-tracing
program types that reach this helper through bpf_sk_base_func_proto().

[Severity: Medium]
The commit message says the helper is rejected for "sleepable tracing
programs". However, tracing_prog_func_proto() is also the default fallback
for other program types:

kernel/bpf/bpf_lsm.c:bpf_lsm_func_proto() {
    ...
	default:
		return tracing_prog_func_proto(func_id, prog);
}

kernel/bpf/syscall.c:syscall_prog_func_proto() {
    ...
	default:
		return tracing_prog_func_proto(func_id, prog);
}

With this change, will sleepable BPF_PROG_TYPE_LSM and
BPF_PROG_TYPE_SYSCALL programs fail to load with an unknown helper error if
they call bpf_skc_to_mptcp_sock()? The same question applies to sleepable
iterators and sleepable fentry/fexit programs.

The Fixes: tag means this will go to stable. Could the commit message also
describe the change for LSM and SYSCALL programs?

> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 4cc16cbeb3281..f6d6d31395eae 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -14,8 +14,19 @@
>  
>  struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
>  {
> -	if (sk && sk_fullsock(sk) && sk_is_tcp(sk) && sk_is_mptcp(sk))
> -		return mptcp_sk(mptcp_subflow_ctx(sk)->conn);
> +	struct mptcp_subflow_context *ctx;
> +	struct sock *conn;
> +
> +	if (sk && sk_fullsock(sk) && sk_is_tcp(sk) && sk_is_mptcp(sk)) {
> +		ctx = rcu_dereference_check(inet_csk(sk)->icsk_ulp_data,
> +					    lockdep_sock_is_held(sk));

[Severity: Medium]
Is the fallback window fully closed here? sk_is_mptcp() is a plain load of
tcp_sk(sk)->is_mptcp. Nothing orders that load against the later load of
icsk_ulp_data, and nothing checks that the ULP data belongs to MPTCP.

subflow_ulp_fallback() does:

	icsk->icsk_ulp_ops = NULL;
	rcu_assign_pointer(icsk->icsk_ulp_data, NULL);
	tcp_sk(sk)->is_mptcp = 0;

After that, a passive fallback child can be accept()ed and given
setsockopt(TCP_ULP, "tls"), which puts a tls_context into icsk_ulp_data.

Consider a lockless reader on another CPU, such as a TC program that got
the child from bpf_sk_lookup_tcp(). Suppose it sees is_mptcp == 1 and is
then delayed, for example by a preemptible softirq on PREEMPT_RT or vCPU
steal. Could it then load the tls_context and return the value at the
offset of conn as a struct mptcp_sock?

Would checking icsk_ulp_ops == &subflow_ulp_ops with suitable ordering, or
re-checking is_mptcp after loading ctx, close this window?

> +		if (ctx) {
> +			/* Pair with release stores publishing or clearing ctx->conn. */
> +			conn = smp_load_acquire(&ctx->conn);
> +			if (conn)
> +				return mptcp_sk(conn);

[Severity: High]
Can this still read a freed mptcp_subflow_context?

The ctx itself is freed with kfree_rcu(ctx, rcu) on paths that never clear
inet_csk(ssk)->icsk_ulp_data or tcp_sk(ssk)->is_mptcp:

  subflow_ulp_release(), when release is true
  __mptcp_close_ssk(), in the !icsk_ulp_ops branch
  mptcp_subflow_drop_ctx(), when icsk_ulp_ops is already NULL so
  subflow_ulp_fallback() is skipped

tcp_cleanup_ulp() only resets icsk_ulp_ops after ->release(). Only
subflow_ulp_fallback() unpublishes icsk_ulp_data. For comparison, TLS does
rcu_assign_pointer(icsk->icsk_ulp_data, NULL) first.

A destroyed ssk can outlive the grace period. For example, sk_free()
defers __sk_free() while sk_wmem_alloc is non-zero, which happens when skb
clones wait in a neighbour arp_queue or an NFQUEUE.

Suppose a TC egress program calls bpf_skc_to_mptcp_sock(skb->sk) on such
an skb. It would still pass sk_fullsock() (TCP_CLOSE), sk_is_tcp() and
sk_is_mptcp().

rcu_dereference_check() would then return the dangling icsk_ulp_data,
because RCU only covers readers that existed when kfree_rcu() was queued.
smp_load_acquire(&ctx->conn) would read freed or reused slab memory.

That value goes back to the program as a struct mptcp_sock PTR_TO_BTF_ID.
The program can pass it to helpers such as bpf_sk_storage_get().

The commit message lists the teardown window as fixed. Does icsk_ulp_data
(or is_mptcp) need to be cleared before every kfree_rcu(ctx)? Or should
the helper check icsk_ulp_ops instead?

[Severity: Low]
This isn't a bug, but mptcp_subflow_ctx() in net/mptcp/protocol.h still
says:

	/* Use RCU on icsk_ulp_data only for sock diag code */

Should that comment be updated, now that bpf_mptcp_sock_from_subflow() is
also an RCU reader of icsk_ulp_data?

[ ... ]

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index e89a69ab927c9..cc9603353b79e 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3207,6 +3207,11 @@ static void __mptcp_init_sock(struct sock *sk)
>  	mptcp_pm_data_init(msk);
>  	spin_lock_init(&msk->fallback_lock);
>  
> +	/* the returned parent msk may be handed to lockless readers
> +	 * (bpf_skc_to_mptcp_sock()); free it after an RCU grace period
> +	 */
> +	sock_set_flag(sk, SOCK_RCU_FREE);

[Severity: Low]
This isn't a bug, but mptcp_listen() still sets the same flag separately.
That was added by 5e20087d1b67 ("mptcp: handle mptcp listener destruction
via rcu"):

	mptcp_set_state(sk, TCP_LISTEN);
	sock_set_flag(sk, SOCK_RCU_FREE);

__mptcp_init_sock() runs from both mptcp_init_sock() and
mptcp_sk_clone_init(). Is the listener-only set now redundant?

[ ... ]

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index f0a6725d2c376..c6dbc49404100 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c

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

[Severity: Critical]
Can this NULL store cause NULL pointer dereferences in other lockless
readers of subflow->conn?

After subflow_ulp_release() runs, several things are left in place:
icsk_ulp_data still points at ctx, tcp_sk(ssk)->is_mptcp is still 1, and
the subflow callbacks are still installed (sk_data_ready is
subflow_data_ready, icsk_af_ops is subflow_specific).

Before this patch, those readers got a stale msk pointer that was freed
only after an RCU grace period. Now they get NULL, and only the BPF reader
checks for that.

One case is the listener race fixed by 5e20087d1b67 ("mptcp: handle mptcp
listener destruction via rcu"). CPU1 closes the MPTCP listener:

__mptcp_close()
  mptcp_check_listen_stop()
    __mptcp_destroy_sock()
      mptcp_destroy()
        mptcp_destroy_common()
          __mptcp_close_ssk()
            __tcp_close(ssk)
              inet_csk_destroy_sock()
                tcp_cleanup_ulp()
                  subflow_ulp_release()
                    smp_store_release(&ctx->conn, NULL)

At the same time, CPU0 is in tcp_v4_rcv() in softirq. It has already found
the TCP_NEW_SYN_RECV request with the listener ssk in TCP_LISTEN, and it
continues:

tcp_check_req()
  subflow_syn_recv_sock()
    mptcp_sk_clone_init(listener->conn, ...)
      sk_clone_lock(NULL)

There is a second path. tcp_child_process() calls the listener's
sk_data_ready, which is still subflow_data_ready():

	struct sock *parent = subflow->conn;
	...
	parent->sk_data_ready(parent);

If the state is already TCP_CLOSE, the NULL dereference happens earlier,
in the __mptcp_check_fallback(msk) call inside the WARN_ON_ONCE().

Delegated actions look similar. mptcp_napi_poll() calls
mptcp_subflow_process_delegated(), which does:

	struct sock *sk = subflow->conn;

	if (status & BIT(MPTCP_DELEGATE_SEND)) {
		mptcp_data_lock(sk);

There is no NULL check. The action can be queued from softirq and the
subflow closed on another CPU before the MPTCP NAPI runs.

subflow_error_report(), mptcp_check_fallback() and mptcp_try_fallback()
also use subflow->conn without a NULL check.

The new store also breaks the invariant described in mptcp_stream_accept():

	/* is_mptcp should be false if subflow->conn is missing, see
	 * subflow_syn_recv_sock()
	 */

The WARN_ON_ONCE() at the end of subflow_syn_recv_sock() checks the same
invariant. mptcp_subflow_drop_ctx() also gains a second NULL store of
ctx->conn.

SOCK_RCU_FREE is now set on every msk. Would leaving ->conn non-NULL be
enough for RCU readers? If not, every lockless reader would need a NULL
check, and is_mptcp, icsk_ulp_data and the callbacks would have to be
unpublished together.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261118084011.4051683-1-kalpan.jani%40mpiricsoftware.com
