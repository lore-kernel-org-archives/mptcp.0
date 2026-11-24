Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795559396;
	b=nhjpPc1wSEIThjUuwQgKkdecnhGo9tOvhybR4mFeiJQr2nGNajZkf6K6tM2TGyNLTtMV
	 pfG3ShoQrqbjG8Ew64VF0UXIviTbjG/1jN/SLMi8J8DgR9AXTyGXT7XU0JAXN1+dMKUPn
	 o5pe8uXaBSantLSPSCuPDG0s2X/MSjqvrS/kLbNozvr3W17xA9JQ5CwyQiY479Bu2HOZ5
	 vHHPwB+2Z8j7dhxYXXl3vd8vhyBxBRJ7oyvByFxVtQRiWVWr5SRSqi2FgccWm+H/QuzOC
	 /6VFNN9E/teHI7tVh0K74ZD3Cwxm16ck5e4tKZGW+Y7qzTlf5btb35c9dImNsRVkatQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795559396;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=8et+iCwsafRi1nYuyicQaIQGZoNATZQIC60On8QLinQ=;
	b=gQer6PU486pbh1FqIgdUezHEpliaW7s++GgfrraqWgMUni7I/hASdQbrM56Mgsdsjso2
	 jNEnyMRlYL9ehr/v2p4+TqrX+MsHtY+PDdc/1TyoV5m7THcyx7DT2N4QfmQ6xQfJXta4b
	 tHPwr4bvsAJxSuzVZDe4t0NGdqDRiQiiUumaPHq9VKdhdvuIN/9j+htb5e7oOa51+d4O/
	 2JwUjZICiGHgpwS6H6mj5Uq5vAkVCD3BnlEIThYAFaDJZTeVl6cs2g3+0O6Cb9VZmp7K3
	 GFLmpG3U6BPMbVejFLMcg2kFn0aqMIaFOf+dPSVYz6kAKxchSRgsa+TzmHEtqz4UhDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y79amc1p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574EA606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y79amc1p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610111F000C0;
	Tue, 24 Nov 2026 22:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795559395;
	bh=8et+iCwsafRi1nYuyicQaIQGZoNATZQIC60On8QLinQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Y79amc1pYGu39TAvnpa78xl0AW4Bew9LKbJif5YRZzpd3P1ypvxd+arJWw2OE+mAN
	 d9yV6AblvgmWeeMOMq7PLdXdVX86WcLogiWm3zSzTHHdLYZgEihhfETit7RsEUSOtr
	 2j2UHafKrzYZKg7GHNLJ5FAe1/saXlb8SPkldKGQvRzGuIr5pQsRMcbOZuOpsuAtQ6
	 PyJTnUa6hV98P1AUBxjParXSybFc0pOrQMr2DjUJJgmyH916THiQn82LVNhlkpwFEW
	 6RscoiRwhRNbDPCVQnrklxMqddWs1hYsLT/iA8qkzExCEWeCF0xb/lm/0tZT9Chb0a
	 nkw85NKxc0+0Q==
Subject: Re: [PATCH mptcp-next v7] mptcp: bpf: fix NULL deref and UAF in
 bpf_mptcp_sock_from_subflow()
From: netdev-bot+sashiko@kernel.org
To: kalpan.jani@mpiricsoftware.com
Cc: mptcp@lists.linux.dev, shardul.b@mpiricsoftware.com, janak@mpiric.us,
 kalpanjani009@gmail.com, kuba@kernel.org
Date: Tue, 24 Nov 2026 22:29:54 +0000
Message-ID: <179555939488.3133.4447740907594911294@kernel.org>
In-Reply-To: <20261123084836.1704274-1-kalpan.jani@mpiricsoftware.com>
References: <20261123084836.1704274-1-kalpan.jani@mpiricsoftware.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 0 · High: 3 · Medium: 2 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] subflow_create_ctx() now sets SOCK_RCU_FREE on every MPTCP
  subflow TCP socket.
- [High] The RCU teardown fix is incomplete: the subflow context is freed
  with kfree_rcu() while it is still published in icsk_ulp_data and…
- [High] mptcp: NULL deref in subflow_data_ready() racing with listener
  close
- [Medium] subflow_ulp_release() now runs smp_store_release(&ctx->conn,
  NULL) unconditionally, including when release == false.
