Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794955270;
	b=xT0tIl/G4hH9r1LRyERD2o4/oX3kFOHEhrFtO+7JGC1s10CQUruoysHiryZQ1MhIFcph
	 FNcwpPxxmQPtVwtJcgItE65Gr9DVjdOcZhGpOYvSH86Auo+inXFYqvehfEEhunT6zAn00
	 v0Pz9xohjAYEb6CMadVTrVvf2sVTzkmwJTfQnO8d9ntXoYufCD6482uNwORH9Ujya3THX
	 RIE+rDCYj+pWEcTWEhr2zg5Ub2db5oLuvbOvr4s7Iwgsz4p1QYJT569GgWllrQxezzR8l
	 e/+EMsx5ditZ0Q2nLEh1UfVtD+dg9tZdsetWgPVmIMtmp0aPcWVwPmm3zk7t/e2wx2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794955270;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=lQ9Dhv0yHZXEJZxrro5MZtAn/dy25h696Ui9Y7d+yQw=;
	b=3tNuvNFGMsjfc411vmJ0X+6s5UXxPiEhjl4HO1oI2Q3wqzHZWNrvrQI/uoFfXdgKkNwY
	 JNJIP9wqz4XNnM+ZDmR6Wq4p+5QBUgXvfI1UcQ3r0AekHkKWHzuTkOcLrwuMAlv8Pmj6W
	 Kpj7BKJEQF3m+WsMDPen8Ioyw0B/0ehLDMYpJ5QdKyIcNuSaCHt2Zn3Lt1JXF4xOqQsbM
	 JOoQ5tZaLYawQMbVaBGyT2gVBUxSKP9RwxUaTc5xXVd75erCN2I/PTtoh8+Xk5RnNGKGB
	 h0vZOL9Ptoe7IOyoMgjCZMtcpYYIwb595snAFcW2iSOu1YdrcLUCUUI2rMahjo4F8mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=np8wopB2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6AD606A31C
	for <mptcp@lists.linux.dev>; Tue, 17 Nov 2026 22:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=np8wopB2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254371F000C4;
	Tue, 17 Nov 2026 22:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794955270;
	bh=lQ9Dhv0yHZXEJZxrro5MZtAn/dy25h696Ui9Y7d+yQw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=np8wopB2bdphLGgUdADeq2u4r+84KTxlXJ0ZpIbNfZ5eKZLFwq6z4c6dGTUbdZuRv
	 1df9nLSPXbffNdO2yMN5nUaS69J98nOVNlBV416imBLoUDWVpLjnkLbVSZxlhQmfqY
	 UmqcDU2Qg0Zfescn9rylOZdtFvrNoKM6IaQiHiuOKOmkUV4WvWFvAvFMpmx7Bt1o9l
	 zNibqrFOJpfB0OIz71B8X/W3b0zlpZkI1CJvNkZh7iMwCLfRaekA/52DQPtPK2zgRD
	 HmYukD4Dua6tl8RE908A5SJBz3ztlYS8XJHQAGAnLtTdPuSJ1IK59Xo8oZG9/z4EhX
	 ue//UNcxmH5Hw==
Subject: Re: [PATCH mptcp-net v28 01/11] mptcp: fix TFO SIOCINQ overflow in
 mptcp_inq_hint
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Tue, 17 Nov 2026 22:41:09 +0000
Message-ID: <179495526966.3133.1400847227803157545@kernel.org>
In-Reply-To: <ebac8e12800293fe7cfc0f2b5f88109b34df6d06.1794810809.git.tanggeliang@kylinos.cn>
References: <ebac8e12800293fe7cfc0f2b5f88109b34df6d06.1794810809.git.tanggeliang@kylinos.cn>
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

- [Low] The commit message gets the TCP comparison wrong for SIOCINQ.
- [Low] The From: and Signed-off-by addresses do not match.
- [Low] After this patch, MPTCP's TCP_CM_INQ cmsg no longer matches TCP
  once a DATA_FIN has arrived with N > 0 bytes unread.

--

mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint

This commit changes mptcp_inq_hint() to compute the available bytes with
mptcp_data_avail() instead of ack_seq minus the head skb's map_seq. On
passive TFO connections the old formula returned INT_MAX. As a side
effect, the value reported after DATA_FIN changes from N+1 to N.

