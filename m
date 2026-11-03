Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723565;
	b=3FWQLE3veDpTe4e0oQmGbzRBuk7IM+HJpYaH2b14jJ40nL1zj77GrKQskMTLrtfVxdJo
	 b5K9WpF8XJXLqKN/5JAVN0nH/ak7B4MC/xw1XyYkObpPtcXKV0caLImDU4fPhGxIFtNDE
	 gwAY1xL3+Ch3kwYnFjk+6aNEdLJrDA5Gjg+uTe/JvOcIC58ofbS63jb38BAX7QtrWTAS4
	 0VeHm7wu2WjyHgyYvw7YLJXpZyxsrbRTFnSy0vTAdId7y5iwQjLj+ORN+LF/59Va6Ho5e
	 3lXSPsTDroqPQTgHQAO4pAqe+Y/pxN5aAkZqYWcjDocitncqaZeoO3eSWaBM4WEmNXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723565;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=bEvF2B6qdGR2i4DqszIUV2KunlhAROX/daEfQ+FRU/Y=;
	b=PxPBfLy1/Hha3W4QrGBWZRbSu9MRlMPiIP6nhbKrmklDxACz8J8B6rBqS9pRI6haIcr3
	 wm2q/oV3tMG53zcd3Q49XFrZYzlPmSPJdVgK7yEOCWmvH8EZAHi69Y5aVlLIHqp2VlFZN
	 PKgog+9poyQrM2rPl8pRnMpvVPxyGxAxicXQrZ3ODt+6VD/WY06yXkHJKNKFn5K7L410s
	 g6/V+9F2KAOiH2zMfmoZgnHVdIcHUOQJI8DFCpFpgm//qY1oOm026Ng3s7dTTnusLQoZ1
	 0nbB8R4uxxspz53HSddcGAOfZHijjKIj8MYgcMsgMiQw2k0k1AHgKoNRkxlH9YXBn6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eLM8Vuf+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74F0606A330
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 16:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eLM8Vuf+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A851F00A15;
	Tue,  3 Nov 2026 16:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793723564;
	bh=bEvF2B6qdGR2i4DqszIUV2KunlhAROX/daEfQ+FRU/Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eLM8Vuf+xdLsWGnhwnOKsSHPTqZa4GDFacLHXDlDvWM48B7d6sbtJHiOm/emMR6jw
	 jJYHm1KTrGvAbNhB/RRVu5P8S9Pt9XFyyZCuhaalzi+UkB9is1rsBqYr0LJNlKzxml
	 SC1VYaPp2SdOhuT1hzg71xRyi3LuEG2jlVYVLKqhszFzmQeaUhnagLDPvXMZIGAdnQ
	 ZzoOnf2xixcLf8r2k3ADdQaLcNNRITlAqJaUnSA9inx3+NSn4wroXb3xtZGbyThPru
	 CXpDy6Hn5AFbhTX45GsaLHojdB+r/yP0Y83WuYaXGoKugjhKEdmryfHdLIe06tcsJK
	 zYH7rNDHYfmqA==
Subject: Re: [PATCH mptcp-next v4 2/5] mptcp: implement peek_len for proto_ops
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Tue, 03 Nov 2026 16:32:43 +0000
Message-ID: <179372356363.488855.15987799075512902171@kernel.org>
In-Reply-To: <60417d840527fb839aec6e9a15a3a4a906d59919.1793588257.git.tanggeliang@kylinos.cn>
References: <60417d840527fb839aec6e9a15a3a4a906d59919.1793588257.git.tanggeliang@kylinos.cn>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch changes how mptcp_inq_hint()
  (net/mptcp/protocol.c:2402-2420) handles the passive-TFO overflow: it…
- [Low] A fix for a user-visible bug in released kernels is folded into a
  feature patch titled "mptcp: implement peek_len for proto_ops", with…
- [Low] The new mptcp_peek_len() (net/mptcp/protocol.c:4815-4818),
  installed as .peek_len in mptcp_stream_ops and mptcp_v6_stream_ops,…

--

mptcp: implement peek_len for proto_ops

This adds mptcp_inq() and mptcp_peek_len(), which use mptcp_data_avail()
to compute the readable bytes at the MPTCP level. It sets .peek_len in
both mptcp_stream_ops and mptcp_v6_stream_ops. It also changes
mptcp_inq_hint() to return 0 instead of INT_MAX when ack_seq minus the
head skb's map_seq overflows on passive TFO.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 0caa31525b907..c6d354900e7d2 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2409,7 +2409,7 @@ static unsigned int mptcp_inq_hint(const struct sock *sk)
>  		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
>  
>  		if (hint_val >= INT_MAX)
> -			return INT_MAX;
> +			return 0;

