Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794353542;
	b=Dg7NHYKWWojXI6dOHvkGoveb8qhQmzA+Hqdtou+mdOiCfr/Z3dPoUmyyOQfBCxuTa9yy
	 wtj4w1H3tnVv6c4j6i3Onu2J42AsMzVltcSrjS5FEcpRZabFM70JOPzXITk9QpEGOLd9k
	 TXtReDhnEeBTCOAa81Fk0mp75zY4oN6ydDSaBCR344C5WFMh/YAuzNuWMTBaFfK8KIaTk
	 BC3cCzXf9zwyNcAOXUKukvNkIhlATgvZzi1Nu0MLWyfSIFL9+oICgGC3aBjEV60iKOrc9
	 +Cn29qEOTwBassHdu28y5WUOuSAbSrHEGSC0D065QR4hRDwamG7K8YoNZAxOg4Mwm4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794353542;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ra6ekiHPTB/ydYcf61EpUEFbVCAt1w39IwBccOdjc18=;
	b=CIqw8B/okeayZa+DQ5b6N/WZnpa13ngkWGCskxbdozm6LVPUcsgqzJ/MH4cGTpWT5DQO
	 ql/1fmeRxDN2KKjaNhzpusmltSsO3F47lk8veMUytsITYmuD+2yoPv+XDZs8wxr/zBbCQ
	 nyHspUf1gMMSKdEkU7ADjYii7g6SuXOgfzRgAGKFfln1jSQ0uUxbgn2SgsLCRYtb5tPHn
	 HU6C/upZnoMojuLp+pve/OzGwecWQcChqv/eanv7hM0xBt/TF7gVkqJ3nsNL7fVvtCwNd
	 C2VGmjXquB90j02rqB9RDTnETho0Uu0RFuqApciTRrhCKBv7n0DD+rXYDonF2Cq8Htw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mq1tGnR3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AD5606A31C
	for <mptcp@lists.linux.dev>; Tue, 10 Nov 2026 23:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mq1tGnR3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B769F1F0093C;
	Tue, 10 Nov 2026 23:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794353541;
	bh=ra6ekiHPTB/ydYcf61EpUEFbVCAt1w39IwBccOdjc18=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mq1tGnR3KPsjoY2PeXv1zdBaZn+FqEjmXPhmZBPtj2EDap/bzylq/8mkGCKwNRve+
	 989r6FgV2EXnRwVvCQ5zuCB08GKpbiDM3OdbJQbFlzrYvDhCHQ4Kel/Ckpyjc3BnuC
	 5QZgrKZwrvqSxanTvI20Jci2e0ApOeqZmqPL9WVw+imwGSSANWKmRNUVTxcgbVF9UV
	 Cb6Jgf87pzBrOw2HnWnAlBuG7n1eBk1ziIgLTHXvRxR0AyBws2+/AzrywHH/+yGZv1
	 Sf2U8h6Xxfm3Q3JtpDXDw3YMYSM3m8e7TRlV5HucRHY9aSVEE2LjH4Dh5BeiDs3u72
	 y8K9njpqDG4Kg==
Subject: Re: [PATCH mptcp-net v24 1/8] mptcp: fix TFO SIOCINQ overflow in
 mptcp_inq_hint
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Tue, 10 Nov 2026 23:32:21 +0000
Message-ID: <179435354125.488855.3194775514742361661@kernel.org>
In-Reply-To: <3965b9beff100e81b43980484fd1c8d9297274ff.1794215614.git.tanggeliang@kylinos.cn>
References: <3965b9beff100e81b43980484fd1c8d9297274ff.1794215614.git.tanggeliang@kylinos.cn>
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
  mptcp_data_avail() (bytes_received - bytes_consumed) for every caller.
- [Low] The commit message names only SIOCINQ/FIONREAD and TCP_CM_INQ as
  hit by the bogus INT_MAX hint.
- [Low] Author and sign-off addresses differ.

--

mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint

This commit changes mptcp_inq_hint() to compute the available bytes with
mptcp_data_avail() (bytes_received - bytes_consumed) instead of ack_seq
minus the head skb's map_seq. This fixes a bogus INT_MAX hint on passive
TFO connections, where the TFO skb has map_seq set to -skb->len.

> On passive TFO connections, the TFO skb has map_seq set to -skb->len.
> Without the removed __mptcp_fastopen_gen_msk_ackseq() to adjust the TFO
> skb's map_seq, mptcp_inq_hint() computes "ack_seq - map_seq = iasn + len",
> almost always >= INT_MAX, causing SIOCINQ/FIONREAD and TCP_CM_INQ to
> report INT_MAX.

[Severity: Low]
Should this list also mention receive buffer autotuning? Another caller of
mptcp_inq_hint(), mptcp_rcv_space_adjust() in net/mptcp/protocol.c, got
the same bogus value:

net/mptcp/protocol.c:mptcp_rcv_space_adjust() {
    ...
	copied = msk->rcvq_space.copied;
	copied -= mptcp_inq_hint(sk);
	if (copied <= msk->rcvq_space.space)
		goto new_measure;
    ...
}

On a passive TFO socket, after the remote key arrives, the TFO skb at the
head of the receive queue has map_seq = -skb->len. That value is set in
mptcp_fastopen_subflow_synack_set_params(). The old hint was clamped to
INT_MAX, so copied went negative, the code jumped to new_measure, and
mptcp_rcvbuf_grow() was never called.

A partial read only advances map_seq by count in __mptcp_recvmsg_mskq().
So the hint stayed wrong, and autotuning stayed off until the whole TFO
skb had been read.

This patch fixes that path as well. Could the commit message say so? It
would help stable backporters judge the fix.

> Fixes: f03afb3aeb9d ("mptcp: drop __mptcp_fastopen_gen_msk_ackseq()")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the author address (geliang@kernel.org) does not
match the only Signed-off-by address (tanggeliang@kylinos.cn).
checkpatch.pl reports this as FROM_SIGN_OFF_MISMATCH.

Could the author address be updated, or a matching Signed-off-by be added?

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
mptcp_inq_hint() feeds more than SIOCINQ. It also supplies the TCP_CM_INQ
cmsg in mptcp_recvmsg():

	unsigned int inq = mptcp_inq_hint(sk);

	put_cmsg(msg, SOL_TCP, TCP_CM_INQ, sizeof(inq), &inq);

Does this change move TCP_CM_INQ away from TCP after a DATA_FIN?

bytes_received never counts the DATA_FIN. mptcp_check_data_fin() only
bumps ack_seq:

	WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);

So with N bytes still unread after a DATA_FIN, the TCP_CM_INQ value
reported by mptcp_recvmsg() drops from N+1 to N.

Plain TCP fills TCP_CM_INQ from tcp_inq_hint() in net/ipv4/tcp.c. That
value still includes the FIN:

	inq = rcv_nxt - copied_seq;
	...
	if (inq == 0 && sock_flag(sk, SOCK_DONE))
		inq = 1;

So TCP reports N+1 here, which is also what MPTCP reported before this
patch.

The commit message calls the N+1 to N change "aligning with TCP's SIOCINQ
behavior". That holds for SIOCINQ, because tcp_inq() subtracts 1 when
SOCK_DONE is set. For TCP_CM_INQ it is a user-visible change away from
TCP, and the message does not mention it. The same code is still in place
at the end of the series.

Should the commit message cover the TCP_CM_INQ change? Or should the cmsg
path keep reporting N+1?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794215614.git.tanggeliang%40kylinos.cn