> Using mptcp_data_avail() avoids this by tracking bytes directly. This
> change also affects non-TFO connections after DATA_FIN: with N bytes
> unread, both SIOCINQ and TCP_CM_INQ now report N instead of N+1. This
> differs from TCP, which reports N+1 because the FIN consumes a sequence
> number. The EOF hint of 1 is preserved for the empty-queue case when
> the socket is closed or shutdown.

[Severity: Low]
Is the comparison with TCP accurate for SIOCINQ? TCP's SIOCINQ path is
tcp_inq(), and it subtracts the FIN:

include/net/tcp.h:tcp_inq() {
    ...
		answ = tp->rcv_nxt - tp->copied_seq;

		/* Subtract 1, if FIN was received */
		if (answ && sock_flag(sk, SOCK_DONE))
			answ--;
    ...
}

After a FIN, TCP reports N for SIOCINQ. Only TCP_CM_INQ, through
tcp_inq_hint() in net/ipv4/tcp.c, reports N+1.

Before this patch, mptcp_inq_hint() returned N+1 on both interfaces,
because mptcp_check_data_fin() bumps ack_seq by 1 for DATA_FIN. So for
SIOCINQ/FIONREAD through mptcp_ioctl(), this patch actually makes MPTCP
match TCP. Only TCP_CM_INQ is a new difference.

The same applies to the EOF hint of 1. It matches TCP only for
TCP_CM_INQ. TCP's SIOCINQ reports 0 in that state.

Could the commit message say which interface now matches TCP and which
one differs?

> Fixes: f03afb3aeb9d ("mptcp: drop __mptcp_fastopen_gen_msk_ackseq()")
> Co-developed-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the author address is geliang@kernel.org and the
only author Signed-off-by uses tanggeliang@kylinos.cn. checkpatch.pl will
report this as FROM_SIGN_OFF_MISMATCH. Should a Signed-off-by with the
From: address be added, or the author address be changed to match?

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 50de5cedfd0fb..f2644e7a6a05a 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2404,22 +2404,16 @@ static bool mptcp_move_skbs(struct sock *sk)
>  static unsigned int mptcp_inq_hint(const struct sock *sk)
>  {
>  	const struct mptcp_sock *msk = mptcp_sk(sk);
> -	const struct sk_buff *skb;
> +	u64 hint_val = mptcp_data_avail(msk);

[Severity: Low]
Does this break TCP_CM_INQ parity with TCP once a DATA_FIN has arrived
and N > 0 bytes are still unread?

mptcp_recvmsg() builds the cmsg from this helper:

net/mptcp/protocol.c:mptcp_recvmsg() {
    ...
		if (cmsg_flags & MPTCP_CMSG_INQ) {
			unsigned int inq = mptcp_inq_hint(sk);

			put_cmsg(msg, SOL_TCP, TCP_CM_INQ, sizeof(inq), &inq);
		}
    ...
}

With this patch the helper returns bytes_received - bytes_consumed = N.
TCP's tcp_inq_hint() returns rcv_nxt - copied_seq, which is N+1 because
the FIN consumes a sequence number.

Before this patch MPTCP also returned N+1, because mptcp_check_data_fin()
does:

	WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);

mptcp_inq_hint() serves both mptcp_ioctl(SIOCINQ) and the TCP_CM_INQ
cmsg. TCP uses different semantics for the two: tcp_inq() subtracts the
FIN and tcp_inq_hint() does not. One shared helper therefore cannot match
TCP on both interfaces. This patch fixes SIOCINQ but breaks TCP_CM_INQ
parity.

Would it make sense to give the cmsg path its own value? For example, it
could add 1 when hint_val > 0 and DATA_FIN has been received, so that it
matches tcp_inq_hint().

Userspace can rely on the exact +1. The mptcp_connect selftest's
do_recvmsg_cmsg() uses it to detect a pending FIN:

	if (ret + 1 != (int)last_hint) {

The next patch in the series, "selftests: mptcp: connect: check TFO
SIOCINQ overflow", adds a separate branch for the new inq semantics.

>  
> -	skb = skb_peek(&sk->sk_receive_queue);
> -	if (skb) {
> -		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
> +	if (hint_val >= INT_MAX)
> +		return INT_MAX;

[ ... ]

> -	if (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
> +	if (!hint_val &&
> +	    (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)))
>  		return 1;
>  
> -	return 0;
> +	return (unsigned int)hint_val;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794810809.git.tanggeliang%40kylinos.cn
