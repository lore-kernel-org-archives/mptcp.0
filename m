Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795569464;
	b=5kSg6fSkkFel3QnqjcYnvv1GxZQDo2RtyvDq1Zwn1ftfIANsjMou/ME9Ov9qCwpuyfvP
	 pskwENsWulsDzKVv9dT5cM9tPKBm/I7Vulv3fX4im2WvWUerC8s+YV5LEcUIDwL3h96TE
	 aMt6U1GBQYQ26utL4/f3RXnald3mPrZHrW71PDd5HOtfHtxwiULTU08PQfr28IEhseTOp
	 yUPqSjt4yBIO3BPyBn/G3mMf2dQ6ym2lez8pzGUXXubnvCnOUdPzC4iECVLR1FjDeNpd7
	 haU7fXVnRBi9WShtIXt8nGKx4vX3NwdV1SDmFwNyeULJFQKZnx01oUFviMjR94J50xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795569464;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=2Y8G9p7teLaFGzQ3VZzOAf4g6Jme6DTjUgFoJLrRSjo=;
	b=2sreRRc/fTFWPAFxvjLLEBJIXqD7/NaAq9MGQoc4rnfAdZBWytpmu/BN1u7SiBNYek2l
	 DaDlTCbMasHpuiH7t/WH0uDnD9olCPJfTLZZSOaD8bRG2fJDo+A/aCS2hCVpjk1b8FiXj
	 q39RVshl/pPRFG7qgmZ6Z/yHEC6aG7B+6c9rNuQ/Cj7qtpAQe6FdZQSYAotpomj1tekzE
	 j6sAfuJn77L3XKG+yfayk+fgvTJRZd1Gmi3SwJc4HKITHQXeqE7sm9yVYQSlpOGZjd6xC
	 8w1tINSlISo8IZzivVPITrVvrEZTfyuMLLAQgPeehTrU8FOnp0ivYeYVFXz8YAZYj6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gN6Z4/O+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC97606A31E
	for <mptcp@lists.linux.dev>; Wed, 25 Nov 2026 01:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gN6Z4/O+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729481F000C6;
	Wed, 25 Nov 2026 01:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795569463;
	bh=2Y8G9p7teLaFGzQ3VZzOAf4g6Jme6DTjUgFoJLrRSjo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=gN6Z4/O+ZmxbumusKm2Ti0KaRsd76gwcUfmpsFuuc7iGiTIXKFnAe6EcJZShfR/1h
	 d5xLb+NYUBe8OaGOju542hxooizH3IU7easgO5xaZlhHgwh04Gotv+mCiRL3ZO3r+z
	 gx9Hm+YPfpGVuorJdfacKn/VtWec+DMl4/MKEHnL8y7LL7OBRNzZMDkLxjFxEDuN/o
	 FChLhbuz109Vp6U3pBNaqjtKcNA4hD749+4xa8X862j+xzs0pX0Coc1dQRa+YQPDpK
	 qq6iPmkoZ5qw6dhfRe4X8yIFQZrG2a6bQb3MFxYLkJSVXdIB/+IEORRXTli+4+Sr86
	 k3oUnSUSv/+2g==
Date: Tue, 24 Nov 2026 17:17:43 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-net v3 01/50] mptcp: keep an orphan while it can
 send its data
In-Reply-To: <61bfa741-5112-5709-c5ab-95e609fcdd7b@kernel.org>
Message-ID: <87c07db9-fe51-7593-bf51-65d04951fec1@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org> <20261124-mptcp-cmason-fixes-v3-1-416c0920c73f@kernel.org> <61bfa741-5112-5709-c5ab-95e609fcdd7b@kernel.org>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 24 Nov 2026, Mat Martineau wrote:

