Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792721989;
	b=y0Cm3k2JBCZBj6JXXpFSNc6MBVnht/WyA7pAxCVRw/JfNJTNo15UPZTWSKUCBidkzh0/
	 1kL+ODNuct7rqwJsczVI+cATCWGZ1tVPhIk8Xw3bAicLInCFMIHNSD6+5BQYSTxcVr6tD
	 0kM3lm2JI7iX2+EHLSZX8aKWooOjf6dv5y0VpAHK/lU/RhdLPdjtYEDv8JnsP46xfRUE7
	 2P4To9QDqYm7+c84+Z/AasjcIvD4ggVs9896j3HKtR1AgOr4a2aoTUJ0W6YEIP36dtPjZ
	 KRXuhhcCVgA5TirAs4uiotPhFpK6CqKG/jbDqGVk1Svee6JXnWxvJ/K5+URr4nNy0Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792721989;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eLcIysFWWRro08dYgZDA1uIs23XpO49qemP6a4DGuu0=;
	b=Kre0EHiWdr6qgGyI1Od51Z85Eyxs1hrqJ19p7vY8w5v1p0bwK0TGkvVhRr7v19+LTSp0
	 EahDUF0P+ApzFT+3KWX5QdGX293Fj8p45VvcgGtBXjKSIP/TLYfuaNogq1CcKcjBl1wTF
	 U55Xm8cxuAGlyUWTWDY1zYi4489+avxK43iunBGYI8zLxCMCUFdsgsrdhUrUqSmbl14xm
	 QgeC4FtcG6ZearP+1jx8A7xs7rd7ejSPu8CxDguUptREa2VS3hBjQ89SMygcub3x9n8EO
	 CkjZBYpcqjItFrjpdkhVGP4tqpj35eYtjoeDEbeW4IxZks4GD7+8HdcN1qJ1jiypIgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FrrG8Z1T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F38606A319
	for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 02:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FrrG8Z1T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D881F01828;
	Fri, 23 Oct 2026 02:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792721988;
	bh=eLcIysFWWRro08dYgZDA1uIs23XpO49qemP6a4DGuu0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=FrrG8Z1TUG3II3ngHRo6vvuyKn7fn37Uxekmjj4iQFfVMQDhtvaysVl59nLsXX46N
	 MWVVLsIdyCFl4uCs0WkE3yq9PO8RfngpMpywasOyJJM7IyEKtltl7XlxuM2mRRND5g
	 bw//op6ZNJmGHfcTr80XImhmE5cy5tP17e1zusAPj8wpWnTxPJZEe+0CHw1V6BMyUm
	 TdhIM5nGs11oF2ARl8zpDCgxyXywgUbT51qsQmdPPv6UNXGSFLk3VrrmTVEmjZF0E4
	 9BOWutyW57l/koUpBZSiQJvsh2Ll8rwqtsbacO4whrGdYoct/7emEMQ0+70V1Ny4KV
	 kMbJ+s2i/uUvQ==
Message-ID: <sashiko-outbox-182223@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v15 07/11] mptcp: implement peek_len for
 proto_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <7f915090708935804fe0b5a61b50e24fcd232a40.1792718041.git.tanggeliang@kylinos.cn>
References: <cover.1792718041.git.tanggeliang@kylinos.cn>
 <7f915090708935804fe0b5a61b50e24fcd232a40.1792718041.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 02:19:48 +0000
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
- [High] mptcp: race and TFO byte loss on MPTCP_SYNC_SEQ in mptcp_inq()
- [High] mptcp: mptcp_inq() clamps wrapped u64 underflow to INT_MAX instead=
 of 0
--

commit 4690b9f63adb950374a40e56669d9dcdd8ff2844
Author: Geliang Tang <geliang@kernel.org>

mptcp: implement peek_len for proto_ops