- [Medium] The commit body leaves out two significant parts of the diff:
  (a) setting SOCK_RCU_FREE on every MPTCP subflow TCP socket in…
- [Low] The new needs_rcu verifier rule in check_helper_call() can never
  fire.
- [Low] In bpf_mptcp_sock_from_subflow(),
  rcu_dereference_check(inet_csk(sk)->icsk_ulp_data,…
- [Low] mptcp_subflow_ctx() in net/mptcp/protocol.h still says '/* Use
  RCU on icsk_ulp_data only for sock diag code */'.

--

mptcp: bpf: fix NULL deref and UAF in bpf_mptcp_sock_from_subflow()

This commit changes bpf_mptcp_sock_from_subflow() to load icsk_ulp_data
under RCU. ctx->conn is now published and cleared with release/acquire
ordering, SOCK_RCU_FREE is set on the parent msk and on subflow sockets,
and sleepable tracing programs can no longer use bpf_skc_to_mptcp_sock().
It also adds a needs_rcu flag to struct bpf_func_proto and checks it in
check_helper_call().

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/622

> Give the parent msk RCU-grace lifetime by setting SOCK_RCU_FREE in
> the shared __mptcp_init_sock(), covering both active and passive
> paths, and dropping the reset in mptcp_sk_clone_init(). This ensures
> a reader that obtains the parent under the applicable RCU protection
> does not access freed memory.
>
> Keep bpf_skc_to_mptcp_sock() available to non-sleepable tracing
> programs for compatibility, while rejecting sleepable tracing
> programs because classic RCU does not protect the parent socket
> through sleepable execution.

[Severity: Medium]
The commit message covers SOCK_RCU_FREE on the parent msk. The diff also
does two things the message does not mention:

  - it sets SOCK_RCU_FREE on every subflow TCP socket in
    subflow_create_ctx()
  - it adds a generic needs_rcu field to struct bpf_func_proto and a new
    rejection path in check_helper_call()

Both appear only in the "Changes since v6" notes below the --- separator,
so they won't be in the applied commit.

Could the commit message describe both changes? The subflow change alters
sk_is_refcounted() behaviour for established TCP sockets, and the verifier
change touches core BPF.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5f874979b8d75..15f3136fafa52 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10912,6 +10912,14 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  		return -EINVAL;
>  	}
>  
> +	if (fn->needs_rcu && in_sleepable(env) &&
> +	    !env->cur_state->active_rcu_locks) {
> +		verbose(env,
> +			"helper %s#%d requires bpf_rcu_read_lock() in sleepable context\n",
> +			func_id_name(func_id), func_id);
> +		return -EINVAL;
> +	}

[Severity: Low]
Can this new check ever fire?

bpf_skc_to_mptcp_sock_proto is the only proto that sets needs_rcu. It is
reachable from two places:

  - bpf_sk_base_func_proto(), whose program types can't be sleepable
  - tracing_prog_func_proto(), which this patch changes to:

    case BPF_FUNC_skc_to_mptcp_sock:
        return prog->sleepable ? NULL : &bpf_skc_to_mptcp_sock_proto;

bpf_lsm_func_proto() and syscall_prog_func_proto() also fall through to
tracing_prog_func_proto(). So any sleepable program fails earlier in
bpf_get_helper_proto() with "program of this type cannot use helper".

The two changes also set different policies for the same helper. One
allows it in sleepable programs under bpf_rcu_read_lock(), the other
never allows it in sleepable programs. Is one of them meant to go?

There is also the argument type. arg1 is ARG_PTR_TO_SOCK_COMMON, which
doesn't accept PTR_TO_BTF_ID, so tracing and LSM programs can't easily
pass a valid socket here. Does the "compatibility" reason for keeping it
in non-sleepable tracing programs still hold?

[ ... ]

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

[Severity: Low]
Will this produce a "suspicious rcu_dereference_check() usage" splat with
CONFIG_PROVE_RCU when the helper is called from TC egress or XDP?

bpf_skc_to_mptcp_sock_proto is also exposed through
bpf_sk_base_func_proto(). Some of those callers don't hold classic RCU:

  - TC egress runs from __dev_queue_xmit() under rcu_read_lock_bh() only
  - native XDP runs in NAPI with BH disabled

