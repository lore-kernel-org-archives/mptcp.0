Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795200110;
	b=WZxDANc0OkDYhmZkz76Q02k/m2VJAcX9jvGqqBCC4KLn5k53GvZiVRWTawQpGKfJSeeT
	 3gc3FR7HLc6rzW9ftiTVYnEDlwhlQxGauVZaQnQN+5iV6PYxsytVvkHIqnZsOXeRTZam2
	 XCiwT4ZDTlSaSnToSMZvCXQywv34/7HYpdQdNhWfTNJP4yu5WZ4dERkJ6fuwuirI7Epi0
	 pgwiinRs+qTo/YUNPBl0Gm9psQPQ7ubB5ntTlJKWR8B4Hb9HWeh7GKQieWNEs2ufKTO20
	 ZGi/d8XToPdUmjYadIANODys0wz/IO1DKgFCFU/lOqMKHZeMIyvyTiYa9HbVL2zqSeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795200110;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=+VGdo0nna4+dRG48O97w3edvjDL0MBjJM/aKTFS5LlU=;
	b=36SdafctRWRVxyQJnf9OBSOObRQZBm+jXhw1vr9N2hU5945N0KagNLu6qsCp9nqi/otp
	 rnFCFM2/3dhe+hVHchpmeRPvA/6ff7TmYnqlEQC3qO251NZzQ54WmqvihoWL/mWwq66Lk
	 B1n2Y/Fg7Y02jAhfK2BMT8ZCUtELhjUtjVBJg1CjBtC1wkurvHsvfEW0Iw063OZNi4+6U
	 5LRErcw1Iysx4igbTJ5ivqxBDvFo3gsiczKJLCdBCqNHDntVD8WuME+thS9ETS6yQdK0w
	 q6ACLLXbXVJBnLZKlrZnooDEcIUGZJCdKAAQyDBQfmJfUw7OyKC4A3JLVudNEzCcg/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sxq7olqg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA5960A2613
	for <mptcp@lists.linux.dev>; Fri, 20 Nov 2026 18:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sxq7olqg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B755B1F000C0;
	Fri, 20 Nov 2026 18:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795200109;
	bh=+VGdo0nna4+dRG48O97w3edvjDL0MBjJM/aKTFS5LlU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Sxq7olqgep/QkW52yLpumca7bi7sPtdpjFaq2sxo74iQ48tT3g5ss1T6hz9epdOFh
	 Mf45sjgGJYWfQ6ukSbgJJycNfF3sA77FhuhVC1YYeZGRV5k/s/RLFCzZMpOZeQJqu/
	 Cs5DR0rHoPZfCami39rKrJtWfXme/2dYD03eX5bNte0yLOVFO8KTrUVkJ/t6Oni9uF
	 xiLw3isPxEtYvhCN+TzUa6YqaQEjYFe4QzlYfbZI7aJSxdJl0gmcnOiFgqALQ3Ia0T
	 ta/t/6gBHJ48Navs91DBFjnrW6Ba+639XbgwSEo4RkfPRwtN+hxISsoNvZD2mbYmyw
	 XUWezoVMzayKw==
Subject: Re: [PATCH mptcp-net v29 2/8] mptcp: fix TFO SIOCINQ overflow in
 mptcp_inq_hint
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Fri, 20 Nov 2026 18:41:49 +0000
Message-ID: <179520010933.3133.16820599578382097492@kernel.org>
In-Reply-To: <f9a5a16a7164ad9e1a09b0f58e99f0e4ab3cdb99.1795063943.git.tanggeliang@kylinos.cn>
References: <f9a5a16a7164ad9e1a09b0f58e99f0e4ab3cdb99.1795063943.git.tanggeliang@kylinos.cn>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] mptcp_inq_hint() in net/mptcp/protocol.c adds the FIN byte
  whenever msk->rcv_data_fin_seq is non-zero.
- [Low] The commit message gets TCP's behavior wrong.

--

mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint

This commit changes mptcp_inq_hint() to compute available bytes with
mptcp_data_avail() instead of ack_seq minus the head skb's map_seq. This
fixes the bogus INT_MAX value on passive TFO connections. It also changes
the FIN accounting so the extra byte is counted only when rcv_data_fin_seq
is non-zero.

> This means with N bytes unread after DATA_FIN, both SIOCINQ and TCP_CM_INQ
> report N+1 when rcv_data_fin_seq is set, or N otherwise. This differs
> from TCP, which always reports N+1 after FIN because the FIN consumes a
> sequence number.

[Severity: Low]
Is this description of TCP accurate for SIOCINQ?