This commit adds mptcp_inq() and mptcp_peek_len() to report the number of
readable bytes at the MPTCP socket level via proto_ops.peek_len for both IP=
v4
and IPv6 MPTCP stream operations.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 7b0005d47bead..ad11a96b83eba 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -4848,6 +4848,43 @@ static ssize_t mptcp_splice_read(struct socket *so=
ck, loff_t *ppos,
>  	return ret;
>  }
> =20
> +static int mptcp_inq(struct sock *sk)
> +{
> +	const struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	int answ;
> +
> +	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV)) {
> +		answ =3D 0;
> +	} else if (test_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
> +		answ =3D 0;
> +	} else {
> +		bool sock_done =3D sock_flag(sk, SOCK_DONE);
> +		u64 hint_val;
> +
> +		/* Ensure we see updated ack_seq and copied_seq after
> +		 * checking MPTCP_SYNC_SEQ flag.
> +		 */
> +		smp_rmb();

[Severity: High]
Could the ordering of the MPTCP_SYNC_SEQ check and the sequence number reads
here race with subflow_set_remote_key() and mptcp_release_cb(), and also hi=
de
queued TFO data?

On a passive MPTCP connection created before the third ACK arrives (such as=
 a
passive TFO socket initialized via mptcp_sk_clone_init() and
mptcp_fastopen_subflow_synack_set_params()), mptcp_sk_clone_init() sets
sk->sk_state to TCP_ESTABLISHED while msk->ack_seq is 0 and msk->copied_seq
is -(u64)skb->len (or 0).

When the third ACK arrives in BH context while a reader holds the socket
lock, subflow_set_remote_key() writes msk->ack_seq before setting
MPTCP_SYNC_SEQ:

net/mptcp/subflow.c:subflow_set_remote_key() {
    ...
	WRITE_ONCE(msk->ack_seq, subflow->iasn);
	WRITE_ONCE(msk->can_ack, true);
	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);

	if (!sock_owned_by_user(sk)) {
		/* User space could have already read partially the TFO skb */
		msk->copied_seq +=3D subflow->iasn;
		__mptcp_sync_rcv_sequence(sk);
	} else {
		/* Ensure ack_seq is visible before setting the flag */
		smp_wmb();
		set_bit(MPTCP_SYNC_SEQ, &msk->cb_flags);
	}
    ...
}

And when the flag is cleared in mptcp_release_cb() (or __mptcp_move_skb()),
MPTCP_SYNC_SEQ is cleared before msk->copied_seq is updated:

net/mptcp/protocol.c:mptcp_release_cb() {
    ...
		if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
			/* Ensure we see the updated ack_seq after seeing
			 * the flag
			 */
			smp_rmb();
			msk->copied_seq +=3D mptcp_iasn(msk);
			__mptcp_sync_rcv_sequence(sk);
		}
    ...
}

Because mptcp_inq() tests MPTCP_SYNC_SEQ before reading msk->ack_seq and
msk->copied_seq, can it observe MPTCP_SYNC_SEQ =3D=3D 0 and then read the n=
ew
msk->ack_seq (subflow->iasn) alongside the pre-IASN msk->copied_seq, causing
ack_seq - copied_seq to evaluate to subflow->iasn and clamp to INT_MAX?

In addition, when MPTCP_SYNC_SEQ is set on a passive TFO socket, returning 0
unconditionally ignores unread TFO payload already queued in
sk->sk_receive_queue, whereas mptcp_inq_hint() inspects the receive queue:

net/mptcp/protocol.c:mptcp_inq_hint() {
    ...
	if (test_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
		skb =3D skb_peek(&sk->sk_receive_queue);
		return skb ? skb->len : 0;
	}
    ...
}

> +
> +		hint_val =3D READ_ONCE(msk->ack_seq) - READ_ONCE(msk->copied_seq);
> +		if (hint_val >=3D INT_MAX)
> +			hint_val =3D INT_MAX;
> +
> +		answ =3D (unsigned int)hint_val;

[Severity: High]
What happens on 32-bit systems when a torn read of msk->ack_seq or
msk->copied_seq causes the unsigned subtraction to wrap below zero?

The commit message notes that on 32-bit systems a torn read can produce a
wrapped subtraction close to 2^64 which is caught by the INT_MAX clamp.
However, since hint_val is an unsigned u64, a wrapped negative difference
(near U64_MAX) satisfies hint_val >=3D INT_MAX and gets clamped to INT_MAX
rather than 0.

Would clamping a wrapped underflow to INT_MAX cause mptcp_peek_len() to
report 2 GiB of readable bytes when no data is queued?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792718041.gi=
t.tanggeliang@kylinos.cn?part=3D7
