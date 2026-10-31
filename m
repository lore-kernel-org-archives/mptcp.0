Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793458574;
	b=G0s6TG3+nO/RPSLrr5L4IfpuehhC1qNWyArS+cdoH7wSjLcjpNUB9ClWO2LGQRabqz2L
	 e/+oDz4zn5qWGD1muwwTVE8sEbxdPuA8dcXggGR/fyz2eZA7mMCZUvTYbI/kjtFxAKvqz
	 MZYsGGTP9kJUJL1O8ykHZWVDVgia0QFkauCrtzMcdD2/FLOdsT3t5jwxNA4x7dUijWO1h
	 RKnjOxisVkxD0nmr5y3whoj1x6lLlTrhpkc8p1Z0B/dRQcTPlBH/Y738f4bBdyW8flSF5
	 h+lvroJK1Yj48U96ZfN36MzYyB8Ujle3UYDnrOPv+gVW4wpDDBIH87dAmupwkzN9cxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793458574;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=pKemmHPInhyuI7mId1iXMjNg7pSTZj3yTXxmRaxPHAg=;
	b=KpxuBh5htRBoDlmW2J8V6QS1CbFtjjVAoqdlHNP6kX+hObEY+oc98Uq3busYMQdPoqCz
	 ZVX2mcbZHmAjxPjFWh8YOsMxM5AlKrNoxWucluaknkIC8hph1D4qZEp3CNSbiT1yuOHmS
	 /QC+h7+MSt1jZDS7XwqOTPx5eCfgoU0PhOBdIgnWLiAlgFKCryv6JpsavO8qIFeQF1+uk
	 hmz+Zk3sFlYX3FwyD8oaf40OUu2LWMhw1sba4fxElcmTZdFIKoAvws+qBEEzJfdRLJrnq
	 yHaPKc1Pzsd+5H/JwHbjcyJpG2FTn9a2MroLoTOOqr09bqQLZc5qczxP3H15e5ibbtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oPsepjSy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD90606A31D
	for <mptcp@lists.linux.dev>; Sat, 31 Oct 2026 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oPsepjSy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753281F00919;
	Sat, 31 Oct 2026 14:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793458573;
	bh=pKemmHPInhyuI7mId1iXMjNg7pSTZj3yTXxmRaxPHAg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oPsepjSyJQUz/VBCGcOq11V6mVLeRHM3I9ujAbKijFblO9hSBtS7b8tjFVjuyfjfs
	 eu5+pZvdLMu8DTRI9ZTYjUc//lcJ26pGytuLAidxLomTfprHmR/Ydi00hVJHRWkzix
	 gtCiXm0DFewgSNxsFqRVBUA8Mg6kt/JD80YZDtPyWXNWJ7dBXx3tgauwLGaDYKmWww
	 tEQaiSmml77IkPJlFSrFF+UcXzusg9HR+osw+QkIxnLFuvBZHdPLQae+mWG51VrFT0
	 0TebcJY43wzRkA0ykSzNzgPgvTSwMIaDibTwsN9Q3OQqFmWtsF9zssHYvtMhLEBB8d
	 YMoYKVPMRgYrA==
Subject: Re: [PATCH mptcp-next v3 2/5] mptcp: implement peek_len for proto_ops
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Sat, 31 Oct 2026 14:56:12 +0000
Message-ID: <179345857294.3128.2098446166917025433@kernel.org>
In-Reply-To: =?utf-8?q?=3C792219afffb4d3cc71ba3286b648b90ea50b1c86=2E1793324?=
 =?utf-8?q?316=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C792219afffb4d3cc71ba3286b648b90ea50b1c86=2E17933243?=
 =?utf-8?q?16=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
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

- [Low] The commit message describes the existing helper incorrectly.
- [Low] The From: and Signed-off-by: email addresses do not match.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the commit
  message shows the author knows about it.

--

mptcp: implement peek_len for proto_ops

This commit adds mptcp_inq(), which uses mptcp_data_avail() to compute the
readable bytes at the MPTCP level. It is wired into a new mptcp_peek_len()
callback, which is assigned to .peek_len in both mptcp_stream_ops and
mptcp_v6_stream_ops.

