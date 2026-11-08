Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794123445;
	b=wmyOaG2tJOj0gKUfORAAkIasoAAU4rs1kU4pr+ABUDymkhphvXcq6dHJVl2JFiL+wsuu
	 i9HmjNRncrHv4hlN+CvToUXtBq9q9y11iQXNRosShgDevRCKtQf9JSmGiFpaGSceuGkG+
	 kU8eLq68dOFvMWvMLBB9X1S1EJUdzFm5aRvsYzrAaNQqsVlZ+yD3JIwzSBm09VdHRPG+u
	 eGUX3W5pCGcxtRnzuwDiF9S+u0cd1XVwzgF9J6DYE2PsHGUqbkD97RYHffLflMcPdUCtn
	 Sgv2fA5fDDM5l/UNCo+uMbGpyfcEfElg75IfSJ8PkwF33r2h3Vyj9MWgSOhQU0rN6kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794123445;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=BJanboEL44PDk7Io3a2QN+VaeDNWntE1mys+SHlwLxI=;
	b=nzFo8Kk0Mm1l4JdS3/TNwz0k2QGJZiRVhOjBPVWYWtMplew6ljnVlz16GaaHDEI9Gyky
	 hBo2l9JbESp61g4bFd8XzZ0hX18c4qZQRLnDgF9fdZaVNvORAEM3qrILO7AnStjHL624v
	 EkkJTEKzNpvgZpLWLOkqR7euRUF1UVvepQoI5jZoz20Wx+4049/L1sdVLT15sqAGIKMkB
	 qKfQX5JfVnf1DS0DmAZUc3u7D+AKuZVu+PaJ/hGwtgFVmEmWBfJHqaxagRyNQ2l4noEbC
	 VPL/HhaKjp4W8BoUkv+zUrSejnTioDurMYz5KVmDGMheSy3uuD7L/flp1fRJremXM8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mxVt/6fG";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27900606A31C
	for <mptcp@lists.linux.dev>; Sun,  8 Nov 2026 07:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mxVt/6fG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695401F0089F;
	Sun,  8 Nov 2026 07:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794123444;
	bh=BJanboEL44PDk7Io3a2QN+VaeDNWntE1mys+SHlwLxI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mxVt/6fG3RCE8AscgLNShtt+HTWWnlMm9otqCKWlsDD1fd818m6erjYp8xwJPntnX
	 Ie+JoVkEi/viCZTLB6ybIcL3hSbJS8nAAGIHmGvvql9v++KuvV+JWg1y29MJ5gE57/
	 rH6E9VZkRNphscQC81BnWpU9z/mlYzA6ee9Aw0/zJKz7kss6h8eM0YH7Z+T0gPxWoX
	 ypzQLMgNV+Xr2sEmbHSVZsBzZ40aAbPne3yboAR82pZSQUWmdeNLJprXQ2ubfZ0CUz
	 awQS/B1DKxYMG/PpHQii7wwyd9sb+45MOyvbp9KI3/hOy+ibIJIRvcbeqjp5s28Vre
	 SOGIfHwxVo0Vw==
Subject: Re: [PATCH mptcp-net v23 1/8] mptcp: fix TFO SIOCINQ overflow in
 mptcp_inq_hint
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, pabeni@redhat.com,
 kuba@kernel.org
Date: Sun, 08 Nov 2026 07:37:23 +0000
Message-ID: <179412344395.488855.3475938613473578437@kernel.org>
In-Reply-To: <751f1c0ccc0c0de2dadaf9bcb52bed01a7515ed2.1793969127.git.tanggeliang@kylinos.cn>
References: <751f1c0ccc0c0de2dadaf9bcb52bed01a7515ed2.1793969127.git.tanggeliang@kylinos.cn>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In net/mptcp/protocol.c, mptcp_inq_hint() now adds 1 whenever
  sk->sk_shutdown has RCV_SHUTDOWN set.

--

mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint

This patch changes mptcp_inq_hint() so it computes the available bytes
with mptcp_data_avail() rather than ack_seq minus the head skb's map_seq.
That avoids an INT_MAX result on passive TFO connections. When
RCV_SHUTDOWN is set, it adds 1 to count the FIN byte.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 02a4f479d9d8c..421df3af1ef93 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2402,22 +2402,18 @@ static bool mptcp_move_skbs(struct sock *sk)
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
> +	if (sk->sk_shutdown & RCV_SHUTDOWN)
> +		hint_val++;

[Severity: Medium]
Can this report one byte too many when RCV_SHUTDOWN is set but no
DATA_FIN was received?

The commit message says:

  "When RCV_SHUTDOWN is set (DATA_FIN received), add 1 to include the FIN
  byte, matching the previous ack_seq - map_seq behavior."

As far as I can tell, only mptcp_check_data_fin() sets RCV_SHUTDOWN and
also adds the FIN byte to ack_seq:

net/mptcp/protocol.c:mptcp_check_data_fin() {
    ...
	WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);
	WRITE_ONCE(msk->rcv_data_fin, 0);

	WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
    ...
}

A local shutdown(fd, SHUT_RD) goes through the .shutdown op in
mptcp_stream_ops, which is inet_shutdown():

net/ipv4/af_inet.c:inet_shutdown() {
    ...
	WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | how);
	if (sk->sk_prot->shutdown)
		sk->sk_prot->shutdown(sk, how);
    ...
}

mptcp_shutdown() only handles SEND_SHUTDOWN. It does not purge
sk_receive_queue, and ack_seq stays the same.

A peer MP_FASTCLOSE has the same effect:

net/mptcp/protocol.c:mptcp_check_fastclose() {
    ...
	mptcp_set_state(sk, TCP_CLOSE);
	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
    ...
}

Here too there is no DATA_FIN byte. The msk receive queue is only purged
later, in mptcp_destroy_common().

In both cases, with N unread bytes queued, wouldn't
mptcp_ioctl()->mptcp_inq_hint() for SIOCINQ/FIONREAD, and the TCP_CM_INQ
cmsg from mptcp_recvmsg(), now return N+1?

The old code returned exactly N here. __mptcp_recvmsg_mskq() advances
the head skb's map_seq on partial reads, so ack_seq minus the head
map_seq equals the unread byte count.

For comparison, tcp_inq_hint() counts the FIN only through rcv_nxt. It
does not add a byte after a local SHUT_RD.

Would it be better to add the extra byte only when a DATA_FIN was
actually counted in ack_seq, rather than whenever RCV_SHUTDOWN is set?

>  
> -		return (unsigned int)hint_val;
> -	}
> -
> -	if (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
> +	if (!hint_val && sk->sk_state == TCP_CLOSE)
>  		return 1;
>  
> -	return 0;
> +	return (unsigned int)hint_val;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793969127.git.tanggeliang%40kylinos.cn
