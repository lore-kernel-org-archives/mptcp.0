Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794816633;
	b=nkxls9rAcBvbYnsxoPjCMLGzttF3I5RVvLdqaFSGH5MHjFSBv4/HLaR8HG9/pScRFMD3
	 wza2/Fvv3Fr0npPbDu6y08gZkvOlLMO6eMna3e1OvIQu7F5Wmc5Q+Q//PfWGFx37n6Y3Z
	 7+gbWt6VI6mfJb5WPs+8mCmoXT87Vd2G0bFkhiDcfa0OD3Hz4NiiWfkECgFUyxAx/eX0D
	 inK9TY+MYiJKzLukvs21wBScs8qpoBt89cM3/OAHDf4ywComNS3xy6VEX962NN23kAtYs
	 rKHwYw6f560DcvB6eBpC5yh71tqGelfuJxbM37qLwdULXZlfkttgWUWAmGF7eXWFYGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816633;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=He40pdxWCb+Ex/IOU0A046YGCiHERZkkcjQIIVihPnc=;
	b=rualeEDoRfCv6P6QBnIL+hHfZy+U6NBkVgrMtvF24xn44phF/URTjYNKPAYlUWwD5kU2
	 WuW6TJi79iwVaqXrBXEGFFmd+tpjZpkQ5iw4i37oNucKJYEt57gVq732ifEm2K7MS3oVZ
	 RTNWsXszkz0Qv/N0OL3oXhFoq7dFWk5rKJxewWHXojI1LTBFgNFyqWIFKL0yBW3RprXXq
	 y/E1i4oF5XX3ycNGjjbTSenzixkYZEu00yZmlXHouxevP+0P0t25YzJAwL31J4Uv7wlsn
	 JCF+fgWspfMFlNGQdT6rGevQjClNwyKaZaGv71jDoAngV4amxaig7U205FgEdckvigQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YF38xrsK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2A6606A329
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 08:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YF38xrsK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9F61F000C4;
	Mon, 16 Nov 2026 08:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794816633;
	bh=He40pdxWCb+Ex/IOU0A046YGCiHERZkkcjQIIVihPnc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=YF38xrsKHgCzgtoTwuurozRVKtmA/sCn0ArWwMjOynQn1tqiHZkquhTbJyh4OPP0c
	 HGRl3t656/gF5G0Pe1g2P9DpJZo2WvnV1erbT2e4n2F780MCpNco/Z7oCp4xnTBiyO
	 DcRKXyACE5cLOn6nw6vL6gKLG5fd90P1imXV5AhGefQP5qUQw7u5bMVG/fOPWb0gj9
	 e8fz1xl79aLgdn1PcPcJFE85Z7sG74K53tMpEIMvdP7mMLM7t+Yzl7z68eggaJOW9C
	 NWki/smZERi1s7faJ6SyuHap4djW7X5bo9f6OiZWljszRadLWL659sP9L8Mu4nPcID
	 u/gY9exQ4ZFEQ==
Message-ID: <sashiko-outbox-216512@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v28 10/11] mptcp: sync mptcp skb cb layout
 with tcp one
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <af0a3423548713de827ea0597b8b637fde99e3b2.1794810809.git.tanggeliang@kylinos.cn>
References: <cover.1794810809.git.tanggeliang@kylinos.cn>
 <af0a3423548713de827ea0597b8b637fde99e3b2.1794810809.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 08:10:32 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] mptcp: copied_seq offset underflow in recv path for OoO data
  after DATA_FIN
--

commit 4e18ccd1c70ef371066d9f0f5c43875b2c871587
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: sync mptcp skb cb layout with tcp one

This commit aligns struct mptcp_skb_cb with struct tcp_skb_cb by converting
map_seq and end_seq to u32, adding map_seq64 for the 64-bit DSN, and using
32-bit sequence comparisons and offset calculations in the receive path.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 78ca580c6d9c5..50ae8cdec8a4a 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -2231,7 +2233,7 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, st=
ruct msghdr *msg,
>  	int copied =3D 0;
> =20
>  	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
> -		u64 offset =3D *seq - MPTCP_SKB_CB(skb)->map_seq;
> +		u32 offset =3D (u32)(*seq) - MPTCP_SKB_CB(skb)->map_seq;
>  		u32 data_len =3D skb->len - offset;
>  		u32 count;
>  		int err;
> @@ -4654,7 +4656,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *=
sk, u32 *off)
>  		mptcp_move_skbs(sk);
> =20
>  	while ((skb =3D skb_peek(&sk->sk_receive_queue)) !=3D NULL) {
> -		offset =3D msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
> +		offset =3D (u32)msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
>  		if (offset < skb->len) {
>  			*off =3D offset;
>  			return skb;

[Severity: Medium]
Can offset underflow in __mptcp_recvmsg_mskq() and mptcp_recv_skb() when an
out-of-order segment at or after DATA_FIN is queued before the DATA_FIN
arrives?

Commit "mptcp: drop data after DATA_FIN before skb init" checks
mptcp_seq_after_data_fin() when dequeuing from the subflow, which only acts
if msk->rcv_data_fin or RCV_SHUTDOWN is already set.  If a peer sends an
out-of-order segment with dsn =3D=3D rcv_data_fin_seq + 1 before sending the
DATA_FIN, the segment is placed into msk->out_of_order_queue or
msk->backlog_list.  Once the DATA_FIN arrives and pre-DATA_FIN data is
received, mptcp_check_data_fin() advances msk->ack_seq to
rcv_data_fin_seq + 1 while msk->copied_seq reaches at most rcv_data_fin_seq.
__mptcp_ofo_queue() or __mptcp_move_skb() then moves that queued segment in=
to
sk->sk_receive_queue and adds its length to msk->bytes_received.

When offset =3D=3D 0 in mptcp_init_skb(), MPTCP_SKB_CB(skb)->map_seq is
(u32)(rcv_data_fin_seq + 1), so (u32)copied_seq - map_seq underflows to
0xffffffff >=3D skb->len.  Both receive helpers then free the skb via
mptcp_eat_recv_skb() without advancing msk->bytes_consumed, leaving
mptcp_data_avail(msk) non-zero after EOF and causing __mptcp_close() to send
MP_FASTCLOSE.  If the subflow skb had a non-zero offset in mptcp_init_skb()
so that map_seq <=3D (u32)rcv_data_fin_seq, the computed offset is 1 byte t=
oo
small, copying a discarded prefix byte to userspace and underflowing
mptcp_data_avail(msk).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794810809.gi=
t.tanggeliang@kylinos.cn?part=3D10