If the socket comes from bpf_skc_lookup_tcp(), both rcu_read_lock_held()
and lockdep_sock_is_held() are false. The old code used a __force cast
with no check, so the splat would be new.

The access itself is safe, because BH-disabled sections are RCU readers.
Should the condition also accept rcu_read_lock_bh_held(), or use
rcu_read_lock_any_held()?

> +		if (ctx) {
> +			/* Pair with release stores publishing or clearing ctx->conn. */
> +			conn = smp_load_acquire(&ctx->conn);

[Severity: Low]
This isn't a bug, but mptcp_subflow_ctx() in net/mptcp/protocol.h still
says:

    /* Use RCU on icsk_ulp_data only for sock diag code */

The conn field in struct mptcp_subflow_context is still documented only
as "parent mptcp_sock".

This patch adds a second RCU reader, and every writer of ->conn now has
to use smp_store_release() to pair with this smp_load_acquire(). Could
both comments be updated so a later plain store to ->conn doesn't
silently break the pairing?

> +			if (conn)
> +				return mptcp_sk(conn);
> +		}
> +	}

[ ... ]

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index f0a6725d2c376..d8721d38467ec 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c

[ ... ]

> @@ -1857,6 +1867,8 @@ static struct mptcp_subflow_context *subflow_create_ctx(struct sock *sk,
>  	if (!ctx)
>  		return NULL;
>  
> +	/* BPF readers may access the subflow socket under RCU. */
> +	sock_set_flag(sk, SOCK_RCU_FREE);

[Severity: High]
Does setting SOCK_RCU_FREE here leak socket references through the BPF
socket lookup helpers?

For passive subflows, inet_csk_clone_lock() clears the flag on purpose:

    /* listeners have SOCK_RCU_FREE, not the children */
    sock_reset_flag(newsk, SOCK_RCU_FREE);

It then calls inet_clone_ulp(), which reaches subflow_ulp_clone() and
then subflow_create_ctx(), so the flag is set again. Nothing clears it
when the subflow falls back to plain TCP.

Established lookups always take a reference. In
sk_lookup()->__inet_lookup()->__inet_lookup_established(),
*refcounted is set to true.

bpf_sk_release() only drops that reference when sk_is_refcounted() is
true:

    if (sk && sk_is_refcounted(sk))
        sock_gen_put(sk);

sk_is_refcounted() is:

    return !sk_fullsock(sk) || !sock_flag(sk, SOCK_RCU_FREE);

For an established subflow this is now false.

So would each bpf_sk_lookup_tcp() or bpf_skc_lookup_tcp() followed by
bpf_sk_release() leak one sk_refcnt? That applies to established MPTCP
subflows and to connections that fell back from MPTCP.

If so, the subflow socket would never be freed, and its netns reference
would keep the namespace pinned. A program can do this once per packet.

>  	rcu_assign_pointer(icsk->icsk_ulp_data, ctx);

[ ... ]

> @@ -2040,6 +2052,11 @@ static void subflow_ulp_release(struct sock *ssk)
>  		if (!release && !test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW,
>  						  &mptcp_sk(sk)->flags))
>  			mptcp_schedule_work(sk);
> +
> +		/* hide the parent from lockless readers (e.g. BPF) before
> +		 * dropping the subflow-owned reference
> +		 */
> +		smp_store_release(&ctx->conn, NULL);

[Severity: High]
Can this NULL store race with subflow_data_ready() on the MPTCP
listener subflow?

