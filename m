Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793014023;
	b=tD/YC+IYhtwTvpvvBd3QeoqPNrfbEiYoW9CvAWExodM8t2fZyfv+/EA2bn97fmgHn/m5
	 nUb12TGME279D8cNexvF+l+Q9t51099U9yzWJJ0CgnVC+ucZHpmO5F3uLVWhmmBlZ39fm
	 x3iC3DEB+3ZJBfqNc8vWNrRLJgQpMjDEd0Dx+5/A9oeLsU0B4gu0M1Sk7YeUb5mBYreQb
	 AKRrh5K/xYg8yDj4AG8GribJNXsiwWjW7r6zHrTep8JF65K4hpoB1bCriGNxCPXQc6ai9
	 54V+pZ8CI8Ks7ML65PoyIqgwUyfHBIg7Qzl46nF5Zwy2eTgRWjkjz/z7IFQmYAItLTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793014023;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8r8wr/YA6Gnrs/PEVTvpveMe/4n5hRDSj75klYH++qk=;
	b=TsBzbtQJaYJEO/SVg3rrYGIYDDek5oI1oWAARtwK6qwvocIbQalR1XX6eTbfsEgUY/ep
	 5qN2sH9KsnCF1sk0ehtAlK3TN2eELqIOWqTCiS/IBsUwn7A3XZ22NvipqPiaOQpsQcAxY
	 7mbCmFiKlA8p+eV5YPxq0Vlk18bNLHoxf77ADkQaT54ps2ARSMKiveFpX6ou40zboOV8s
	 08rGutzSPmVvjm/0Jisy5tk1eumJUfGVTImEVmM9M6m2lt0UhBYoxVsyIrZxzan5faE+Q
	 dErefBDsiErtNEHsk0oWm12cQin+gsNKZrpouD0evYfaUvlVKCmoFDQHGmJQARZr+KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XtCuBxIE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE9E606A31B
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 11:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XtCuBxIE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DE71F01825;
	Mon, 26 Oct 2026 11:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793014023;
	bh=8r8wr/YA6Gnrs/PEVTvpveMe/4n5hRDSj75klYH++qk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=XtCuBxIE6Q6PULW66KpNMDNH+wJ7aSTf3Y7xA/L3sBPX1FUs/7YOSCCbv67LfAFTj
	 2HCrPdmTdeJs+PkBfyVWI9gAfWTNUJ1SoVEqMWMBN5WuWS6Q5gVSwI1G3+Txy0AoXj
	 bcAtduQX3UecFD3FATPh2B0bJJwIKkjwVt/R2LofkmTA4XOrHZ/s4aGinQJ6EHLR8T
	 r4Y1z6KRFvJ5WSW6F5E4QR4i94fNBZ6P7ufa1uxmh5WbKh/ba6QJQxpWwVht84OxsW
	 LmEUrjykobBQJvV+nO26Ks1oHRxbhj2pkjRcnRgKbfE6yGxqfAl1Rm+GJErA++8kkv
	 r4osHhFiNJlqQ==
Message-ID: <sashiko-outbox-185097@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v2 1/4] mptcp: give MPTCP sockets a distinct
 lockdep class
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <a17b9360df88d22c8ed579f532c41456fc46006e.1793010744.git.tanggeliang@kylinos.cn>
References: <cover.1793010744.git.tanggeliang@kylinos.cn>
 <a17b9360df88d22c8ed579f532c41456fc46006e.1793010744.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 11:27:02 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mptcp: race on sk_lock reinit and unlocked clone with SLAB_TYPESAF=
E_BY_RCU
--

commit 1535a4c9bef6857111a0222f084ae0666d8e7461
Author: Geliang Tang <geliang@kernel.org>

mptcp: give MPTCP sockets a distinct lockdep class

