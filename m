Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415541;
	b=MFv1BHeScZ2NNbvoJfbqW2KRl663H1TJvGjySHXeU7mlKQZMgFz/D1ltSMsURfDUovAU
	 LJwC9/QEHgyuEKo4kMJK5AsEhXBg6qjB4S4nnmOBw5sDliwLHFPHcWjjlaE8Yrk5ewsi4
	 vkDQf/m1XeG7sDdwzck8DQMm7k9JRpOCt/U9EwZiXSJ1195r8ytCxwred/qZW9O3uz8Go
	 +a9FQUAtJMq7Yvu+J4fAHlpbnkr9w3uG4JjZImjfie0lEvsHWvGlQJnHAuZ/QCBXBOT+g
	 Di+iQrGhhvwJH0G9OQlk6ImYtLXA81Xp7uurMTgri+xG7Oyx1DSiZAsKOAz2D3h8AmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415541;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=77AKUs7nQVrvfD+JltN663SChrUH2+SoLD+kEPWx+lY=;
	b=3efvQMHlRES8+8C38Mc2mlhjgjy5y6SEUKfGdkB65FVqveqHVlNYh52EP3tyJLeu/G0E
	 X6zHJoqQBMyRN+1HC8lyBBHzTDZaRPubI2pHiwTw9zEzpL2XFlFOYlI+ZGKX076y9SpRE
	 ToKEbDoSazeyMAcmYnS2edOGVqnFisN3GaUnkpPMQEMOnGEu/VkqNQ6Hhfwa0VqIMa8xH
	 Ybbvzc3KatLNAr08KrBl7BPIstQbYZXyk3bcnPtrgyGreOPAs7fvh/omtULdkwB0rn3O9
	 skrvjIZayTXwbDKTdu9SrIr/L0mQe4kNkEhyP5iaOi4UTMpdSXMBrOXT3hg7KUaUkaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dkkXJ+ib;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC089606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 06:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dkkXJ+ib
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3281F000D8;
	Mon, 23 Nov 2026 06:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795415541;
	bh=77AKUs7nQVrvfD+JltN663SChrUH2+SoLD+kEPWx+lY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dkkXJ+iboomrP2QMb3PvjB6P06YclKY8t2u32YxAsSCtdp+qTSv3DMqyRIdlC//zo
	 BjTG5hkFqhD76Xyd3vIa4+E2wMaI35Ug3uFZW4+XtdpxyY3FI4cKMoT/oKO62sy6P9
	 ZrwViW++t6NPK6/ariL3Cs82UEv5MR8+XOurkzfex0fCJVN8HhACL1E1/pAss5gM5X
	 93pL3CB25xh1i+KlZxM24RqqMfw6OHj/RzZ0R1tn+rCPCnnmkIVB9cNT4R92ltIiib
	 ZwnG/C8imflr2CxTbPn7IcCgg7iviGOfLUSlHY9CMveoG0uQ+ZfSMSjYzgoY0/Ri54
	 GY9i5JyA9MMBg==
Subject: Re: [PATCH mptcp-net v2 12/62] mptcp: keep an orphan while it can
 send its data
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Mon, 23 Nov 2026 06:32:20 +0000
Message-ID: <179541554087.3133.1709563113530925995@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-12-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-12-00327fd1de1f@kernel.org>
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

- [Low] The patch adds an unconditional close-timeout restart for orphans
  in mptcp_check_send_data_fin() (net/mptcp/protocol.c:3479-3481).

--

mptcp: keep an orphan while it can send its data

Before this patch, the close timeout of an orphaned MPTCP socket ran from
close() and reset the connection when it expired, even if data was still
waiting for the peer's window to open. The patch restarts the timeout when
the DATA_FIN is sent. It also restarts the timeout and pushes the pending
data again when the timeout expires before the DATA_FIN, as long as an
active subflow has recently heard from the peer.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/647

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index d64e04245963c..944c9d11d2116 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -3449,6 +3476,10 @@ static void mptcp_check_send_data_fin(struct sock *sk)
>  
>  	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
>  
> +	/* an orphan's close timeout is for the DATA_FIN exchange */
> +	if (sock_flag(sk, SOCK_DEAD))
> +		mptcp_start_tout_timer(sk);
> +

[Severity: Low]
Can this restart overwrite the forced expiry that __mptcp_close_ssk() sets
when the last subflow of an orphan reaches TCP_CLOSE?

__mptcp_close_ssk() expects the worker to destroy the orphan on its next
run:

net/mptcp/protocol.c:__mptcp_close_ssk() {
    ...
		if (sock_flag(sk, SOCK_DEAD)) {
			/* let the worker close and destroy the orphan */
			mptcp_set_close_tout(sk, tcp_jiffies32 -
					     (mptcp_close_timeout(sk) + 1));
			mptcp_schedule_work(sk);
    ...
}

In mptcp_worker(), mptcp_pm_worker() runs before
mptcp_check_send_data_fin(), and both run before the
mptcp_close_tout_expired() checks.

When an orphan's last data is pushed from BH, __mptcp_subflow_push_pending()
leaves the DATA_FIN to the worker:

		if (msk->snd_data_fin_enable &&
		    msk->snd_nxt + 1 == msk->write_seq)
			mptcp_schedule_work(sk);

Suppose an RM_ADDR from the peer is queued before that worker runs. A
userspace PM subflow destroy has the same effect. Then a single worker run
does this:

mptcp_worker()
  mptcp_pm_worker()
    mptcp_pm_rm_addr_recv()
      mptcp_pm_rm_addr_or_subflow()
        mptcp_close_ssk()
          __mptcp_close_ssk()
            /* last subflow to TCP_CLOSE, close tout forced into the past */
  mptcp_check_send_data_fin()
    /* gate still open, snd_nxt = write_seq, SOCK_DEAD set */
    mptcp_start_tout_timer()
      /* probe_timestamp = tcp_jiffies32 */
  mptcp_close_tout_expired()
    /* now false, so __mptcp_destroy_sock() is skipped */

Without this patch the orphan was destroyed in that same worker run. With
it, the msk and its rtx queue stay around for another TCP_TIMEWAIT_LEN,
although no subflow is left to carry the DATA_FIN exchange the new comment
refers to. The orphan is freed only when the tout timer fires, because
mptcp_orphan_keep() then returns false (snd_nxt == write_seq).

The delay is bounded and happens only once, so this is not a leak.

Would it make sense to restart only if the timeout has not already expired,
for example:

	if (sock_flag(sk, SOCK_DEAD) && !mptcp_close_tout_expired(sk))
		mptcp_start_tout_timer(sk);

or to restart only while a subflow can still send?

>  	mptcp_for_each_subflow(msk, subflow) {
>  		struct sock *tcp_sk = mptcp_subflow_tcp_sock(subflow);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f%40kernel.org