> On Tue, 24 Nov 2026, Matthieu Baerts (NGI0) wrote:
>
>> The close timeout of an orphaned MPTCP socket started at close(), and
>> its expiry reset the connection, while some data could still be waiting
>> for the peer to open its window: a peer reading slowly or pausing got a
>> reset 60 seconds after close(), and lost the end of the data, while TCP
>> delivers it.
>> 
>> This timeout is there for the DATA_FIN exchange, see commit d866ae9aaa43
>> ("mptcp: add a new sysctl for make after break timeout"), and for an
>> orphan that can no longer send anything. So restart it when the DATA_FIN
>> is sent, and when it expires before, as long as a subflow can still send
>> the data, which is then pushed again: an established subflow, on which
>> the peer acked something recently, at least the window probes. Until
>> then, as for a TCP socket that is not orphaned, nothing limits how long
>> the peer can keep its window closed, while it acks the window probes.
>> The timeout still starts at close(): the subflows are not TCP orphans,
>> so its expiry is the only check that the orphan can still send.
>> 
>> This was reported on GitHub, with a reproducer: a server writes 2 MB,
>> then calls close(), while the client pauses before reading the rest.
>> After a pause of 90 seconds, the client got ECONNRESET, while TCP
>> delivered everything, as MPTCP now does. If the client vanishes instead,
>> the orphan is now reset as TCP does.
>> 
>> Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/647
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
> v2 LGTM:

(I meant v3...)

>
> Reviewed-by: Mat Martineau <martineau@kernel.org>
>
>> ---
>> v2: new, for issue #647 reported on GitHub
>> 
>> Note (Clashiko on v2): when the last subflow is closed in the same
>> worker run, before the DATA_FIN is sent, the destruction of the orphan
>> is delayed once, by the close timeout. Not restarting the timeout once
>> expired would reset an orphan sending its DATA_FIN after a long probing.
>> ---
>> net/mptcp/protocol.c | 31 +++++++++++++++++++++++++++++++
>> 1 file changed, 31 insertions(+)
>> 
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index d64e04245963..944c9d11d211 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -2871,6 +2871,28 @@ static bool mptcp_close_tout_expired(const struct 
>> sock *sk)
>> 		  inet_csk(sk)->icsk_mtup.probe_timestamp + 
>> mptcp_close_timeout(sk));
>> }
>> 
>> +/* Before its DATA_FIN, keep an orphan while a subflow can send its data 
>> */
>> +static bool mptcp_orphan_keep(struct sock *sk)
>> +{
>> +	struct mptcp_sock *msk = mptcp_sk(sk);
>> +	struct mptcp_subflow_context *subflow;
>> +
>> +	if (!sock_flag(sk, SOCK_DEAD) || msk->snd_nxt == msk->write_seq)
>> +		return false;
>> +
>> +	mptcp_for_each_subflow(msk, subflow) {
>> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>> +
>> +		/* a live peer acks at least the probes, every TCP_RTO_MAX */
>> +		if (__mptcp_subflow_active(subflow) &&
>> +		    tcp_jiffies32 - READ_ONCE(tcp_sk(ssk)->rcv_tstamp) <
>> +		    2 * TCP_RTO_MAX)
>> +			return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> static void mptcp_check_fastclose(struct mptcp_sock *msk)
>> {
>> 	struct mptcp_subflow_context *subflow, *tmp;
>> @@ -3208,6 +3230,11 @@ static void mptcp_worker(struct work_struct *work)
>> 	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
>> 		__mptcp_close_subflow(sk);
>> 
>> +	if (mptcp_close_tout_expired(sk) && mptcp_orphan_keep(sk)) {
>> +		mptcp_start_tout_timer(sk);
>> +		__mptcp_push_pending(sk, 0);
>> +	}
>> +
>> 	if (mptcp_close_tout_expired(sk)) {
>> 		struct mptcp_subflow_context *subflow, *tmp;
>> 
>> @@ -3449,6 +3476,10 @@ static void mptcp_check_send_data_fin(struct sock 
>> *sk)
>>
>> 	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
>> 
>> +	/* an orphan's close timeout is for the DATA_FIN exchange */
>> +	if (sock_flag(sk, SOCK_DEAD))
>> +		mptcp_start_tout_timer(sk);
>> +
>> 	mptcp_for_each_subflow(msk, subflow) {
>> 		struct sock *tcp_sk = mptcp_subflow_tcp_sock(subflow);
>> 
>> 
>> -- 
>> 2.55.0
>> 
>> 
>> 
>