This commit introduces mptcp_reclassify_socket() to assign distinct lockdep
classes to MPTCP sockets based on address family and kernel vs user socket
type. It calls this helper from mptcp_init_sock() and from
mptcp_sk_clone_init() after switching from sk_clone_lock() to unlocked
sk_clone().

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 02a4f479d9d8c..d4f42dfc227e2 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3267,11 +3267,43 @@ static void mptcp_ca_reset(struct sock *sk)
>  	icsk->icsk_ca_ops =3D NULL;
>  }
> =20
> +/* The subflow socket lock is acquired in a nested to the msk one
> + * in several places, even by the TCP stack: lockdep complains when
> + * both are kernel sockets. Instead of propagating the _nested modifiers
> + * in several places, re-init the lock class for the msk socket to an
> + * mptcp specific one. Separate lock classes are used for kernel and
> + * user sockets to prevent lockdep from conflating their usage patterns.
> + */
> +static struct lock_class_key mptcp_slock_keys[2][2];
> +static struct lock_class_key mptcp_keys[2][2];
> +
> +static void mptcp_reclassify_socket(struct sock *sk)
> +{
> +	bool is_ipv6 =3D sk->sk_family =3D=3D AF_INET6;
> +	const char *slock_name, *lock_name;
> +	bool is_kern =3D !!sk->sk_kern_sock;
> +
> +	if (is_kern) {
> +		slock_name =3D is_ipv6 ? "kmlock-AF_INET6" : "kmlock-AF_INET";
> +		lock_name =3D is_ipv6 ? "kmsk_lock-AF_INET6" :
> +				      "kmsk_lock-AF_INET";
> +	} else {
> +		slock_name =3D is_ipv6 ? "mlock-AF_INET6" : "mlock-AF_INET";
> +		lock_name =3D is_ipv6 ? "msk_lock-AF_INET6" : "msk_lock-AF_INET";
> +	}
> +
> +	sock_lock_init_class_and_name(sk, slock_name,
> +				      &mptcp_slock_keys[is_kern][is_ipv6],
> +				      lock_name, &mptcp_keys[is_kern][is_ipv6]);
> +}
> +
>  static int mptcp_init_sock(struct sock *sk)
>  {
>  	struct net *net =3D sock_net(sk);
>  	int ret;
> =20
> +	mptcp_reclassify_socket(sk);
> +
>  	__mptcp_init_sock(sk);
> =20
>  	if (!mptcp_is_enabled(net))
> @@ -3772,13 +3804,16 @@ struct sock *mptcp_sk_clone_init(const struct soc=
k *sk,
>  				 struct request_sock *req)
>  {
>  	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(re=
q);
> -	struct sock *nsk =3D sk_clone_lock(sk, GFP_ATOMIC);
> +	struct sock *nsk =3D sk_clone(sk, GFP_ATOMIC, false);
>  	struct mptcp_subflow_context *subflow;
>  	struct mptcp_sock *msk;
> =20
>  	if (!nsk)
>  		return NULL;
> =20
> +	mptcp_reclassify_socket(nsk);
> +
> +	bh_lock_sock(nsk);

[Severity: High]
Can calling mptcp_reclassify_socket() and unlocked sk_clone() race with
lockless RCU readers on SLAB_TYPESAFE_BY_RCU MPTCP sockets?

Both mptcp_prot and mptcp_v6_prot use SLAB_TYPESAFE_BY_RCU, and accepted
MPTCP sockets clear SOCK_RCU_FREE in mptcp_sk_clone_init(), so a closed
mptcp_sock can be immediately recycled from the slab cache while a
concurrent RCU reader in mptcp_token_iter_next() or mptcp_token_get_sock()
is walking bucket->msk_chain:

net/mptcp/token.c:mptcp_token_iter_next() {
	...
	rcu_read_lock();
	sk_nulls_for_each_rcu(sk, pos, &bucket->msk_chain) {
		++num;
		if (!net_eq(sock_net(sk), net))
			continue;

		if (num <=3D *s_num)
			continue;

		if (!refcount_inc_not_zero(&sk->sk_refcnt))
			continue;
	...
}

Once refcount_inc_not_zero(&sk->sk_refcnt) succeeds on the recycled socket,
callers of mptcp_token_iter_next() (such as mptcp_diag_dump(),
mptcp_nl_remove_subflow_and_signal_addr(), mptcp_nl_remove_id_zero_address(=
),
mptcp_nl_flush_addrs_list(), and mptcp_nl_set_flags()) immediately call
lock_sock(sk) or lock_sock_fast(sk).

In mptcp_sk_clone_init(), sk_clone_lock() previously initialized newsk's
lock and acquired bh_lock_sock(newsk) before setting newsk->sk_refcnt to 2:

net/core/sock.c:sk_clone() {
	...
	sock_lock_init(newsk);

	if (lock)
		bh_lock_sock(newsk);
	...
	smp_wmb();
	refcount_set(&newsk->sk_refcnt, 2);
}

Holding bh_lock_sock(newsk) before sk_refcnt became non-zero serialized any
concurrent lock_sock() or lock_sock_fast() reader until __mptcp_init_sock()
completed and bh_unlock_sock(nsk) was called.

With sk_clone(sk, GFP_ATOMIC, false), nsk->sk_refcnt becomes 2 while nsk is
unlocked. Can a concurrent RCU reader grab a reference on nsk and call
lock_sock(nsk) or lock_sock_fast(nsk):

1. Concurrently with mptcp_reclassify_socket(nsk) (and similarly in
   mptcp_init_sock() after sock_init_data() has set sk->sk_refcnt to 1),
   where sock_lock_init_class_and_name() zeroes sk_lock.owned and
   re-initializes sk_lock.wq, sk_lock.slock, and the lockdep maps while
   another CPU is acquiring or holding sk_lock?

2. In mptcp_sk_clone_init(), after mptcp_reclassify_socket(nsk) finishes
   and before bh_lock_sock(nsk) is called? If the reader acquires
   lock_sock(nsk) first, it sets nsk->sk_lock.owned =3D 1 and drops
   nsk->sk_lock.slock, which does not prevent bh_lock_sock(nsk) from
   proceeding into __mptcp_init_sock(nsk) concurrently, and the reader can
   iterate msk->conn_list while it still contains the raw copy of the
   listening socket's list head from sock_copy()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793010744.gi=
t.tanggeliang@kylinos.cn?part=3D1
