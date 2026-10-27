Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793144788;
	b=5Yzu5wDSgPISg8yQHj6pXs8aaiVQyTqymSBK8a8oQl0iIm1ql4x8OMPFwYM6RVw+B4th
	 Ywz5lbiHOw5ZhAIuQ3wZIzIelXs4ojaE0zg2XhONwsi3Ncib+QhK8CoVuE+ZeqM9NaH8s
	 xb6xCvy/3GAHWTXI/YO1cRoQBdAYrCnDy913uFkYi8eyekyEPfA7MBoy2Ung+9FPuOT1i
	 K+ZKjvH1h9RNEXJTVH6OfS2R/KzrBBkK4gCOvl18acmf7XBA9za/i0IeNjz430q9wvPdl
	 lstcB2NKaOV9goQtX+HW6V+hhx8rcOowFKBY7Fzfz094kv1lRK20RV5+9DEYeh2cxsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793144788;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=o6mayHzGBLKtgFWAyedyY1WW9f+C9WIzemAgISHlz3Q=;
	b=Yrrym871wLU1YzWsbLdyZNC9fq1nobR3G1W3tMSM4opWlYShVLHHYxnB6Wm36NSmSdjm
	 Q8tkvHfdLu4sSKF7JCVc6EZZp1/3e0YsiVvR91CatLOKnM5bkABmTW6dpXXrGJ9yqr6lb
	 azsoasLd9S0IE28V3vJ/3eu7ncObJDmiEWFY5fp8ddxJ0LruUTWJ3G1r/QAvPJlnKpX4s
	 oeSKE7x6iDzSGq2WtVGAAEuk/PBkrvpDJPpElzaOLnElg+HbtukJTx45NoxJHkgVaVXxO
	 77uxLON7YmuLrzA5gpbEVXi6+PycQo/r5Rn75Ppc4inM2KsiDEFvnZsmHgTWCYJ+XuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PjK4aGi0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732D2606A31A
	for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 23:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PjK4aGi0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73FD1F01825;
	Tue, 27 Oct 2026 23:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793144788;
	bh=o6mayHzGBLKtgFWAyedyY1WW9f+C9WIzemAgISHlz3Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PjK4aGi0pcZmSs80h7m1DGe7/2bJNpZaySuZtcTKVNsgCcCQ5f7V3DZ17Lgmp3dfs
	 GKMpcILNYd9dNGiNmzwKJi9vXm/DeHAiVhDG7kWtoeNcGJIR7z4GWoE+JFFMW4yauZ
	 bUFP833xnffEDkhRcG8wiiXZ0moHR60yUOskIgDo4+zNQHoBs1nquVKtm5sT287upO
	 hnxSl/v4e8xkHEb1zkYFcZx9oKYyJPFbQQYdjnPXdp0YtT/CxxPudRA5nTe0AkGOt5
	 bHE/FfMSB6NugiMOyL64vLaApDlvxlVoQqGV7hYAvIjAx26IZ76kWKlT7p8fOdb9mk
	 Ejpk6PcXBnDlQ==
Subject: Re: [PATCH mptcp-next v2 1/4] mptcp: give MPTCP sockets a distinct
 lockdep class
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Tue, 27 Oct 2026 23:46:27 +0000
Message-ID: <179314478731.3132.9286359278508249322@kernel.org>
In-Reply-To: =?utf-8?q?=3Ca17b9360df88d22c8ed579f532c41456fc46006e=2E1793010?=
 =?utf-8?q?744=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3Ca17b9360df88d22c8ed579f532c41456fc46006e=2E17930107?=
 =?utf-8?q?44=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Race in the passive path of mptcp_sk_clone_init()
  (net/mptcp/protocol.c): the msk lock is reinitialized after other…

--

mptcp: give MPTCP sockets a distinct lockdep class

