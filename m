Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD8C320CBE
	for <mptcp@lists.linux.dev>; Wed,  2 Sep 2026 12:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353676; cv=none; b=kCpM4L0AzlEZhOYPwlSBQ/rUPvBJAs7khNKymdmBR0ljZTYROzlmc0q0pU5do7ETWneydX/qY1P5duVboc0tlH4CjaBbGakjeq6WYLaHmcAlVYRdb/IyMTS+c7smfGtvUtw1PzpwnkWB0jgvNbRdxPg2vaho+dPk7sivYr2FzjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353676; c=relaxed/simple;
	bh=ttAAFVKYMJLMbXsjxzpIyjufbA8sPd3aDM+EMxopEMc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p9NL3Qr668edo/AjUoqBN4M5u0XW9LXE0HBUO99EuxmVMXRHViODpptAQDW4e/JV22M7aGESJZZOL9VmTqQYZee6eeuyL2QtN4+nrvCg2f0gOdvDOs3+hgzKuWJj70lFocM1wki1pQLO3je/m80+313Hj8goK4umz3IlCuJkY/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIFz8VI7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIFz8VI7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416281F00A3A;
	Wed,  2 Sep 2026 12:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788353675;
	bh=yjtgVKahy0HHMDHeKbzmdTOeT+CuH98Yb8zxUYMpXDA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SIFz8VI7IyaCntAsmcGDeZQGcHpwRxYej67Oap8L+vUYcV+1TKSbira5gO38BLChP
	 92g1dYu+xhXwwr3Ez33ZC//nvF/TvYlYz0sYxwdoXpIDiYmYOW3pfo1rPiC90Trc5r
	 KfAqzJKNSgOrpbbXU+Gwf99GUMWC0ZCmvBeqplq1qbLquH2A0myLkFtvUPTTY3YDOO
	 9yLFbn1VZUEs2oYsr2T8kaMr3hXdh2ODZPVCcIhZe7LUClL3S86AQKbNroIsUNKWJi
	 xUA/Cr1W5xOzCSKECQAiqb4yVGjCeVvgPNdLLt6ifTHewlv54nV3DmyicvlN36GRxR
	 2+CRdpZt4InyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 2/2] mptcp: diag: bound listener bucket lock hold
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zihan Xi" <zihanx@nebusec.ai>
Cc: mptcp@lists.linux.dev
In-Reply-To: <db1f34ca8461c7b0dc5ec504ea1b99c24b909e34.1788248601.git.zihanx@nebusec.ai>
References: <cover.1788248601.git.zihanx@nebusec.ai>
 <db1f34ca8461c7b0dc5ec504ea1b99c24b909e34.1788248601.git.zihanx@nebusec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 12:54:34 +0000
Message-Id: <20260902125435.416281F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Batch-relative offset used as an absolute skip count corrupts the =
resumption state (`diag_ctx->l_num`), causing massive duplicate dumps or in=
finite loops.
- [High] Dereferencing `ctx->conn` before verifying the socket ULP type lea=
ds to an out-of-bounds read for non-MPTCP sockets.
- [High] Dropping the lock and missing re-check of `icsk_ulp_data` after ta=
king a reference on the `SLAB_TYPESAFE_BY_RCU` MPTCP socket causes a TOCTOU=
 race.
--

commit 18ad84befba3a7e705432d2c50d6139e9f7b55e6
Author: Zihan Xi <zihanx@nebusec.ai>
Date:   Tue Sep 1 12:53:47 2026 +0000

    mptcp: diag: bound listener bucket lock hold

This commit modifies the MPTCP listener diag dump to collect referenced=20
sockets while holding the bucket lock, and then executes sk_diag_dump()
after releasing the lock. It aims to reduce the lock hold time and tracks
resumption using a referenced cursor.

Link: https://lore.kernel.org/all/cover.1785307984.git.zihanx@nebusec.ai/

> diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
> index 136c2d05c0eeb..37b33ea5d79de 100644
> --- a/net/mptcp/mptcp_diag.c
> +++ b/net/mptcp/mptcp_diag.c
[ ... ]
> @@ -84,64 +98,102 @@ static void mptcp_diag_dump_listeners(struct sk_buff=
 *skb, struct netlink_callba
>  	hinfo =3D net->ipv4.tcp_death_row.hashinfo;
> =20
>  	for (i =3D diag_ctx->l_slot; i <=3D hinfo->lhash2_mask; i++) {
> +		struct sock *tmp, *sk, *sk_arr[MPTCP_DIAG_BULK_SZ];
>  		struct inet_listen_hashbucket *ilb;
> +		int num_arr[MPTCP_DIAG_BULK_SZ];
>  		struct hlist_nulls_node *node;
[ ... ]
> +		for (idx =3D 0; idx < accum; idx++) {
> +			const struct mptcp_subflow_context *ctx;
> +			const struct tcp_ulp_ops *ulp_ops;
> +			struct inet_sock *inet;
> +
> +			sk =3D sk_arr[idx];
> +			rcu_read_lock();
> +			ctx =3D rcu_dereference(inet_csk(sk)->icsk_ulp_data);
> +			ulp_ops =3D READ_ONCE(inet_csk(sk)->icsk_ulp_ops);
> +			inet =3D inet_sk(sk);
> +			tmp =3D ctx ? ctx->conn : NULL;

[Severity: High]
Can dereferencing `ctx->conn` here before verifying the ULP protocol name=20
lead to an out-of-bounds read?=20

If another protocol (like TLS or SMC) attaches a smaller ULP context to a
TCP listener, `ctx` would point to that smaller structure, and reading
`ctx->conn` would access memory past the end of the ULP object. Should the
ULP type be checked before accessing `ctx->conn`?

> +			if (!ctx || !ulp_ops || strcmp(ulp_ops->name, "mptcp") ||
> +			    !tmp || !net_eq(sock_net(tmp), net) ||
> +			    (r->sdiag_family !=3D AF_UNSPEC &&
> +			     tmp->sk_family !=3D r->sdiag_family) ||
> +			    (r->id.idiag_sport !=3D inet->inet_sport &&
> +			     r->id.idiag_sport) ||
> +			    !refcount_inc_not_zero(&tmp->sk_refcnt)) {
> +				rcu_read_unlock();
> +				goto processed_listener_sk;
> +			}
> +			rcu_read_unlock();

[Severity: High]
Since sockets are allocated with SLAB_TYPESAFE_BY_RCU, and the listener hash
bucket lock has been dropped at this point, is it possible for the `tmp`
socket to be freed and reallocated as an unrelated socket between finding it
and successfully incrementing the refcount?=20

Does the code need to re-check `rcu_dereference(inet_csk(sk)->icsk_ulp_data=
)`
against `ctx` after taking the refcount to ensure the object was not
reallocated during the lockless window?

> +			if (ret >=3D 0) {
> +				ret =3D sk_diag_dump(tmp, skb, cb, r, net_admin);
> +				if (ret < 0)
> +					num =3D num_arr[idx];
> +			}
> +			sock_put(tmp);
> +processed_listener_sk:
> +			if (ret >=3D 0)
> +				mptcp_diag_save_cursor(cb_data, i, sk);
> +			sock_put(sk);
> +		}
> +
> +		if (ret < 0) {
> +			diag_ctx->l_slot =3D i;
> +			diag_ctx->l_num =3D num;
> +			return;
> +		}

[Severity: High]
`diag_ctx->l_num` tracks the absolute position in the bucket, but `num` was
reset to 0 at the start of `resume_listen_walk`.=20

If the dump fails (e.g. skb is full), doesn't saving this batch-relative `n=
um`
into `diag_ctx->l_num` corrupt the absolute progress state? Because it save=
s a=20
small relative number, if the cursor is invalidated later, the dump would f=
all=20
back to skipping elements from the start, causing massive duplicate dumps o=
r=20
infinite loops.

> +
> +		cond_resched();
> +
> +		if (accum =3D=3D MPTCP_DIAG_BULK_SZ) {
> +			diag_ctx->l_num =3D 0;
> +			goto resume_listen_walk;
> +		}

[Severity: High]
Similarly, on a successful batch, `diag_ctx->l_num` is explicitly set to 0.
Does this intentionally destroy the absolute index between batches?=20

If the cursor gets lost later, this would guarantee a total rewind to the=20
beginning of the bucket.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788248601.gi=
t.zihanx@nebusec.ai?part=3D2
