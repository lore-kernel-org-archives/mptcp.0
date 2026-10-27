Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793083905;
	b=xiapn3+Soe+DIAmW+VP7z1ccqXkaJzPobAPcCqaIgLcj1qxjLZtKSPKG7j8afGVjaVi7
	 hmjdpY/nRUXC8z5TNjewqTrUSzhFkGQhkUQpDZlpQtBWn+5qsUj/GLJtWh/n+kUW+9z+9
	 T4l9hPUCkeuedKJ7bvCNLbQm1HNLIMEXIoyDRDmUhLV4q2OFFAMER/ezE7wXJIr+g+P2T
	 auT6+fTGHo9Y4k3G+yYdHxe+i2j7jqfR51Gam1ZydFN4WtrbVJ+dGiFvTEyn+DGMBZSHE
	 Ba/pYWQHlIwYdOvayhvMQprKPnGISas6/jtV90UIIiBdeq8SOgInPDo2p3avnEOhQYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793083905;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FNKNdgJvpmjOn0fSS0iYOLuJJ1bPKnstXe1oGICBBgY=;
	b=hUSjmEQb/pT/Zbbxs+vqyhzUlbJcCUyUS10cRro8/4FUckbQbRdQ36CgGUkGu2MHCOlD
	 lGY88sZV8f52/An0wt45+pzH1uLrNe0ajOC9YAy1cbz9R4xII7GSpnkFr55I6eC87Yvuk
	 BEUnoM4+bC2AtodxRYvduWo3Z5NqBcfvHKfXasg5w+ikVoTWZO+D6fpFEIa6zjTTA7nhV
	 jsRsCdXd3rbP6H0Ju5kEejdx1rpfY0oFgjmq6Ceza2fslOYf0FBID38ZKaaDjVO10O20Z
	 2KB6bs3tLe5TNNOC7/NapWk7M+01+MEZmHFaH18GlX9/oz7dRBT9GxZulKZghijopkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OAPaAjNg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738C8606A31E
	for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 06:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OAPaAjNg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D94DB1F01825;
	Tue, 27 Oct 2026 06:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793083905;
	bh=FNKNdgJvpmjOn0fSS0iYOLuJJ1bPKnstXe1oGICBBgY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=OAPaAjNgY4H9bWcHv7Qrn+Nc9AUysJGu4koEgnbLkz0DTr4UdDhFuDlY+I3xby0hX
	 xraGDHgcXFm9CYiiOFwRl0R6xvOeeRC4QM3obzT2eFNYva0yILHr6dnYK4Pn8gOilc
	 2j2AVbdJiOX3mUO/tMWUgKWyyohnbVV2YDklStLfMRsZjNkEV9AcChIgd+0hSWD94A
	 vKuXRKKf2CEIYpX2Jxts5b+tIc6eaREoTnpkGDpOY5AWsZ+XvoIa8Aihmb+FK5QK/a
	 iXyZjyBrGTk1HXxTqHWyifR/Nq4TgjiNT1550+FuMBZv+l9AKTKA3D2NxYbGfXR+1u
	 +jYWOSwuqwchg==
Message-ID: <sashiko-outbox-186170@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC net-next v10] mptcp: normalize seq numbers reported in
 mptcp_info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kalpan Jani" <kalpan.jani@mpiricsoftware.com>, mptcp@lists.linux.dev
In-Reply-To: <20261027062750.2095515-1-kalpan.jani@mpiricsoftware.com>
References: <20261027062750.2095515-1-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 06:51:44 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] mptcp: stale remote_idsn after mptcp_disconnect() corrupts subfl=
ow map_seq
- [Medium] mptcp: torn local_idsn and snd_una snapshot in mptcp_diag_fill_i=
nfo()
--

commit 7fad37bbb6af298d7d24854d3ee0023c92539f7c
Author: Kalpan Jani <kalpan.jani@mpiricsoftware.com>

mptcp: normalize seq numbers reported in mptcp_info

This patch normalizes the sequence number fields in mptcp_info and
MPTCP_SUBFLOW_ATTR_MAP_SEQ relative to the initial data sequence numbers. It
also passes the requester capability state to idiag_get_info callbacks so t=
hat
sequence numbers in INET_DIAG_INFO are zeroed for unprivileged callers.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/445

[ ... ]

> diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
> index 70cf9ebce8338..590cdee419ef9 100644
> --- a/net/mptcp/diag.c
> +++ b/net/mptcp/diag.c
> @@ -16,6 +16,7 @@ static int subflow_get_info(struct sock *sk, struct sk_=
buff *skb, bool net_admin
>  {
>  	struct mptcp_subflow_context *sf;
>  	struct nlattr *start;
> +	u64 map_seq;
>  	u32 flags =3D 0;
>  	bool slow;
>  	int err;
> @@ -35,6 +36,11 @@ static int subflow_get_info(struct sock *sk, struct sk=
_buff *skb, bool net_admin
>  		goto nla_failure;
>  	}
> =20
> +	map_seq =3D 0;
> +	if (sf->conn && sf->map_seq)
> +		map_seq =3D sf->map_seq -
> +			  READ_ONCE(mptcp_sk(sf->conn)->remote_idsn);

[Severity: Medium]
Can this underflow map_seq if a connected MPTCP socket is disconnected via
mptcp_disconnect() and then reconnected with a fallback to TCP?

When an initial connection completes the MP_CAPABLE handshake,
subflow_set_remote_key() sets msk->remote_idsn and msk->can_ack =3D true. I=
f the
socket is subsequently disconnected, mptcp_disconnect() resets msk->can_ack,
msk->ack_seq, and the byte counters, while __mptcp_subflow_disconnect() res=
ets
the subflow context (zeroing subflow->iasn and subflow->map_seq), but
msk->remote_idsn (as well as msk->local_idsn, msk->write_seq, msk->snd_nxt,
and msk->snd_una) is left holding the previous connection's values:

net/mptcp/protocol.c:mptcp_disconnect() {
	...
	WRITE_ONCE(msk->can_ack, false);
	...
	/* for fallback's sake */
	WRITE_ONCE(msk->ack_seq, 0);
	atomic64_set(&msk->rcv_wnd_sent, 0);
}

If the socket is then reconnected via mptcp_connect() and falls back to pla=
in
TCP before receiving a peer key (for example via mptcp_early_fallback() or
when the SYN-ACK lacks MP_CAPABLE in subflow_finish_connect()),
subflow_set_remote_key() is not called. When data arrives on the fallback
connection, subflow_check_data_avail() computes subflow->map_seq relative to
subflow->iasn =3D=3D 0.

In mptcp_diag_fill_info(), reading msk->remote_idsn is guarded by
READ_ONCE(msk->can_ack), so mptcpi_rcv_nxt uses remote_idsn =3D=3D 0. Howev=
er,
subflow_get_info() does not check can_ack and subtracts the stale
msk->remote_idsn of the previous connection from the 0-based sf->map_seq.

Should mptcp_disconnect() reset the sequence and IDSN fields, and should
subflow_get_info() also gate remote_idsn on READ_ONCE(msk->can_ack)?

[ ... ]

> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 922f6ae5c80cb..b20263b4cd55c 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -1047,6 +1047,7 @@ static int mptcp_getsockopt_first_sf_only(struct mp=
tcp_sock *msk, int level, int
>  void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *inf=
o)
>  {
>  	struct sock *sk =3D (struct sock *)msk;
> +	u64 local_idsn =3D 0, remote_idsn =3D 0;
>  	u32 flags =3D 0;
>  	bool slow;
>  	u32 now;
> @@ -1084,9 +1085,11 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, =
struct mptcp_info *info)
>  	info->mptcpi_flags =3D flags;
> =20
>  	slow =3D lock_sock_fast(sk);
> +	local_idsn =3D READ_ONCE(msk->local_idsn);
> +
>  	info->mptcpi_csum_enabled =3D READ_ONCE(msk->csum_enabled);
>  	info->mptcpi_token =3D msk->token;
> -	info->mptcpi_write_seq =3D msk->write_seq;
> +	info->mptcpi_write_seq =3D msk->write_seq - local_idsn;
>  	info->mptcpi_retransmits =3D inet_csk(sk)->icsk_retransmits;
>  	info->mptcpi_bytes_sent =3D msk->bytes_sent;
>  	info->mptcpi_bytes_received =3D msk->bytes_received;
> @@ -1099,17 +1102,20 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk,=
 struct mptcp_info *info)
>  	unlock_sock_fast(sk, slow);
> =20
>  	mptcp_data_lock(sk);
> +	if (READ_ONCE(msk->can_ack))
> +		remote_idsn =3D READ_ONCE(msk->remote_idsn);
>  	info->mptcpi_last_ack_recv =3D jiffies_to_msecs(now - msk->last_ack_rec=
v);
> -	info->mptcpi_snd_una =3D msk->snd_una;
> -	info->mptcpi_rcv_nxt =3D msk->ack_seq;
> +	info->mptcpi_snd_una =3D msk->snd_una - local_idsn;
> +	info->mptcpi_rcv_nxt =3D msk->ack_seq - remote_idsn;

[Severity: Medium]
Could mptcp_diag_fill_info() observe a torn pair of local_idsn and
msk->snd_una if it races with mptcp_connect()?

In mptcp_getsockopt(), the socket lock is released before calling
mptcp_getsockopt_sol_mptcp() -> mptcp_getsockopt_info() ->
mptcp_diag_fill_info(). In mptcp_diag_fill_info(), local_idsn is sampled un=
der
lock_sock_fast(sk) and then the socket lock is released via
unlock_sock_fast(sk, slow) before acquiring mptcp_data_lock(sk).

If another thread concurrently calls connect() -> inet_stream_connect() ->
mptcp_connect() right after unlock_sock_fast(sk, slow), mptcp_connect()
initializes msk->local_idsn and msk->snd_una under lock_sock(sk) without
holding mptcp_data_lock(sk):

net/mptcp/protocol.c:mptcp_connect() {
	...
	WRITE_ONCE(msk->local_idsn, subflow->idsn);
	WRITE_ONCE(msk->write_seq, subflow->idsn);
	WRITE_ONCE(msk->snd_nxt, subflow->idsn);
	WRITE_ONCE(msk->snd_una, subflow->idsn);
}

When mptcp_diag_fill_info() then acquires mptcp_data_lock(sk), msk->snd_una
will be subflow->idsn while the previously sampled local_idsn is still 0,
causing info->mptcpi_snd_una to report the raw unnormalized subflow->idsn to
userspace.

Would it be safer to re-read READ_ONCE(msk->local_idsn) or sample msk->snd_=
una
using READ_ONCE() within the same critical section?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027062750.2095=
515-1-kalpan.jani@mpiricsoftware.com?part=3D1