This commit moves the msk lock reclassification out of the PM listener
creation path and into a new helper, mptcp_reclassify_socket(). The helper
uses separate lockdep classes for kernel and user sockets, per address
family. It is called from mptcp_init_sock() for active sockets and from
mptcp_sk_clone_init() for passive ones. In the passive path,
sk_clone_lock() is replaced by sk_clone(..., false) followed by
bh_lock_sock().

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 02a4f479d9d8c..d4f42dfc227e2 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3267,11 +3267,43 @@ static void mptcp_ca_reset(struct sock *sk)

[ ... ]

> +static void mptcp_reclassify_socket(struct sock *sk)
> +{

[ ... ]

> +	sock_lock_init_class_and_name(sk, slock_name,
> +				      &mptcp_slock_keys[is_kern][is_ipv6],
> +				      lock_name, &mptcp_keys[is_kern][is_ipv6]);
> +}
> +
>  static int mptcp_init_sock(struct sock *sk)
>  {
>  	struct net *net = sock_net(sk);
>  	int ret;
>  
> +	mptcp_reclassify_socket(sk);
> +
>  	__mptcp_init_sock(sk);
>  
>  	if (!mptcp_is_enabled(net))
> @@ -3772,13 +3804,16 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
>  				 struct request_sock *req)
>  {
>  	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
> -	struct sock *nsk = sk_clone_lock(sk, GFP_ATOMIC);
> +	struct sock *nsk = sk_clone(sk, GFP_ATOMIC, false);
>  	struct mptcp_subflow_context *subflow;
>  	struct mptcp_sock *msk;
>  
>  	if (!nsk)
>  		return NULL;
>  
> +	mptcp_reclassify_socket(nsk);
> +
> +	bh_lock_sock(nsk);

[Severity: High]
Can this reinitialize the msk lock while another CPU already holds it?

When lock is false, sk_clone() makes the new socket's refcount nonzero
before it returns, and it does not hold sk_lock.slock at that point:

net/core/sock.c:sk_clone() {
    ...
	smp_wmb();
	refcount_set(&newsk->sk_refcnt, 2);
    ...
}

mptcp_prot uses SLAB_TYPESAFE_BY_RCU and the msk clears SOCK_RCU_FREE, so
this clone can reuse a freed msk object right away. A reader in
mptcp_token_iter_next() may have loaded the old pointer under RCU. Its
refcount_inc_not_zero() can then succeed on the recycled object, and only
the netns is checked again afterwards:

net/mptcp/token.c:mptcp_token_iter_next() {
    ...
			if (!refcount_inc_not_zero(&sk->sk_refcnt))
				continue;

			if (!net_eq(sock_net(sk), net)) {
    ...
}

The callers then lock the socket, for example:

mptcp_nl_flush_addrs_list()
    lock_sock(sk);

mptcp_diag_dump()->mptcp_diag_fill_info()
    lock_sock_fast(sk);

If one of these overlaps with mptcp_reclassify_socket(), the
sock_lock_init_class_and_name() call does more than set the lockdep class:

	sk->sk_lock.owned = 0;
	init_waitqueue_head(&sk->sk_lock.wq);
	spin_lock_init(&(sk)->sk_lock.slock);

That could reset a spinlock that another CPU holds, or clear the ownership
that a lock_sock() caller has just taken. The clone path would then take
bh_lock_sock() on the reset lock. __mptcp_init_sock() would reinitialize
conn_list and other fields while the iterator caller thinks it owns the msk.

Before this patch, sk_clone_lock() took bh_lock_sock() before
refcount_set(2) and held it through mptcp_sk_clone_init(). A late
lock_sock() caller would just spin until bh_unlock_sock().

The new call in mptcp_init_sock() seems to open a similar window for
user-created sockets. sock_init_data_uid() has already set sk_refcnt to 1
before inet_create() calls sk_prot->init(). Before this patch, user sockets
did not get their lock reinitialized after that point.

The window looks narrow, since an iterator has to hold a stale pointer while
the msk object is recycled. Could the reclassification be done before the
socket's refcount is set, instead of after sk_clone() returns?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793010744.git.tanggeliang%40kylinos.cn