On 3WHS completion, tcp_child_process() runs in softirq under
rcu_read_lock() without the listener socket lock, and calls
READ_ONCE(parent->sk_data_ready)(parent). For an MPTCP listener that
parent is the listener ssk, so the call lands in subflow_data_ready(),
which does:

    u16 state = 1 << inet_sk_state_load(sk);
    struct sock *parent = subflow->conn;
    ...
    msk = mptcp_sk(parent);
    if (state & TCPF_LISTEN) {
        ...
        parent->sk_data_ready(parent);

Meanwhile, close() on the MPTCP listener goes through
mptcp_check_listen_stop() and then reaches subflow_ulp_release() via
this path:

    __mptcp_destroy_sock()
      mptcp_destroy_common()
        __mptcp_close_ssk()
          __tcp_close()
            inet_csk_destroy_sock()
              tcp_cleanup_ulp()
                subflow_ulp_release()

Nothing on that path restores listener_ssk->sk_data_ready. A
concurrent softirq can therefore still enter subflow_data_ready() after
this store.

Before this patch, subflow->conn kept pointing at the listener msk.
Commit 5e20087d1b67 ("mptcp: handle mptcp listener destruction via
rcu") made that msk SOCK_RCU_FREE so that this lockless reader stays
safe. With this patch the reader can load NULL instead:

  - with CONFIG_DEBUG_NET, mptcp_sk(NULL) faults in its WARN_ON()
    check on sk_protocol
  - without it, the state load can still see TCP_LISTEN while the conn
    load happens after subflow_ulp_release(). Then
    parent->sk_data_ready(parent) is a NULL dereference in softirq

This looks reachable by an unprivileged local user who closes a
listening MPTCP socket while connections are completing.

Should the clear be skipped for listener subflows? Alternatively, should
subflow_data_ready() and the other in-kernel lockless users of
subflow->conn read it with READ_ONCE() and bail out on NULL? A third
option would be to leave ->conn intact for in-kernel users and give the
BPF helper a separate way to tell that the parent reference is gone.

[Severity: Medium]
This store now runs even when release is false. That happens when
inet_child_forget() runs on an unaccepted MPC subflow. The ctx is then
kept on msk->conn_list on purpose, and possibly on the per-CPU delegated
list, until __mptcp_close_ssk() frees it.

Can mptcp_subflow_process_delegated() then dereference NULL? It does:

    struct sock *sk = subflow->conn;

    if (status & BIT(MPTCP_DELEGATE_SEND)) {
        mptcp_data_lock(sk);

mptcp_napi_poll() calls it after bh_lock_sock_nested(ssk). It doesn't
check whether the ssk was destroyed or its ULP released.

Suppose a delegation was queued before
inet_csk_listen_stop()->inet_child_forget() destroyed the child. The
later NAPI pass would see conn == NULL, where before this patch it saw
the still-valid msk.

I haven't confirmed a path that queues a delegated action on an
unaccepted passive subflow. Nothing removes the subflow from the
delegated list on ULP release, though.

Should the clear be skipped when release is false, or should the
in-kernel users of subflow->conn handle NULL?

>  		sock_put(sk);
>  	}
>  

[Severity: High]
Is the teardown window fully closed here? After clearing ctx->conn,
subflow_ulp_release() continues with:

    mptcp_subflow_ops_undo_override(ssk);
    if (release)
        kfree_rcu(ctx, rcu);

At that point icsk_ulp_data still points to ctx and tcp_sk(ssk)->is_mptcp
is still 1. Afterwards, tcp_cleanup_ulp() only clears icsk_ulp_ops.

The same pattern shows up in two other places:

  - __mptcp_close_ssk(), in the !icsk_ulp_ops branch
  - mptcp_subflow_drop_ctx() when icsk_ulp_ops is already NULL, because
    subflow_ulp_fallback() is skipped there

The ssk can outlive the grace period. For example, in-flight TX skbs
hold sk_wmem_alloc and delay sk_free(), and the ssk is now
SOCK_RCU_FREE as well.

Consider a TC egress program on a lower device that reads skb->sk from a
delayed TX clone. It would pass every check in
bpf_mptcp_sock_from_subflow():

    tcp_v4_destroy_sock()
      tcp_cleanup_ulp()
        subflow_ulp_release()
          kfree_rcu(ctx, rcu)
    ... grace period ...
    TC egress prog: bpf_skc_to_mptcp_sock(skb->sk)
      bpf_mptcp_sock_from_subflow()
        ctx = rcu_dereference_check(icsk_ulp_data, ...)  /* freed ctx */
        conn = smp_load_acquire(&ctx->conn)

Wouldn't that read freed slab memory? If the slot has been reused, it
could also hand a garbage pointer to BPF as a trusted mptcp_sock.

The old code had the same ctx dereference. However, the commit message
says this patch fixes the teardown use-after-free by relying on RCU.

Should icsk_ulp_data and is_mptcp be cleared before kfree_rcu(), the way
subflow_ulp_fallback() does?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123084836.1704274-1-kalpan.jani%40mpiricsoftware.com
