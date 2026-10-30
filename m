Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793397762;
	b=oSgARAYXvSuTgBsQxNHQF6a0oO9m8hFPJVIc5NMpCOwcGGNeoyF+NRpFl/hWN3V8VLHj
	 O/oy/LUkzyarKFPeMBqLHlNOOzgioA25Uxpw5Drxdb/B+Zv7/gbNyQDHb9a9rN16uhfu/
	 YrWGfjyyynWdGYU3bB2weG96YpXMbdl79fJcs6fjFh8VG5sufLbKgentVd1vRVuPl57Z/
	 2XDBqguQcBR7xVOMn60YS2PSnBvcU60+D4HT+6s8PVqBlwcoqiQ5fkL/dgmSm0H7R7/GW
	 PW0MaNRnRBq9KyYYxVokbIj/ydrV4PYOiyKAidmmeNV1N37Su/n3qa2TtPY4rYMoWaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793397762;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=JSPTCKPXoVq2LHd4pr/37jvFGqDs5E+TzZnUEKHgmYM=;
	b=dj6JupjWln/zudGf3nOxUhGpKTjfaIVs6D8rdoVd6JGVtpfaPCz0rSpzYAe8HU2mkLeR
	 JKpSr/EhHwfBADgJgoFc4r0tCsuddHoa10sWrNCD7WBdJhVd4nLIZG/RXVdS7Uc4Sz0mi
	 UEhv2NTgtT2FpHyWlJkxYAzEKuZiFACguaw9LcURsRCdXFOPMX2XaRb056a15mhzudAQv
	 Wv2DNUVy9Y8vWvi1BLBsHPHVlghNZksA5tY7cXgWUTXrBZn8mXWMsQ6eeIVuWGnbRx+0j
	 ppGbrXwglZ8WwcLncxQAJVCcwbEKw5X1ryOxTP6583cb83a0v/aGeV5HApZMfAcDlFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eQ2WDqrV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13681606A336
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 22:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eQ2WDqrV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850411F000C1;
	Fri, 30 Oct 2026 22:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793397761;
	bh=JSPTCKPXoVq2LHd4pr/37jvFGqDs5E+TzZnUEKHgmYM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eQ2WDqrVIBMNU1/MioSROEeaSZfuDMEy7JI4lPn8CgPeoywJ/zOHnIbrW4yNz3f2a
	 ejQuyMXzf1ypOF2XinQ0Yn0t0yCY6x6C3Z9poXgsMEo7bsq+cBAjiDtDqLFzIjLFJD
	 lT/Q4uZoqm0I3LdohAxf0L2b9weoqy5FkvPxkVWswDxmSdw+ciRFQzuUPxZwq7RUNi
	 KXYDLFbLQd/L9Jf8INIj14WCLe1p3v4HY2csDrODXD5nK7Ae56UoW8leHEDO90kAAa
	 9MEATjteuRPWD5sbcVFqKVZsVSUqAyPmelgs1eQpiMfk02fe2aAAVkT94z3Jw0FIJS
	 JzdykbNC9EPPw==
Subject: Re: [PATCH mptcp-next v2 2/5] mptcp: implement peek_len for proto_ops
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Fri, 30 Oct 2026 22:02:41 +0000
Message-ID: <179339776103.3128.17036358030248372177@kernel.org>
In-Reply-To: =?utf-8?q?=3C5a0397c9d6a1bdbb1ddeb7b2c900a8c1184dee59=2E1793258?=
 =?utf-8?q?749=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C5a0397c9d6a1bdbb1ddeb7b2c900a8c1184dee59=2E17932587?=
 =?utf-8?q?49=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
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