> Note: mptcp_inq() differs from mptcp_inq_hint() by returning 0 (not 1)
> when value is 0, and using mptcp_data_avail() instead of ack_seq -
> copied_seq with TCP_CLOSE/RCV_SHUTDOWN check, to correctly handle TFO
> scenarios.

[Severity: Low]
Is this description of mptcp_inq_hint() accurate? The helper takes the
delta from the map_seq of the skb at the head of the queue, not from a
copied_seq:

net/mptcp/protocol.c:mptcp_inq_hint() {
    ...
	skb = skb_peek(&sk->sk_receive_queue);
	if (skb) {
		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
    ...
}

struct mptcp_sock has no copied_seq field. All the copied_seq references
under net/mptcp/ are tcp_sk(ssk)->copied_seq on subflows.

Also, mptcp_inq_hint() already returns 0 on an empty, open connection. It
returns 1 only as an EOF hint, when the queue is empty and the socket is
closed or shut down for reading:

	if (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
		return 1;

	return 0;

The message also doesn't say what the "TFO overflow issues" are. It also
doesn't mention that the SIOCINQ and TCP_INQ users of mptcp_inq_hint()
keep the old computation.

Could the note be reworded to match the code?

> Co-developed-by: Zqiang <qiang.zhang@linux.dev>
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the author line is Geliang Tang <geliang@kernel.org>
while the sign-off uses tanggeliang@kylinos.cn. checkpatch.pl reports
"From:/Signed-off-by: email address mismatch" for this.

.mailmap maps both addresses to the same person. The earlier patch in the
series, "mptcp: update mptcp_check_readable", signs off with
geliang@kernel.org.

Could the sign-off be made to match the From: line?

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 0caa31525b907..dbd6275963b88 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -4797,6 +4797,26 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
>  	return ret;
>  }
>  
> +static int mptcp_inq(struct sock *sk)
> +{
> +	const struct mptcp_sock *msk = mptcp_sk(sk);
> +	u64 avail;
> +
> +	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV))
> +		return 0;
> +
> +	avail = mptcp_data_avail(msk);

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. The
commit message mentions TFO overflow, though, and mptcp_inq_hint() still
seems to return INT_MAX on passive MPTCP TFO connections. Would it make
sense to fix the shared helper rather than add a second computation here?

The TFO skb is queued with a map_seq relative to an ack_seq of 0:

net/mptcp/fastopen.c:mptcp_fastopen_subflow_synack_set_params() {
    ...
	/* Only the sequence delta is relevant */
	MPTCP_SKB_CB(skb)->map_seq = -skb->len;
	MPTCP_SKB_CB(skb)->end_seq = 0;
    ...
}

When the MPC ACK arrives, ack_seq is set to iasn through
set_fully_established()->__mptcp_subflow_fully_established()->
subflow_set_remote_key():

net/mptcp/subflow.c:subflow_set_remote_key() {
    ...
	WRITE_ONCE(msk->ack_seq, subflow->iasn);
    ...
}

Nothing rebases the map_seq of the queued skb. It only advances on
partial reads.

While that skb is at the head of the queue, ack_seq - map_seq in
mptcp_inq_hint() is iasn plus the remaining length. That is almost always
>= INT_MAX, so the helper returns INT_MAX.

That value reaches userspace through SIOCINQ in mptcp_ioctl():

		*karg = mptcp_inq_hint(sk);

It also reaches userspace through the TCP_INQ cmsg in mptcp_recvmsg(). It
also feeds mptcp_rcv_space_adjust():

	copied -= mptcp_inq_hint(sk);

There it makes copied negative, so that receive buffer autotuning sample
is skipped.

With this patch applied, can ->peek_len and SIOCINQ return different
values for the same passive TFO socket?

> +	if (avail >= INT_MAX)
> +		return 0;
> +
> +	return (unsigned int)avail;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793324316.git.tanggeliang%40kylinos.cn
