Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426212;
	b=rYwQnNx6WYgj63Lm0J7b04+kO/x8N9wmANSNYCtg8ZzExCM6jfXgv6IXe6S0QXbfEZG3
	 spjAFixJPz1yU6v1AeEXlt9vYQqvorsEO/3TH81c/SIo0vnJpYQX5R+YlGOccR4gRrVmN
	 RpZN0Wn5GN/5UtAclTElTrd7qX1HjguctL59wyy+PXhVYI/VhkVDzK97kwD5XfnNXTiot
	 Wy7z/KId4oTlstgtTacYtOic4WAEREc+DPTUNbDReXwfm0I/zoUvHxwDrgx+u15RQBesn
	 L7zTicZYeGIkpOQBPKUTdtOZZ0gs8J5Pk44XVm3t1vg2zBCyC5S6ofpkiw3ncERSxog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426212;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Y0dcZzE5PYWnSyhhAQw+jR5ki5g3iIuGW62hn6AQhDk=;
	b=UJdndHkUHeORm8BYRUnxhqYfP8KxXQ1B4oBjlMkSEV4Di5UY48TNQGyhjeUChwKpauUX
	 4r4ZSmzfUXJbSYi8cwcL1MmOe2cbxFI1zcnsh/U3QqNU05IN+qyVwvuyk4jdt9ZZJ8BGs
	 OPv0QoxhL3cFyUJ2kG5mhz6BzR3Ckad4ihzymd2zjmyV7CGvDSzrJegGRfPpZuYGVQG5I
	 hap1p9eW3eXeS2O0AnM1w1pbDqY+n6vSCS9Ltz3hX7Qqg56muvrF5pIg0xfJHwWikmego
	 h6GuzkqolrA95qCzz25O/03CyZHIY+62gr3/daUP8NO2+qaDHeV9JV7BRBufEuPKrLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mzuq5skw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9369606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mzuq5skw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AE21F000C6;
	Mon, 23 Nov 2026 09:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795426212;
	bh=Y0dcZzE5PYWnSyhhAQw+jR5ki5g3iIuGW62hn6AQhDk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=mzuq5skweNR4Mh/rLy/zOtMKEH6Mf2K+g+UOoDhAlZ9sQLET8y/hSy8jgliWIABCz
	 rPayG3Wn2ORNZpb02FiHB5yqZMJe5B2WlYO620pDeAlAOCG4Vi43oMHvcdE/d8um5g
	 5kt8y/MEhSKye2p8Em8vjPKlStkvMzsis3tgRGjnr0g6Hc86TimHZ3+vCWMAZPmPQB
	 7/Z/xUNtYWpkuB4pUpWvPVls0jRFsp3sXVOfkyGbmeZRnClyfNPQ3TaZTTP6C7mJNw
	 xx2wkZEJx+vft42RLf3kt459WVgTP8Cnzq5Sqgxhy1lw4LympGrPqpGDO7Mb5x4AK+
	 dIJao9JXLjnxw==
Message-ID: <sashiko-outbox-228974@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v7] mptcp: bpf: fix NULL deref and UAF in
 bpf_mptcp_sock_from_subflow()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kalpan Jani" <kalpan.jani@mpiricsoftware.com>, mptcp@lists.linux.dev
In-Reply-To: <20261123084836.1704274-1-kalpan.jani@mpiricsoftware.com>
References: <20261123084836.1704274-1-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 09:30:12 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] bpf: missing MEM_RCU tagging and sleepable gate in
  check_helper_call()
- [High] mptcp: NULL deref in mptcp_subflow_process_delegated() after
  ULP release
- [High] mptcp: setting SOCK_RCU_FREE in subflow_create_ctx() leaks
  socket refs
- [High] mptcp: NULL deref in subflow_data_ready() racing with listener
  close
- [Medium] mptcp: bpf: UAF on subflow ctx due to uncleared icsk_ulp_data
--

