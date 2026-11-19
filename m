Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795067024;
	b=jqJBTu6l73I66T9o+7YNtwgiw5DWBWHcURCTmaW/N90WllP4vL/essd8LexuiETd7BKx
	 Yr1yHeu3ekNJlMpAmhSI8AG+yTk9VunNhiTxnUuxoRRxppAz2UefjIg/zdhVKdm2az2pJ
	 /9GXkHzYQ/8XNm5E2HmRdI9W+JZCMds3eweq7UJI3hr6seIYFjfw6QHOAUqVf9wu/wI2o
	 rFxwA8GjRKr5qOMA8tf/MskyJv1e0shkbZgS6GquZX7X8RIgD3MUvt6DA9hJY+oYOhcI1
	 S5nxyRi6ktu/o1wbYfxfib0KHHPyakAlpPTx/QnSIpvNsySXq020o7yUuV8tzE+MYZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795067024;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=H/n6y9iyAFHXeqiCgKnZQi+kQm0WsxG1iBrlNrOMy8w=;
	b=1/G42vOln2ScnDxk2N17zFauTOpIysE/9AQHBeZuXSxzBkRk0LxftBhDdpcWsduWu8Yo
	 BHsBRxJVQUBOhyZzqOIuahFIPbk+Ztykfoc05KVE9fJ8XO2HLKuxC0bQdNWcxNIy9GfgN
	 N1TQnpoFPIrF4JTZXsmojLhQTl8BlN9VIJKJeNMEAQ8VH+7+wYvXTtuX12NVdeKpz8GJj
	 mV+maQbh0amYjNR8ql+xn70YvaDZNQIgyzEqx4EIFiIPaJ8gCznGP2t/EUyNFOH9XtQ8N
	 TAwhAdHruQYmTTOah1fWzt9U7p3RTsfZqkIt3GIOyRT0Q15IAha+P5cTo8L2PjwI+aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WwKLsgyi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA473606A320
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 05:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WwKLsgyi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F9D1F000C4;
	Thu, 19 Nov 2026 05:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795067024;
	bh=H/n6y9iyAFHXeqiCgKnZQi+kQm0WsxG1iBrlNrOMy8w=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=WwKLsgyi0hYzPcJb5SnTJA1d7JeT4AiDcSRkCPOjaLMDyE1YJJqRd/xct6SlGhD3T
	 +k9+1G31FD4Ot7jjstJgMnKh+RcCzaElOG1WhL7v8bhDP7hC7AbSbQIkRxiZLGEfvW
	 mFTY2d2pnVAQLFDKd2Be/x/xCXjzRrxk4RAyFZcrVVfbQAMwgf7OdD+JawDxy6YfsN
	 gSI3ttxBYGkKB3F0Kjgvr6lCuAuKyVV7sP52uVNHAumKOx0UNGQHp6a6OQhzM1kxJY
	 TzIE39LMLzIOQBubTTtZtq6vOdnQN51pGh4qFPISoAjWWBUXe/NalfUgkmVtwKQaFZ
	 eejSVz4CkiM6A==
Message-ID: <sashiko-outbox-222496@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v29 7/8] mptcp: sync mptcp skb cb layout with
 tcp one
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <f53cc2e63e8ae9a8e1d1918b247cd65368ee4b8e.1795063943.git.tanggeliang@kylinos.cn>
References: <cover.1795063943.git.tanggeliang@kylinos.cn>
 <f53cc2e63e8ae9a8e1d1918b247cd65368ee4b8e.1795063943.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 05:43:44 +0000
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
- [Medium] mptcp: broken post-DATA_FIN skb handling in
  __mptcp_recvmsg_mskq() and mptcp_recv_skb()
--

commit 620e51c1f06b815c8d3a402589fa67b46d950125
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: sync mptcp skb cb layout with tcp one

