Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794006427;
	b=uILL0kBS7H9dxstu2ipAofroItsfgeCV9W9zi2vqBLMfXgbvQqe81M6WOR/6fW07Znvl
	 YmvhGe+Dc93Yr+FkJIpUympG1FH3SvXsHU3ENRABmd0u1HSrDUyWM5Fsp9JqYigYbyu9D
	 XX+BcGf22cGkla/T3sJLl2ly8OLniW/2y88vmb0k/5WeCACN3X/1ie2sYULJ8u1164gbV
	 KmC8hWwc6ok8TjIFoeZwQvTFFmYy5RZVt2E+I9+IrMgbDuJ3ecXiDUECJto27vi1KJgH1
	 7K18A9SNRvlet9GKIs/TiL7TA5lm9vYiCNPo3CXn3qYHB7G9YIan9fmUrPYpIRbEJxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794006427;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=N2/pToDt33HxOVO59r96LUcjUeaupMIi+lrTwE64C30=;
	b=UAp6JNFubP0dk9q6DQTAtCXuQpX97U9xyXvtxiMizxp83r0TyYxbJ3K/yQpcbIgPyBtP
	 aezqc1RDB9J6cbCClix/UGrM2K+guJ1wAWB45aCX19p1bFqyDIaTj72HDvMi+FACdVyIQ
	 ifG944mX2o22Okktc7+2fB8F2P6mDERIcj032XJ7YpgXg1de3u7NgIoeWdj5u1KfvXbvh
	 NqDpcm71CcS1gIifePpgM/9UgqIbK3/R3z5C1nI+cs/yzlxXoHnh8i3vIN7mdeZA4r4aL
	 0FLUhoxLlXpe6sK1V16AuIBFCG0UrWOGK+TGHMpUolUhYzfGic/wr7VrPR7fhLpvy0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PpyKk0K3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3792606A326
	for <mptcp@lists.linux.dev>; Fri,  6 Nov 2026 23:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PpyKk0K3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C761F0089F;
	Fri,  6 Nov 2026 23:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794006426;
	bh=N2/pToDt33HxOVO59r96LUcjUeaupMIi+lrTwE64C30=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PpyKk0K3+NsIoQIWV7uljclWkTz+XfANkC2fYfcd/y3y07zIyqHH85uqkCORTYNGU
	 LfQc587Ru3L0c4fPtgMtvUY+/mhLCM9Sw2i8QCLlBQtrfEMFn2MQUjWkHzmJROmvj1
	 BnizuRQ5K66gzK4Y34D5v1ROFmccZWI26e+kYLF8wP1griWGQOmvnB1hWDeA/uzu2s
	 iA59XT1B1pPSaONE6cNsDMkbbFG9FSXKBx41zt4E1PhQ6cqlGuMbzWRyjvVvNWt343
	 ft1WbJdHovrfxRj22pH13KLZaUqrgQrut3Tx4gAHJGTTqH1PUCF7SyxB55P7jAGzqf
	 e+4WcOzwJe8ZA==
Subject: Re: [PATCH mptcp-net v21 1/9] mptcp: fix TFO SIOCINQ overflow in
 mptcp_inq_hint
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, pabeni@redhat.com,
 kuba@kernel.org
Date: Fri, 06 Nov 2026 23:07:05 +0000
Message-ID: <179400642577.488855.2112552052031185753@kernel.org>
In-Reply-To: <51891fd171100f37f87178ab753337140e462941.1793870710.git.tanggeliang@kylinos.cn>
References: <51891fd171100f37f87178ab753337140e462941.1793870710.git.tanggeliang@kylinos.cn>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In net/mptcp/protocol.c, mptcp_inq_hint() now returns
  mptcp_data_avail() (bytes_received - bytes_consumed) instead of…

--

mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint

This changes mptcp_inq_hint() so it computes the hint from
mptcp_data_avail() (bytes_received - bytes_consumed) and no longer uses
ack_seq minus the head skb's map_seq. The goal is to stop passive TFO
connections from reporting INT_MAX through SIOCINQ/FIONREAD and
TCP_CM_INQ. The EOF hint of 1 is kept for the empty-queue case.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 02a4f479d9d8c..fc4ffa3263176 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2402,22 +2402,16 @@ static bool mptcp_move_skbs(struct sock *sk)
>  static unsigned int mptcp_inq_hint(const struct sock *sk)
>  {
>  	const struct mptcp_sock *msk = mptcp_sk(sk);
> -	const struct sk_buff *skb;
> +	u64 hint_val = mptcp_data_avail(msk);

[Severity: Low]
This change also affects non-TFO MPTCP sockets once a DATA_FIN has been
received. Was that intended?

When an in-sequence DATA_FIN is processed, mptcp_check_data_fin() bumps
ack_seq, but bytes_received stays the same:

net/mptcp/protocol.c:mptcp_check_data_fin() {
    ...
	if (mptcp_pending_data_fin(sk, &rcv_data_fin_seq)) {
		WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);
    ...
}

Elsewhere, __mptcp_move_skb() and __mptcp_ofo_queue() advance
bytes_received and ack_seq together. Partial reads also advanced the head
skb's map_seq. So with N > 0 bytes still unread after a DATA_FIN, the old
ack_seq - map_seq gave N + 1, and mptcp_data_avail() now gives N.

That change shows up in SIOCINQ/FIONREAD from mptcp_ioctl(), in the
TCP_CM_INQ cmsg from mptcp_recvmsg(), and in the value that
mptcp_rcv_space_adjust() subtracts from copied.

The new value doesn't line up with TCP on both interfaces. On TCP,
tcp_inq() subtracts 1 when FIN was received, so SIOCINQ reports N, and the
new MPTCP SIOCINQ now matches that. tcp_inq_hint() uses
rcv_nxt - copied_seq and does not subtract the FIN, so TCP_CM_INQ reports
N + 1. The old MPTCP TCP_CM_INQ matched TCP here, and the new one does not.

The commit message says:

    The EOF hint behavior (returning 1 when socket is closed with no data)
    is preserved.

That is true for the empty-queue case. Could the commit message also
mention the N + 1 to N change for non-TFO connections after DATA_FIN, and
whether it is intended? This matters for stable backports of this Fixes:
patch.

>  
> -	skb = skb_peek(&sk->sk_receive_queue);
> -	if (skb) {
> -		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
> +	if (hint_val >= INT_MAX)
> +		return INT_MAX;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793870710.git.tanggeliang%40kylinos.cn