commit f52b13bf0febdfcc37197ba78c9e6dab39011b6b
Author: Kalpan Jani <kalpan.jani@mpiricsoftware.com>

mptcp: bpf: fix NULL deref and UAF in bpf_mptcp_sock_from_subflow()

This commit uses RCU and release/acquire ordering to synchronize
bpf_mptcp_sock_from_subflow() with subflow creation, fallback and teardown,
sets SOCK_RCU_FREE on parent and subflow sockets, and adds a needs_rcu
helper check in the BPF verifier.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5f874979b8d75..15f3136fafa52 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10912,6 +10912,14 @@ static int check_helper_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn
>  		return -EINVAL;
>  	}
> =20
> +	if (fn->needs_rcu && in_sleepable(env) &&
> +	    !env->cur_state->active_rcu_locks) {
> +		verbose(env,
> +			"helper %s#%d requires bpf_rcu_read_lock() in sleepable context\n",
> +			func_id_name(func_id), func_id);
> +		return -EINVAL;
> +	}
> +
>  	/* Track non-sleepable context for helpers. */
>  	if (!in_sleepable_context(env))
>  		env->insn_aux_data[insn_idx].non_sleepable =3D true;
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

[Severity: High]
Does check_helper_call() leave the returned mptcp_sock pointer untagged with
MEM_RCU when fn->needs_rcu is true?

When a sleepable context such as a bpf_wq or bpf_task_work callback calls
bpf_skc_to_mptcp_sock() inside bpf_rcu_read_lock(), check_helper_call() sets
R0 to PTR_TO_BTF_ID | ret_flag without MEM_RCU.  On bpf_rcu_read_unlock(),
invalidate_rcu_protected_refs() only demotes registers carrying MEM_RCU to
PTR_UNTRUSTED, so the BPF program can keep using the unreferenced mptcp_sock
pointer after the RCU read section ends and trigger a use-after-free.

In addition, tracing_prog_func_proto() returns NULL whenever prog->sleepable
is set, which rejects bpf_skc_to_mptcp_sock() in sleepable tracing, LSM and
syscall programs before check_helper_call() reaches the fn->needs_rcu check,
even when the call is wrapped in bpf_rcu_read_lock().

[ ... ]

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index f0a6725d2c376..d8721d38467ec 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c

[ ... ]

