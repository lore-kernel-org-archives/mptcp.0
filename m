Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793134543;
	b=WjMUXZjZPcodeoIXIXnODBxi29DWSR1qY30ItxGdIqOG3AOxJuSUtNhYp01E88t/apb5
	 yKaGXS/YshxpdbUb4BhIslB1jj6DlYb6HnCzoD7aq6PILOM/CTxFGOqxjVj0QiHVg3gCE
	 fQIEciDSUdEEe9xYR0BT22r9oKexqrTnmr9Qhzu3lKhH27i7kZCH6TkOIjczk8PV1ps5C
	 9xb+ggih8lXyZA0XexwN5e9woy1ubuc/c04nc0NS2zvJayK/605gmTZrE2hMKWQOFp11M
	 RTAGDVenTItcaO1WcvgfHzUcZ6czjpg90OZak+0k3RrGoVdBWqh0WeWJsdQ8wexpNwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793134543;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=50fg2cxwx8JKEIfDnZFDKyqG7p3pshMOlDWFE/2e+SQ=;
	b=uvQ6/LNGjUdK0qZN/6Gi9Q00SmQAbrODQEF1VtOb2G8Vf1EUyKnA+JZ1ykyDeZxH88dD
	 w2rv0fDhb9mcFDfyW63I4baUc8TMKyurEUvo+5DAj4EjQ4IrGtY25I53b8Urd4CIoJI0n
	 jLXSZDI1DyWiQAlwTEERIX4eNAz/kcvdZfYtcBZRcenIbMRth0NHpIqj9BcZfHZ5pQ0cL
	 3YSyJqUpqXO9rsDafoKBrwgg/QoE33DTQdbstmRB7JbWRo8sIeJR8ySCOUSsghWqh05UQ
	 b5K/+Pr+Uz6esceZx1Gw7xz54eeEihEbP+beI1ng/rjRl+1bh4xmuXShe+TKfrne9Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=boyxOaw5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69A9606A31A
	for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 20:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=boyxOaw5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59BAA1F01828;
	Tue, 27 Oct 2026 20:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793134542;
	bh=50fg2cxwx8JKEIfDnZFDKyqG7p3pshMOlDWFE/2e+SQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=boyxOaw5b419iPACKps9zHrJic7UpfnCt7lRW+OJOIYP5hWc86l7fQkB+8Tgy0njA
	 VshHD5CVp/W+QnTbSOW33oFnc7jMkJSTAs+MrefMYQSfnQ/M9aE+OCkXBGT/cEgBAG
	 92dNmMiFy5zM5UkZ+OXU2+wO6YXXwMm3YrOg5trX2LJ4rlWmHmc5dxZa2B1XKk62Ir
	 dcd6N8s6jTpLJSu67nV1o+FJXVV57Yiq4DMea3VqJ3KO1vmozm55+yTDv8QczGLRD+
	 0qTJNwjxTC8ezkcQ1tUtCCKEQnbWDNZu237H6OsH7dqRhy9e7PS0rEiGLMwd/aqKq8
	 6Dr+mPSsdXMGA==
Subject: Re: [PATCH mptcp-next 3/6] mptcp: implement peek_len for proto_ops
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Tue, 27 Oct 2026 20:55:41 +0000
Message-ID: <179313454191.3132.7810453996924430013@kernel.org>
In-Reply-To: =?utf-8?q?=3C22bc848942a31334be17f49a2488c51e2f307eb5=2E1792999?=
 =?utf-8?q?988=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C22bc848942a31334be17f49a2488c51e2f307eb5=2E17929999?=
 =?utf-8?q?88=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch changes the result of the SIOCINQ/FIONREAD ioctl on
  MPTCP sockets and does not say so.