[Severity: High]
Doesn't this still report a wrong value, just a different one? On
passive TFO there is readable data at the head of sk_receive_queue, so
returning 0 tells userspace that nothing is queued when data is.

The TFO skb is queued with a synthetic map_seq, while bytes_received is
updated with the real length:

net/mptcp/fastopen.c:mptcp_fastopen_subflow_synack_set_params() {
    ...
	MPTCP_SKB_CB(skb)->map_seq = -skb->len;
    ...
	mptcp_sk(sk)->bytes_received += skb->len;
    ...
}

At the third ACK, ack_seq moves into the key-derived sequence space.
Nothing rebases the map_seq of the queued skb:

net/mptcp/subflow.c:subflow_set_remote_key() {
    ...
	WRITE_ONCE(msk->ack_seq, subflow->iasn);
    ...
}

While the TFO skb is still at the head of the queue, hint_val works out
to iasn + remaining_len. The skb may be unread, or only partly read,
since recvmsg only advances map_seq by the copied count. Because iasn is
effectively random, this is almost always >= INT_MAX.

With this change, SIOCINQ/FIONREAD in mptcp_ioctl() returns 0 to
userspace:

	*karg = mptcp_inq_hint(sk);

The TCP_CM_INQ cmsg in mptcp_recvmsg() also reports 0, including after a
partial read of the TFO payload. Poll still reports EPOLLIN through
mptcp_data_avail(). mptcp_rcv_space_adjust() now subtracts nothing for
the queued data.

Could an application that treats "readable but 0 bytes queued" as EOF,
or that stops draining on a zero INQ hint, misbehave here?

In the rare case where iasn + len is below INT_MAX, wouldn't a garbage
value still be returned?

The new mptcp_inq() below already gets the right count from
mptcp_data_avail(). The commit message also describes this as the way to
avoid the TFO overflow. On the same socket, .peek_len would return the
correct count while SIOCINQ and TCP_CM_INQ return 0.

Would it be better to compute mptcp_inq_hint() from mptcp_data_avail(),
keeping the return 1 at EOF behaviour? Rebasing map_seq for the TFO skb
would also work. Either seems better than clamping the overflow to 0.

[Severity: Low]
This isn't a bug, but this hunk fixes a user-visible problem in released
kernels. It is bundled into a patch whose subject only mentions peek_len,
and there is no Fixes: tag.

The return INT_MAX branch came from commit 2c9e77659a0c8d ("mptcp: add
TCP_INQ cmsg support").

The overflow became reachable after commit f03afb3aeb9d81 ("mptcp: drop
__mptcp_fastopen_gen_msk_ackseq()"). That commit stopped rebasing the
map_seq of the queued TFO skb at third ACK time.

Could this be split out as a separate patch for net with:

Fixes: f03afb3aeb9d81 ("mptcp: drop __mptcp_fastopen_gen_msk_ackseq()")

That way stable could pick up the fix without the unrelated .peek_len
feature. The approach would still need the change described above.

[ ... ]

> @@ -4797,6 +4797,26 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
>  	return ret;
>  }
>  
> +static int mptcp_inq(struct sock *sk)
> +{

[ ... ]

> +	avail = mptcp_data_avail(msk);
> +	if (avail >= INT_MAX)
> +		return 0;
> +
> +	return (unsigned int)avail;
> +}
> +
> +static int mptcp_peek_len(struct socket *sock)
> +{
> +	return mptcp_inq(sock->sk);
> +}

[Severity: Low]
Can any in-tree caller reach this callback? The only sock->ops->peek_len
users appear to be the following.

drivers/vhost/net.c:sock_has_rx_data(). Its backend is limited to
tun/tap and AF_PACKET sockets.

net/strparser/strparser.c:strp_peek_len(), used by KCM and sockmap.
kcm_attach() rejects anything that isn't IPPROTO_TCP:

	    csk->sk_protocol != IPPROTO_TCP) {

For sockmap, MPTCP sets psock_update_sk_prot = NULL, so an MPTCP socket
cannot join a sockmap.

Without a consumer it is hard to check the semantics. For example,
mptcp_peek_len() does not count data still on msk->backlog_list, while
the SIOCINQ path calls mptcp_move_skbs() first.

Could the commit message name the intended consumer (perhaps upcoming
sockmap support)? Alternatively, could this callback be added together
with that user?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793588257.git.tanggeliang%40kylinos.cn
