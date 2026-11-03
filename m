Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698740;
	b=atMLAMsIYi2q94a18r49L4lgauQA9GXDecQPGioMa4KYrfr+B24aHOUkzAQpIONmPQVr
	 mecS3146Bh5pvsuid2a1UlPVdI9aL7XX9PdVlK9tOkd38jHdE6+TM8SMHxWd2pcxgfcj0
	 iI5FiQYcXRzg5GS4rSYy4h06fqeSkrNVjNRS6GuiVLYK4qRMSa+OpNqR848GIniyI2L7d
	 Ua3oHf75ljTEdOcR8qne9x3DkdkLbXy3eJSlpN1SRd+JzrglU4B7AdsEif4qS0pHnFDCg
	 aNKxWYWVuGpZb+5ov7QhIC7IrMj1QjxbqFz381UP4OXG6Bu66fuE67FVDGEuuAQhuUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698740;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=J1saGF+t4DmCqPxxObSzfNXMQ+QOGR9HqI7h1cCzbtA=;
	b=KSYez2qPzyw7rECpxPdGuHQFazmvqDX69M7I/wzbgthZtih5hQx8OjcGChe1OPkSr3BR
	 hUIRwr/KwmRT90ySo//p0f4Pzoe63wA3e8JDkQgPYawqSGwEf68CzlVq93E76PgcH3mFm
	 tBGjn4HH+8OllvOgoSwP1cxA2eudvrKSJealgX6B0jnOtvk95qyNcASuiLGRzBstIBchH
	 sftGTXfQKvPjgfpQY6KtnyFyytHfJbL8XzoOn+G3NLTlGz0yU6AgNW6LvD/NI9w8CQVUz
	 +EIb7mhdsQEsUmVSkN/rOHNSQOe58WNTKii98DGML6YMF+5/jaJoi0Go5KC8fs3FwMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H8B2Df7Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C506F606A32E
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 09:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H8B2Df7Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4391F00919;
	Tue,  3 Nov 2026 09:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793698739;
	bh=J1saGF+t4DmCqPxxObSzfNXMQ+QOGR9HqI7h1cCzbtA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=H8B2Df7ZAzgfvdkzYnwok4pGRHY3h3+4nz82akGGNmjdrR8u5makgmBnzeBXp6RAR
	 USpukv8xoD5pcIYrW9sXvCX353/lS0glHH5lggGtNeJWtuK5EoGO5cXasYIKPqtniP
	 hFWtqh5We6LdIaOoLJW46cp4DbSuu+qTPxaD1RMO06pT0ZetzDSY5v9C7XLp9cGHaM
	 0qtBht3qnfmho9rYkKfnpQT2UogOMGgU1JqDX5wSkHK4m+22QZC4GBoAfitOSWKfV5
	 QDNQrMJVS/wXZxQlcVLT3tCClgzZ0pEIjQATaUIUDRqXshZhStawC19EyvY+o+QdIq
	 9SRLoH0HnwJeQ==
Message-ID: <sashiko-outbox-194959@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v20 3/6] mptcp: fix TFO map_seq sign
 extension in fastopen
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <6cded4388add37e9314abc3199507bec457000f6.1793695518.git.tanggeliang@kylinos.cn>
References: <cover.1793695518.git.tanggeliang@kylinos.cn>
 <6cded4388add37e9314abc3199507bec457000f6.1793695518.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 09:38:58 +0000
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
- [Medium] mptcp: inaccurate commit message on before64()/after64() and OoO=
 queue
--

commit c0adf4769c9ae204c304e167fe42012e5a15d3c6
Author: Geliang Tang <geliang@kernel.org>

mptcp: fix TFO map_seq sign extension in fastopen

This commit casts skb->len to u64 before negating it when initializing the
TFO skb's dummy map_seq in mptcp_fastopen_subflow_synack_set_params(), so
that it is properly sign-extended in 64-bit arithmetic.

>     mptcp: fix TFO map_seq sign extension in fastopen
>    =20
>     In mptcp_fastopen_subflow_synack_set_params(), the TFO skb's map_seq =
is
>     set to -skb->len to represent data before the IASN.
>    =20
>     Since skb->len is u32, the negation -skb->len is computed in u32
>     arithmetic, producing a large positive value (e.g., -1420 becomes
>     4294965876). When assigned to map_seq (u64), this value is zero-exten=
ded
>     rather than sign-extended.
>    =20
>     This causes incorrect behavior in sequence number comparisons through=
out
>     the code. Functions like after64() and before64() may misorder TFO sk=
bs,
>     and the out-of-order queue handling may misclassify TFO data.
>    =20
>     Fix by casting to u64 before negation: -(u64)skb->len. This ensures
>     proper 64-bit two's complement representation and correct semantics f=
or
>     all sequence number operations.
>    =20
>     Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Medium]
Is the commit message description of the impact on after64(), before64(), a=
nd
the out-of-order queue accurate?

In mptcp_fastopen_subflow_synack_set_params() in net/mptcp/fastopen.c, the
TFO skb is queued directly to the tail of the in-order receive queue:

	MPTCP_SKB_CB(skb)->map_seq =3D -(u64)skb->len;
	MPTCP_SKB_CB(skb)->end_seq =3D 0;
	MPTCP_SKB_CB(skb)->offset =3D 0;
	...
	__skb_queue_tail(&sk->sk_receive_queue, skb);

Because it goes directly onto sk->sk_receive_queue, it never passes through
__mptcp_move_skb(), mptcp_data_queue_ofo(), or msk->out_of_order_queue, and
its dummy map_seq is not compared with before64() or after64(). When
subsequent skbs arrive in __mptcp_move_skb(), __mptcp_sync_rcv_sequence()
updates the TFO skb's dummy map_seq and end_seq using msk->tfo_iasn before
any comparison or coalescing takes place, and __mptcp_try_coalesce() checks
MPTCP_SKB_CB(to)->end_seq rather than map_seq.

Instead, the missing sign extension affects mptcp_inq_hint() in
net/mptcp/protocol.c before the 3rd ACK arrives (while msk->ack_seq is 0):

	skb =3D skb_peek(&sk->sk_receive_queue);
	if (skb) {
		u64 hint_val =3D READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;

		if (hint_val >=3D INT_MAX)
			return INT_MAX;

		return (unsigned int)hint_val;
	}

Without the cast to u64, 0ULL - MPTCP_SKB_CB(skb)->map_seq underflows and
clamps to INT_MAX for SIOCINQ, TCP_CM_INQ, and mptcp_rcv_space_adjust(). It
is also needed by the subsequent commit 698eb6e05455 ("mptcp: remove CB
offset field"), which initializes msk->copied_seq from
MPTCP_SKB_CB(skb)->map_seq and relies on 64-bit two's complement wrapping
when adding msk->tfo_iasn.

Could the commit message be updated to describe the actual callers affected
by the unextended map_seq value?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793695518.gi=
t.tanggeliang@kylinos.cn?part=3D3