- [Medium] mptcp_inq() (net/mptcp/protocol.c:4821-4824) subtracts 1 from
  the readable byte count whenever `sk->sk_state == TCP_CLOSE ||…
- [Medium] mptcp: mptcp_inq() returns bogus byte count for TFO data after
  3rd ACK
- [Low] The commit message describes mptcp_inq() differently from the
  code.

--

mptcp: implement peek_len for proto_ops

This commit adds mptcp_inq(), which computes the number of readable bytes
at the MPTCP level. It wires mptcp_inq() into a new mptcp_peek_len()
callback for both the IPv4 and IPv6 stream proto_ops, as preparation for
kTLS over MPTCP. It also switches the SIOCINQ ioctl path from
mptcp_inq_hint() to mptcp_inq().

> Add mptcp_inq() to compute the number of readable bytes at the MPTCP
> level. It derives the count from ack_seq - copied_seq, returns 0 while
> the connection is still handshaking (TCP_SYN_SENT/TCP_SYN_RECV), returns
> 0 when the connection is closed (TCP_CLOSE or RCV_SHUTDOWN), and
> subtracts 1 once a FIN has been received, mirroring tcp_inq().
>
> READ_ONCE() is used instead of mptcp_data_lock() for the u64 reads of
> ack_seq and copied_seq because mptcp_inq() will be called from TLS
> contexts with the socket lock held - taking the spinlock would deadlock.

[Severity: Low]
Does this description match the code?

struct mptcp_sock has no copied_seq field. mptcp_inq() actually computes:

    hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;

This uses the map_seq of the head skb in sk_receive_queue.

Also, mptcp_inq() never returns 0 because of TCP_CLOSE or RCV_SHUTDOWN. When
data is queued it decrements answ and returns the remaining count. It only
returns 0 for SYN_SENT/SYN_RECV, an empty receive queue, or
hint_val >= INT_MAX.

As written, the message describes two different behaviours for a closed
connection ("returns 0" and "subtracts 1"), and only the second one exists.
Could the description be updated to match the code?

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 0caa31525b907..71a0a28b0d3c9 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -4188,7 +4189,7 @@ static int mptcp_ioctl(struct sock *sk, int cmd, int *karg)
>  		lock_sock(sk);
>  		if (mptcp_move_skbs(sk))
>  			mptcp_cleanup_rbuf(msk, 0);
> -		*karg = mptcp_inq_hint(sk);
> +		*karg = mptcp_inq(sk);

[Severity: Medium]
Is this change to SIOCINQ/FIONREAD intended? The subject and body only
describe a new peek_len callback.

The note at the end of the commit message says:

    mptcp_inq_hint() returns 1 to signal EOF to ioctl/cmsg users
    (mirroring tcp_inq_hint())

After this hunk, ioctl users no longer go through mptcp_inq_hint().

Compared with the old mptcp_inq_hint(), ioctl(FIONREAD) on an MPTCP socket
now returns:

- 0 instead of 1 for an empty receive queue with TCP_CLOSE or
  RCV_SHUTDOWN set
- N instead of N+1 for queued data after a DATA_FIN, because
  mptcp_check_data_fin() advanced ack_seq by one
- N-1 instead of N when RCV_SHUTDOWN or TCP_CLOSE is set without a
  DATA_FIN (see the comment on mptcp_inq() below)
- 0 instead of INT_MAX when hint_val >= INT_MAX

Some of this brings MPTCP closer to tcp_ioctl(), which uses tcp_inq(), but
userspace can see the difference. Should this go in a separate patch, with
a commit message that describes the new ioctl behaviour and perhaps a
Fixes: tag?

No later patch in the series touches this code.

>  		release_sock(sk);
>  		break;
>  	case SIOCOUTQ:
> @@ -4797,6 +4798,39 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
>  	return ret;
>  }
>  
> +static int mptcp_inq(struct sock *sk)
> +{
> +	const struct mptcp_sock *msk = mptcp_sk(sk);
> +	const struct sk_buff *skb;
> +	u64 hint_val;
> +	int answ;
> +
> +	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV))
> +		return 0;
> +
> +	skb = skb_peek(&sk->sk_receive_queue);
> +	if (!skb)
> +		return 0;
> +
> +	hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
> +	if (hint_val >= INT_MAX)
> +		return 0;
> +
> +	answ = (unsigned int)hint_val;
> +
> +	/* Subtract 1, if FIN was received. Mirror tcp_inq() */
> +	if (answ &&
> +	    (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)))
> +		answ--;

[Severity: Medium]
Can this return 0 while passive TFO data is still queued?

On the passive side, mptcp_fastopen_subflow_synack_set_params() queues
the SYN data skb on sk_receive_queue with a sequence that is relative
to an ack_seq of 0:

    MPTCP_SKB_CB(skb)->map_seq = -skb->len;
    MPTCP_SKB_CB(skb)->end_seq = 0;

When the third ACK carrying MP_CAPABLE arrives,
subflow_set_remote_key() does:

    WRITE_ONCE(msk->ack_seq, subflow->iasn);

Since commit f03afb3aeb9d ("mptcp: drop
__mptcp_fastopen_gen_msk_ackseq()"), nothing rebases the map_seq of an
skb that is already in the receive queue.

Suppose userspace has not consumed the SYN data by then, or strparser
has not, once kTLS uses this. The subtraction in mptcp_inq() then
yields roughly subflow->iasn plus the remaining TFO length. iasn is
derived from a hash of the remote key, so the result is almost always
>= INT_MAX, and mptcp_inq() returns 0 even though bytes are readable.
In the rare case where the value wraps below INT_MAX, it returns a
bogus positive count instead.

The commit message treats hint_val >= INT_MAX as a torn read on 32-bit.
Here, though, it is a stable state that holds until the TFO skb is
drained.

The old mptcp_inq_hint() used the same arithmetic but returned INT_MAX
in this case, which at least did not hide the data. With the ioctl hunk
in this patch, FIONREAD now reports 0. For peek_len, a 0 return would
leave a strparser waiting on need_bytes for data that is already
queued.

Would it be better to derive the count from mptcp_data_avail()? It uses
bytes_received - bytes_consumed and does not depend on the map_seq of
the head skb. Alternatively, should the queued TFO skb be rebased when
ack_seq is set from iasn?

[Severity: Medium]
Can this under-report the readable byte count by one?

msk->ack_seq only holds the extra unit after mptcp_check_data_fin() has
processed a DATA_FIN:

    if (mptcp_pending_data_fin(sk, &rcv_data_fin_seq)) {
        WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);
        ...
        WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);

Several other paths set TCP_CLOSE or RCV_SHUTDOWN without touching ack_seq,
while in-order data stays in sk_receive_queue:

- shutdown(fd, SHUT_RD): the .shutdown handler is inet_shutdown(), which
  sets RCV_SHUTDOWN, and mptcp_shutdown() only acts on SEND_SHUTDOWN.

- A received MP_FASTCLOSE: mptcp_check_fastclose() does

    mptcp_set_state(sk, TCP_CLOSE);
    WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);

  and neither changes ack_seq nor purges the queue.

- A reset or error on a fallback subflow: __mptcp_subflow_error_report()
  moves the msk to TCP_CLOSE. With the earlier "mptcp: prevent dummy
  DATA_FIN on RST in fallback mode" patch in this series, no dummy DATA_FIN
  bumps ack_seq on this path.

In these cases ack_seq - map_seq is exactly the queued length N, but
mptcp_inq() returns N-1. With a single byte queued it returns 0.
mptcp_recvmsg() still drains all N bytes before it checks sk_err,
RCV_SHUTDOWN or TCP_CLOSE.

mptcp_ioctl() now calls mptcp_inq(), so FIONREAD reports N-1 where
mptcp_inq_hint() used to return N. For the new peek_len, strp_data_ready()
compares strp_peek_len() against need_bytes, so a complete final message
could be treated as incomplete.

The comment says this mirrors tcp_inq(), but tcp_inq() only decrements when
SOCK_DONE is set:

    if (answ && sock_flag(sk, SOCK_DONE))
        answ--;

A processed DATA_FIN always sets RCV_SHUTDOWN, so the TCP_CLOSE check can
only cause undercounts.

Should the decrement depend on whether ack_seq actually includes the
DATA_FIN, for example a condition derived from rcv_data_fin_seq, rather
than on TCP_CLOSE or RCV_SHUTDOWN?

This code is unchanged at the end of the series.

> +
> +	return answ;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792999988.git.tanggeliang%40kylinos.cn