tcp_ioctl(SIOCINQ) uses tcp_inq(), which subtracts the FIN:

include/net/tcp.h:tcp_inq() {
    ...
	answ = tp->rcv_nxt - tp->copied_seq;

	/* Subtract 1, if FIN was received */
	if (answ && sock_flag(sk, SOCK_DONE))
		answ--;
    ...
}

So TCP FIONREAD reports N after FIN, and 0 once all data has been read.
Only TCP_CM_INQ, through tcp_inq_hint(), reports N+1.

mptcp_ioctl(SIOCINQ) returns mptcp_inq_hint() directly. That means MPTCP
matches TCP for TCP_CM_INQ but is off by one for SIOCINQ, which looks like
the opposite of what the message says. The SIOCINQ off-by-one already
existed before this patch.

The message also says the guard avoids wrongly inflating the hint for
SHUT_RD and MP_FASTCLOSE. With an empty queue, though, RST, MP_FASTCLOSE
and SHUT_RD used to report 1 and now report 0.

Could the commit message describe that as a user-visible behavior change,
and correct the TCP comparison?

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 382da25320378..072725c6ab5d1 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2404,22 +2404,15 @@ static bool mptcp_move_skbs(struct sock *sk)
>  static unsigned int mptcp_inq_hint(const struct sock *sk)
>  {
>  	const struct mptcp_sock *msk = mptcp_sk(sk);
> -	const struct sk_buff *skb;
> +	u64 hint_val = mptcp_data_avail(msk);
>  
> -	skb = skb_peek(&sk->sk_receive_queue);
> -	if (skb) {
> -		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
> +	if (hint_val >= INT_MAX)
> +		return INT_MAX;
>  
> -		if (hint_val >= INT_MAX)
> -			return INT_MAX;
> +	if (READ_ONCE(msk->rcv_data_fin_seq))
> +		hint_val += 1;

[Severity: Medium]
Can this count the FIN byte before the DATA_FIN has been reached in
sequence?

rcv_data_fin_seq is written as soon as the DATA_FIN option is parsed in
subflow context:

net/mptcp/options.c:mptcp_update_rcv_data_fin() {
    ...
	WRITE_ONCE(msk->rcv_data_fin_seq,
		   mptcp_expand_seq(READ_ONCE(msk->ack_seq), data_fin_seq, use_64bit));
	WRITE_ONCE(msk->rcv_data_fin, 1);
    ...
}

Two paths reach this, and neither checks ack_seq: the zero-length DSS path
in mptcp_incoming_options(), and get_mapping_status() while a previous
mapping is still valid. The in-tree comment there says as much:

	/* A DATA_FIN might arrive in a DSS
	 * option before the previous mapping
	 * has been fully consumed. Continue
	 * handling the existing mapping.
	 */

The DATA_FIN only counts as reached later, in
mptcp_check_data_fin()->mptcp_pending_data_fin(), which requires:

	if (READ_ONCE(msk->ack_seq) == rcv_data_fin_seq) {

Also, rcv_data_fin_seq is not cleared until mptcp_disconnect(). A non-zero
value therefore only means the option was parsed, not that the FIN was
reached in sequence. The commit message's "only counts a FIN when a
DATA_FIN was actually received" doesn't make that distinction.

Take two subflows where data on subflow A is delayed and a DATA_FIN-only
pure ACK arrives on subflow B. The same thing happens on a single subflow
when a data segment is lost and the next pure ACK carries the DATA_FIN.

In that state, would SIOCINQ/FIONREAD and TCP_CM_INQ report N+1 for N bytes
of in-order data? Once those bytes are drained, would they report 1, even
though recv() blocks and poll does not report the socket readable?

A similar case: get_mapping_status() parses a DATA_FIN mapping while the
owner is in recvmsg, and the data goes to the backlog. The TCP_CM_INQ cmsg
would then report N+1, which suggests EOF after N bytes, but more data
follows.

The code before this patch counted the FIN only after the in-sequence
point. It did so through the bumped ack_seq, or through
RCV_SHUTDOWN/TCP_CLOSE when the queue was empty. tcp_inq_hint() works the
same way, using rcv_nxt and SOCK_DONE:

	if (inq == 0 && sock_flag(sk, SOCK_DONE))
		inq = 1;

The same code is still there at the end of the series.

Would a guard such as (sk->sk_shutdown & RCV_SHUTDOWN) && rcv_data_fin_seq,
or !READ_ONCE(msk->rcv_data_fin) && rcv_data_fin_seq, better match the
point where the DATA_FIN has actually been consumed?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1795063943.git.tanggeliang%40kylinos.cn