> @@ -1857,6 +1867,8 @@ static struct mptcp_subflow_context *subflow_create=
_ctx(struct sock *sk,
>  	if (!ctx)
>  		return NULL;
> =20
> +	/* BPF readers may access the subflow socket under RCU. */
> +	sock_set_flag(sk, SOCK_RCU_FREE);
>  	rcu_assign_pointer(icsk->icsk_ulp_data, ctx);
>  	INIT_LIST_HEAD(&ctx->node);
>  	INIT_LIST_HEAD(&ctx->delegated_node);

[Severity: High]
Does setting SOCK_RCU_FREE on full TCP subflow sockets break
sk_is_refcounted() and leak socket references on BPF lookups?

include/net/sock.h:sk_is_refcounted() {
	/* Only full sockets have sk->sk_flags. */
	return !sk_fullsock(sk) || !sock_flag(sk, SOCK_RCU_FREE);
}

When a BPF program looks up an established or connecting subflow socket via
bpf_sk_lookup_tcp() or bpf_skc_lookup_tcp(), __inet_lookup_established()
increments sk->sk_refcnt.  Because SOCK_RCU_FREE is now set on the subflow
socket, sk_is_refcounted(sk) returns false, so bpf_sk_release() skips
sock_gen_put(sk) and permanently leaks the socket reference.  bpf_sk_assign=
()
also relies on sk_is_refcounted(sk) and will skip taking a reference on the
subflow socket.

> @@ -2040,6 +2052,11 @@ static void subflow_ulp_release(struct sock *ssk)
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
Can clearing ctx->conn here and in mptcp_subflow_drop_ctx() cause a NULL
pointer dereference in mptcp_subflow_process_delegated()?

CPU0                                  CPU1
mptcp_subflow_delegate(ssk,
  MPTCP_DELEGATE_SEND)
  set_bit(MPTCP_DELEGATE_SEND,
    &subflow->delegated_status)
  list_add_tail(&subflow->delegated_node,
    &delegated->head)
                                      __mptcp_close_ssk(..., ssk, ...)
                                        __tcp_close(ssk, 0)
                                          inet_csk_destroy_sock(ssk)
                                            ...
                                              subflow_ulp_release(ssk)
                                                smp_store_release(&ctx->con=
n,
                                                  NULL)
                                                mptcp_subflow_ops_undo_over=
ride(ssk)
                                        release_sock(ssk)
mptcp_napi_poll()
  mptcp_subflow_process_delegated(ssk,
    xchg(&subflow->delegated_status, 0))
    sk =3D subflow->conn
    mptcp_data_lock(sk)  <-- NULL pointer dereference

Once mptcp_subflow_delegate() queues ssk on the per-CPU
mptcp_delegated_actions list, only mptcp_napi_poll() on that CPU dequeues i=
t.
When subflow_ulp_release() runs first, it clears ctx->conn and restores
ssk->sk_prot, so release_sock(ssk) no longer runs tcp_release_cb_override()
to drain delegated_status.  mptcp_napi_poll() then calls
mptcp_subflow_process_delegated() with pending status bits and a NULL
subflow->conn.

[Severity: High]
Can clearing ctx->conn in subflow_ulp_release() also cause a NULL pointer
dereference in subflow_data_ready() when racing with listener close?

CPU0 (<softirq>)                      CPU1
tcp_v4_rcv()
  tcp_child_process(listener_ssk, ...)
                                      __mptcp_destroy_sock()
                                        ...
                                          __mptcp_close_ssk(..., listener_s=
sk, ...)
                                            __tcp_close(listener_ssk, 0)
                                              ...
                                                subflow_ulp_release(listene=
r_ssk)
                                                  smp_store_release(&ctx->c=
onn,
                                                    NULL)
    listener_ssk->sk_data_ready(listener_ssk)
      subflow_data_ready(listener_ssk)
        parent =3D subflow->conn
        msk =3D mptcp_sk(parent)
        parent->sk_data_ready(parent)  <-- NULL pointer dereference

tcp_child_process() calls parent->sk_data_ready(parent) under rcu_read_lock=
()
without holding the listener socket lock.  Because subflow_ulp_release() se=
ts
ctx->conn to NULL while leaving sk_data_ready set to subflow_data_ready(),
subflow_data_ready() loads a NULL parent pointer and dereferences it in
mptcp_sk(parent) (when CONFIG_DEBUG_NET is enabled) or
parent->sk_data_ready(parent).

[Severity: Medium]
Can bpf_mptcp_sock_from_subflow() still read a freed subflow context after
kfree_rcu(ctx, rcu)?

net/mptcp/subflow.c:subflow_ulp_release() {
	...
	mptcp_subflow_ops_undo_override(ssk);
	if (release)
		kfree_rcu(ctx, rcu);
}

subflow_ulp_release() (as well as __mptcp_close_ssk() and
mptcp_subflow_drop_ctx() when icsk_ulp_ops has already been cleared by
tcp_cleanup_ulp()) frees ctx via kfree_rcu() without clearing
inet_csk(ssk)->icsk_ulp_data or tcp_sk(ssk)->is_mptcp.  If ssk outlives ctx=
's
RCU grace period, such as while in-flight TX skbs still hold
ssk->sk_wmem_alloc, a BPF program calling bpf_skc_to_mptcp_sock(ssk) will
observe sk_is_mptcp(ssk) =3D=3D 1 and dereference the dangling icsk_ulp_data
pointer at smp_load_acquire(&ctx->conn).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123084836.1704=
274-1-kalpan.jani@mpiricsoftware.com?part=3D1
