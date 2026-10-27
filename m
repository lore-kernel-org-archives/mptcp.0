Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112520;
	b=YkxOZ810LBww6kNL2/9Xwg3PbO9hGgwEWeEbQ3Dccgbf+2iDJs5/ZJsK5d2ZMCJ88pS7
	 gKmQnX8Cs6CSmWhOQx5wjUlAn34zFZoTiihZmW50HT/olxCDfCwvraY2mjBWSZs0Oy+62
	 Emc0Tzpziq/JgNgZLVKmL+aeGlsM2peR08Vn280qgAzUO0Eje4C2u7CgspZrnQfvHI7Et
	 n2MCdz2zuXMpN816EJounsLRrhnxePSxHjPvotDkak2wCcp+GpUyFwnsmaOpgBmyk5LZc
	 HxUCis3iCMr5g4O56OpYtAIGJPrbgHzSH0IHwjAv77xfU63WRtq1GjF0+XkdQN3fMNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112520;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=odtLs2c6sUX0/1b7pEAOiPQemPg3C0Y12KrE21q4ArA=;
	b=mdGCjZB6cDcPmXVnBKsQm8B/zMbHTmRoV2dldWUrh5iDs5Hgub6X7NUovQcG1FAfQfn7
	 JVMEgDCzAZYjb5a39G3JPGrEmajRbY/i0HYjDLOQt1GFGE1/82QyDm0cISXt0MtAPXSpz
	 06u4B/SLqbu0NcKYtSTN4HwnBU56ozbiJ3SZE2LgsIUpOSDvYq9KUWZMOxVuoJXNNPJN3
	 XOZTw6af8RAHVQ93LQcqLxh8Ak9ef/1FYzh4ysLd8nnYCw9W5Oi90kuNGOgB4wB3sFj8w
	 H3OqSV2x+V2BiD0ndLkQqQo7HV6+n2brbeejgKZVJ9N0IqYdN1X3Dm8sRo1T8FMsyDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UMxoqpvR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A52606A329
	for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UMxoqpvR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7621F031E0;
	Tue, 27 Oct 2026 14:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793112519;
	bh=odtLs2c6sUX0/1b7pEAOiPQemPg3C0Y12KrE21q4ArA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UMxoqpvR+hogIoA30ZjGi6HRHvrLKHRhpCbMhPJktXJt2iXrCkILzIHS9JkmPXEMk
	 BiygmlOFzwRjkKSl/bUzYAlb25gdVY7jeiG1jiPWitgbJU6gXgPNboqbUaR4v+5fhe
	 MBHGK2E8u7dDsF3j9XzdzqJMH8CRt0pMUMATKf6q8Hr6xCcLKOX79MoggH3HLgGjzm
	 dCrrGddmcakTU5evdXoVSK/hYeeBGSkNoZnq5fbmA+YTs8aD79AYxs+ihlWx0RZ1Tf
	 j2SV2hN1sEpNF9Lf0D+lRAyK/BbfCujeBOJEvl5HImC7ua7NhsJsIshMknEjwSht5k
	 xKv0knMocw/3A==
Message-ID: <sashiko-outbox-186762@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] mptcp: protect listener backlog reads in
 diagnostics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cen Zhang" <zzzccc427@gmail.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <pm-mptcp-objects-candidate-0066-v5-4d1b83d62fcde2d57e8d@gmail.com>
References: <pm-mptcp-objects-candidate-0066-v5-4d1b83d62fcde2d57e8d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 14:48:38 +0000
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
- [High] mptcp: UAF in mptcp_diag_get_info() as __mptcp_close_ssk() puts ss=
k first
--

commit 54c0f83180af04b33f5796a4675ffc1cc6ddce9a
Author: Cen Zhang <zzzccc427@gmail.com>

mptcp: protect listener backlog reads in diagnostics

This commit wraps the msk->first lookup and the subsequent listener backlog
reads in mptcp_diag_get_info() with rcu_read_lock() and rcu_read_unlock() to
prevent a use-after-free when a listening MPTCP socket is closed concurrent=
ly
with a token diagnostic dump.

> diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
> index 136c2d05c0eeb..28a42eee66512 100644
> --- a/net/mptcp/mptcp_diag.c
> +++ b/net/mptcp/mptcp_diag.c
> @@ -200,8 +200,10 @@ static void mptcp_diag_get_info(struct sock *sk, str=
uct inet_diag_msg *r,
>  	r->idiag_wqueue =3D sk_wmem_alloc_get(sk);
> =20
>  	if (inet_sk_state_load(sk) =3D=3D TCP_LISTEN) {
> -		struct sock *lsk =3D READ_ONCE(msk->first);
> +		struct sock *lsk;
> =20
> +		rcu_read_lock();
> +		lsk =3D READ_ONCE(msk->first);
>  		if (lsk) {
>  			/* override with settings from tcp listener,
>  			 * so Send-Q will show accept queue.
> @@ -209,6 +211,7 @@ static void mptcp_diag_get_info(struct sock *sk, stru=
ct inet_diag_msg *r,
>  			r->idiag_rqueue =3D READ_ONCE(lsk->sk_ack_backlog);
>  			r->idiag_wqueue =3D READ_ONCE(lsk->sk_max_ack_backlog);
>  		}
> +		rcu_read_unlock();

[Severity: High]
Can this still read from a freed lsk if mptcp_diag_get_info() in
net/mptcp/mptcp_diag.c races with __mptcp_close_ssk() in
net/mptcp/protocol.c?

In net/mptcp/protocol.c:__mptcp_close_ssk(), the final reference on ssk is
dropped before msk->first is cleared:

out_release:
	__mptcp_subflow_error_report(sk, ssk);
	release_sock(ssk);

	sock_put(ssk);

	if (ssk =3D=3D msk->first)
		WRITE_ONCE(msk->first, NULL);

After release_sock(ssk), the closing task runs in preemptible process conte=
xt
holding only the msk socket lock. Calling sock_put(ssk) initiates RCU
reclamation via sk_free() -> __sk_free() -> sk_destruct() -> call_rcu() whi=
le
msk->first still points to ssk.

In net/mptcp/mptcp_diag.c:mptcp_diag_get_info(), the state check happens
before entering the RCU read-side critical section:

	if (inet_sk_state_load(sk) =3D=3D TCP_LISTEN) {
		struct sock *lsk;

		rcu_read_lock();
		lsk =3D READ_ONCE(msk->first);

If mptcp_diag_get_info() observes TCP_LISTEN and is preempted before calling
rcu_read_lock(), and concurrently close() -> __mptcp_close() ->
mptcp_destroy() -> mptcp_destroy_common() -> __mptcp_close_ssk() calls
sock_put(ssk) and is preempted before WRITE_ONCE(msk->first, NULL), the RCU
grace period for ssk can complete while msk->first remains non-NULL. When
mptcp_diag_get_info() resumes and enters rcu_read_lock(), wouldn't
READ_ONCE(msk->first) still load the freed ssk pointer and dereference
lsk->sk_ack_backlog and lsk->sk_max_ack_backlog?

Should __mptcp_close_ssk() clear msk->first with WRITE_ONCE(msk->first, NUL=
L)
before calling sock_put(ssk), matching the ordering in mptcp_sk_clone_init(=
)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/pm-mptcp-objects-ca=
ndidate-0066-v5-4d1b83d62fcde2d57e8d@gmail.com?part=3D1