This commit aligns struct mptcp_skb_cb with struct tcp_skb_cb by shrinking
map_seq and end_seq to u32, adding a 64-bit map_seq64 field, and switching
most receive-path sequence comparisons to 32-bit helpers.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 1ed232a4e8b4d..707a40850ada5 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
[ ... ]
> @@ -423,10 +424,11 @@ static void mptcp_init_skb(struct sock *ssk, struct=
 sk_buff *skb, int offset,
> =20
>  	/* the skb map_seq accounts for the skb offset:
>  	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
> -	 * value
> +	 * value; note that end seq number is only available in 32bits format.
>  	 */
> -	MPTCP_SKB_CB(skb)->map_seq =3D mptcp_subflow_get_mapped_dsn(subflow) -
> -				     offset;
> +	MPTCP_SKB_CB(skb)->map_seq64 =3D mptcp_subflow_get_mapped_dsn(subflow) -
> +				       offset;
> +	MPTCP_SKB_CB(skb)->map_seq =3D (u32)MPTCP_SKB_CB(skb)->map_seq64;
>  	MPTCP_SKB_CB(skb)->end_seq =3D MPTCP_SKB_CB(skb)->map_seq + copy_len;
>  	MPTCP_SKB_CB(skb)->flags =3D offset ? MPTCP_SKB_CB_F_OFFSET : 0;
>  	MPTCP_SKB_CB(skb)->has_rxtstamp =3D has_rxtstamp;
[ ... ]
> @@ -2212,11 +2214,11 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, =
struct msghdr *msg,
> =20
>  	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
>  		u32 data_len;
> -		u64 offset;
> +		u32 offset;
>  		u32 count;
>  		int err;
> =20
> -		if (unlikely(before64(*seq, MPTCP_SKB_CB(skb)->map_seq))) {
> +		if (unlikely(before64(*seq, MPTCP_SKB_CB(skb)->map_seq64))) {
>  			*seq =3D mptcp_end_dsn(skb);
>  			msk->bytes_consumed +=3D skb->len;
>  			if (!(flags & MSG_PEEK))
> @@ -2226,7 +2228,7 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, st=
ruct msghdr *msg,
>  			continue;
>  		}
> =20
> -		offset =3D *seq - MPTCP_SKB_CB(skb)->map_seq;
> +		offset =3D (u32)(*seq) - MPTCP_SKB_CB(skb)->map_seq;
>  		data_len =3D skb->len - offset;
> =20
>  		if (offset >=3D skb->len) {

[Severity: Medium]
Can testing before64(*seq, MPTCP_SKB_CB(skb)->map_seq64) in
__mptcp_recvmsg_mskq() and mptcp_recv_skb() fail to drop post-DATA_FIN
skbs and deliver garbage or post-FIN bytes to userspace?

When mptcp_check_data_fin() processes a DATA_FIN at rcv_data_fin_seq, it
advances msk->ack_seq to rcv_data_fin_seq + 1 while msk->copied_seq stops
at rcv_data_fin_seq.  __mptcp_move_skb() and __mptcp_ofo_queue() still
accept segments at dsn =3D=3D rcv_data_fin_seq + 1 into sk_receive_queue, a=
nd
the before64(*seq, map_seq64) branch is meant to discard them.

Because mptcp_init_skb() sets map_seq64 to dsn - offset, a post-DATA_FIN
segment with a non-zero subflow offset (offset >=3D 1) has
map_seq64 =3D=3D rcv_data_fin_seq + 1 - offset <=3D *seq.  before64(*seq,
map_seq64) is then false, and (u32)(*seq) - map_seq evaluates to
offset - 1 < skb->len.  __mptcp_recvmsg_mskq() and mptcp_recv_skb() copy
the discarded prefix byte plus copy_len post-DATA_FIN bytes to userspace
and add copy_len + 1 to msk->bytes_consumed (while msk->bytes_received was
only incremented by copy_len), underflowing mptcp_data_avail(msk).

Even when offset is 0, the discard branch sets *seq =3D mptcp_end_dsn(skb),
so a second post-DATA_FIN skb queued right after the first has
map_seq64 =3D=3D *seq and is delivered to userspace instead of being droppe=
d.
In __mptcp_recvmsg_mskq(), that branch also adds skb->len to
msk->bytes_consumed even when MSG_PEEK is set or when copy_len < skb->len.
Finally, if an out-of-order segment at rcv_data_fin_seq arrives before
DATA_FIN, __mptcp_ofo_queue() advances msk->ack_seq past rcv_data_fin_seq
before mptcp_pending_data_fin() runs, preventing DATA_FIN processing; and
if a post-DATA_FIN skb arrives after EOF has been read,
mptcp_data_avail(msk) becomes non-zero at close() and triggers
MP_FASTCLOSE.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795063943.gi=
t.tanggeliang@kylinos.cn?part=3D7