- [Medium] mptcp_inq() (net/mptcp/protocol.c, lines 4815-4817) decrements
  the count whenever msk->rcv_data_fin is set: `if (answ &&…
- [Low] The commit message's rationale and comparison don't match the
  tree.

--

mptcp: implement peek_len for proto_ops

This commit adds mptcp_inq(), which computes the readable bytes at the
MPTCP level from mptcp_data_avail(). It subtracts one byte when
msk->rcv_data_fin is set. The new mptcp_peek_len() wraps it and is set
as .peek_len in mptcp_stream_ops and mptcp_v6_stream_ops.

> READ_ONCE() is used instead of mptcp_data_lock() because mptcp_inq()
> will be called from TLS contexts with socket lock held - taking the
> spinlock would deadlock.

[ ... ]

> Note: mptcp_inq() differs from mptcp_inq_hint() by returning 0 (not 1)
> when value is 0, and using mptcp_data_avail() with rcv_data_fin check
> instead of ack_seq - copied_seq with TCP_CLOSE/RCV_SHUTDOWN check, to
> correctly handle TFO scenarios.

[Severity: Low]
Which TLS path does the first paragraph refer to? mptcp_inq() is static
and can only be reached through ->peek_len. TLS calls tcp_inq() directly,
for example in tls_strp_read_sock():

	inq = tcp_inq(strp->sk);

The existing ->peek_len callers can't reach MPTCP sockets either:

- kcm_attach() rejects sockets whose sk_protocol isn't IPPROTO_TCP.
- sock_map only sets up strparser when sk_is_tcp() is true.
- vhost_net only uses tun/tap.

So the new .peek_len has no consumer in the tree. If a later series is
meant to use it, could the commit message name that series?

The comparison with mptcp_inq_hint() also doesn't seem to match the
code. mptcp_inq_hint() subtracts the head skb's map_seq from ack_seq,
not copied_seq. It returns 1 only when the receive queue is empty and
the socket is closed or shut down for receive:

net/mptcp/protocol.c:mptcp_inq_hint() {
	...
	skb = skb_peek(&sk->sk_receive_queue);
	if (skb) {
		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
	...
	if (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
		return 1;

	return 0;
}

Could this note be updated to describe the current mptcp_inq_hint()?

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 0caa31525b907..6f34e3459e8ac 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -4797,6 +4797,33 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
>  	return ret;
>  }
>  
> +static int mptcp_inq(struct sock *sk)
> +{
> +	const struct mptcp_sock *msk = mptcp_sk(sk);
> +	u64 avail;
> +	int answ;
> +
> +	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV))
> +		return 0;
> +
> +	avail = mptcp_data_avail(msk);
> +	if (avail >= INT_MAX)
> +		return 0;
> +
> +	answ = (unsigned int)avail;
> +
> +	/* Subtract 1, if DATA_FIN was received. Mirror tcp_inq() */
> +	if (answ && READ_ONCE(msk->rcv_data_fin))
> +		answ--;

[Severity: Medium]
Does this decrement actually mirror tcp_inq()? In tcp_inq(), rcv_nxt
includes the FIN's sequence slot and SOCK_DONE stays set, so the -1
removes that slot:

include/net/tcp.h:tcp_inq() {
	...
		answ = tp->rcv_nxt - tp->copied_seq;

		/* Subtract 1, if FIN was received */
		if (answ && sock_flag(sk, SOCK_DONE))
			answ--;
	...
}

mptcp_data_avail() is bytes_received - bytes_consumed. bytes_received
only counts payload, for example "+= copy_len" in __mptcp_move_skb() and
"+= skb->len" in fastopen.c. get_mapping_status() also removes the
DATA_FIN byte from the mapping:

net/mptcp/subflow.c:get_mapping_status() {
	...
		/* Adjust for DATA_FIN using 1 byte of sequence space */
		data_len--;
	...
}

The DATA_FIN is only counted in msk->ack_seq, and rcv_data_fin is
cleared in the same step:

net/mptcp/protocol.c:mptcp_check_data_fin() {
	...
	if (mptcp_pending_data_fin(sk, &rcv_data_fin_seq)) {
		WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);
		WRITE_ONCE(msk->rcv_data_fin, 0);
	...
}

So rcv_data_fin == 1 seems to mean the DATA_FIN has been parsed but not
counted anywhere yet. That is exactly when there is no FIN byte to
subtract.

Wouldn't mptcp_peek_len() then return N-1 instead of N, or 0 instead of
1, whenever this branch runs?

The window looks reachable. Say the peer sends its last N bytes with
DATA_FIN in the same DSS. mptcp_update_rcv_data_fin() sets rcv_data_fin
at option parse time, from subflow context. move_skbs_to_msk() then
moves the data and only schedules the worker:

net/mptcp/protocol.c:move_skbs_to_msk() {
	...
	if (mptcp_pending_data_fin(sk, NULL))
		mptcp_schedule_work(sk);
	...
}

sk_data_ready() then runs while rcv_data_fin is still set. If the
DATA_FIN arrives ahead of a gap in the data sequence, the flag stays set
longer, and earlier in-sequence data is under-reported too.

A strparser-style ->peek_len consumer would see a final record that ends
at the DATA_FIN as incomplete in strp_data_ready():

	if (strp_peek_len(strp) < strp->need_bytes)
		return;

When the DATA_FIN is processed later, mptcp_close_wake_up() only calls
sk_state_change() and sk_wake_async(), not sk_data_ready(). Nothing would
re-trigger the parser.

No ->peek_len caller in the current tree reaches MPTCP sockets, so this
downstream effect depends on a future consumer. The code is the same at
the end of the series.

mptcp_data_avail() already leaves out the DATA_FIN. Should the
rcv_data_fin adjustment be dropped?

> +
> +	return answ;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793258749.git.tanggeliang%40kylinos.cn
