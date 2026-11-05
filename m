Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793839263;
	b=trwWN8FMHRG/5/3UTWJImfPV63z2Fz6gviD9RZfbWDhCzbGtH+I/hoRj0fKkTc+IgJRR
	 UTjyX/A/Wu3EF99nx3e72QYf/FkHheZgLb9aVjcYqHTy6GcRnw9855ty2bu674B8ulLaO
	 xiK5l3NT6PGWzk5mu2o8a+FsGeUxoESZQ8/3aHWQUpkCuXp36LG+y026FaOerHpy8XL59
	 z4zj6uGWSru7pMSGZ7KDhbRM4Cgx8NwZI9XhHHdd9jrX+zWojoApFFl5+wriOJ1xydH8x
	 cl1Eon/8bcVfU0/HO99iJZBCHs46KLecn5uDAzTkkzcvuT7SWNuom4Mqz45aHU/4hTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793839263;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=xRinHyoYtc+VGS6oJb2T0nyia4ydOME61eMwlSJmmGo=;
	b=yxOUHH3iAQLG7vKXsehAFCuGJrBgnWIVlXT/3KORmD/h7K70oq+NFcpJjmQqG2PWbApD
	 qus96ot3Iya3zN9tj7Ldyakl73BjoECMlw06NWA4CmhCx8wKkDS2gpgCZfuu/tV2nfrpM
	 A2xEfg0zb0qCyRgakntdCV6HfG8NUrGfVq7VtHRW1+8Dx1/fLlNNyRseKT5uCmqKLFhNW
	 N3sckTIgULKIs4/qnh63jCwK8Ganr7Qgk1VkL/UQP5AV3W2uN7CrOE9PCHJeMbEavTJbc
	 RK1pe91X2xgLpXjQ/RXm2rzkz6aQB+HTWCsS3LaoROsnCPXXnsmvvCZztJoS75oOi4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jY9xubwE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93F0606A326
	for <mptcp@lists.linux.dev>; Thu,  5 Nov 2026 00:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jY9xubwE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361141F00919;
	Thu,  5 Nov 2026 00:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793839262;
	bh=xRinHyoYtc+VGS6oJb2T0nyia4ydOME61eMwlSJmmGo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jY9xubwERu1sAMic4gK0UX5YSGic9lqXKyHIcXDOVsWpUdXb5ZVzDtDhMVdrB2XU/
	 Nopuz1CS6zycki6GfE+WMdA5wIteZohfIavI054JrcG13FOtlDMsQQ5SIvRzi3BWzc
	 IB9ZxJWn2W5fGJEHrvp74dGhd6vndyqKBU51Jg6I/2oxt4PzhaNmdMRTy86f22Jaz2
	 WgTv/9I0wiEJFLcnKE9NYE2R2oLphZsfngi2Pw4x75zdIxLPKXF/Xwhd5kekf7FwK4
	 3F9IubUHqSi6PgQfpDL8abrhYazsAV8kCegrUn7RcVEC8bSPxw+f7ipUk5DfpRyi75
	 xGaVFK9ok7lJQ==
Subject: Re: [PATCH mptcp-next v20 3/6] mptcp: fix TFO map_seq sign extension
 in fastopen
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, pabeni@redhat.com,
 kuba@kernel.org
Date: Thu, 05 Nov 2026 00:41:01 +0000
Message-ID: <179383926166.488855.535769879288799614@kernel.org>
In-Reply-To: <6cded4388add37e9314abc3199507bec457000f6.1793695518.git.tanggeliang@kylinos.cn>
References: <6cded4388add37e9314abc3199507bec457000f6.1793695518.git.tanggeliang@kylinos.cn>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message describes the wrong impact.
- [Medium] If user space partly reads the TFO data before the MPC 3rd
  ACK, the read progress stored in map_seq is lost when the sequence is…
- [Low] The patch is described as a fix for a user-visible bug but has no
  Fixes: tag.

--

mptcp: fix TFO map_seq sign extension in fastopen

This patch changes how mptcp_fastopen_subflow_synack_set_params() sets the
dummy map_seq of the TFO skb. It now uses -(u64)skb->len instead of
-skb->len, so the value is a proper 64-bit negative offset from an assumed
IASN of 0.

> mptcp: fix TFO map_seq sign extension in fastopen
>
> [ ... ]
>
> This causes incorrect behavior in sequence number comparisons throughout
> the code. Functions like after64() and before64() may misorder TFO skbs,
> and the out-of-order queue handling may misclassify TFO data.

[Severity: Medium]
Is this description of the impact accurate?

mptcp_fastopen_subflow_synack_set_params() puts the TFO skb straight onto
msk->sk_receive_queue. It never goes through __mptcp_move_skb() or
mptcp_data_queue_ofo(), so it is never in msk->out_of_order_queue.

The after64()/before64() users in protocol.c are mptcp_prune_ofo_queue(),
mptcp_data_queue_ofo(), __mptcp_move_skb() and __mptcp_ofo_queue(). Each
of them compares an incoming or out-of-order skb against msk->ack_seq or
against another out-of-order skb. None of them reads the TFO skb's
map_seq.

The only place another skb meets the TFO skb is __mptcp_try_coalesce().
That function compares from->map_seq with to->end_seq, not map_seq.

Also, __mptcp_move_skb() runs the resync first:

    if (unlikely(msk->rcvd_dummy_seq))
        __mptcp_sync_rcv_sequence(sk);

and the resync rewrites map_seq in u64 arithmetic before any comparison
happens.

The code that does read the dummy map_seq is mptcp_inq_hint():

    u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;

    if (hint_val >= INT_MAX)
        return INT_MAX;

On a passive TFO msk, msk->ack_seq is still 0 until the MPC 3rd ACK
arrives. With the old truncated value, hint_val was 0 - (2^32 - len).
SIOCINQ/FIONREAD through mptcp_ioctl(), the TCP_CM_INQ cmsg in
mptcp_recvmsg() and mptcp_rcv_space_adjust() therefore all saw INT_MAX.
With this patch they see skb->len.

Could the commit message describe this user-visible effect instead of the
ordering and out-of-order queue effects?

There is a related problem later in the series. "mptcp: sync mptcp skb cb
layout with tcp one" makes the CB map_seq a u32, but mptcp_inq_hint()
still computes the u64 ack_seq minus the u32 map_seq. The TFO skb then
gets map_seq = 2^32 - len again, and the INT_MAX result before the 3rd
ACK comes back.

Is the benefit of this patch lost by the end of the series?

> Fix by casting to u64 before negation: -(u64)skb->len. This ensures
> proper 64-bit two's complement representation and correct semantics for
> all sequence number operations.
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
Should this have a Fixes: tag? The truncating assignment

    MPTCP_SKB_CB(skb)->map_seq = -skb->len;

was added by commit 36b122baf6a8 ("mptcp: add
subflow_v(4,6)_send_synack()").

In that design, __mptcp_fastopen_gen_msk_ackseq() added ack_seq to the
truncated value, which still left map_seq 2^32 too large. After commit
f03afb3aeb9d removed that helper, the dummy value was never corrected.

The new comment ("before receiving the remote key, IASN is assumed being
0") also relies on the resync added by the earlier "mptcp: drop the
cant_coalesce CB field" patch. Without that patch, this one-line change
only fixes the window before the 3rd ACK, because map_seq is never
rebased afterwards.

Could the commit message name this dependency, or could the change be
folded into the patch that introduces the resync?

> diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
> index e18b31028e7e3..79765cf55286b 100644
> --- a/net/mptcp/fastopen.c
> +++ b/net/mptcp/fastopen.c
> @@ -45,8 +45,10 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
>  	subflow->ssn_offset += skb->len;
>  	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
>  
> -	/* Only the sequence delta is relevant */
> -	MPTCP_SKB_CB(skb)->map_seq = -skb->len;
> +	/* The TFO segment data sits before the IASN; before receiving
> +	 * the remote key, IASN is assumed being 0.
> +	 */
> +	MPTCP_SKB_CB(skb)->map_seq = -(u64)skb->len;
>  	MPTCP_SKB_CB(skb)->end_seq = 0;
>  	MPTCP_SKB_CB(skb)->offset = 0;

[Severity: Medium]
What happens if user space reads only part of the TFO data before the 3rd
ACK arrives?

A short recv() in __mptcp_recvmsg_mskq() (and likewise in
__mptcp_read_sock()) advances both fields:

    MPTCP_SKB_CB(skb)->offset += count;
    MPTCP_SKB_CB(skb)->map_seq += count;

so map_seq always points at the first unread byte. mptcp_inq_hint()
relies on that.

When the 3rd ACK arrives, subflow_set_remote_key() calls
__mptcp_sync_rcv_sequence(), either directly or deferred through
MPTCP_SYNC_SEQ. That function does:

    MPTCP_SKB_CB(skb)->map_seq = msk->tfo_iasn - skb->len;
    MPTCP_SKB_CB(skb)->end_seq = msk->tfo_iasn;

skb->len has not changed, because consumption is tracked in offset. The
+count progress in map_seq is therefore lost.

After that, mptcp_inq_hint() returns ack_seq - map_seq = len, although
only len - offset bytes remain. That overstated value goes to
SIOCINQ/FIONREAD, the TCP_CM_INQ cmsg and mptcp_rcv_space_adjust() until
the TFO skb is fully drained.

This patch makes the value before the sync a correct relative offset.
Would a plain rebase in __mptcp_sync_rcv_sequence() (map_seq += tfo_iasn,
end_seq += tfo_iasn), or tfo_iasn - len + offset, keep the read progress?

By the end of the series, "mptcp: remove CB offset field" moves the
partial-read progress into msk->copied_seq. However, mptcp_inq_hint()
still computes ack_seq - map_seq and never reads copied_seq, so the
overstatement seems to remain.

After "mptcp: sync mptcp skb cb layout with tcp one", the value also
becomes INT_MAX whenever ack_seq >= 2^32.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793695518.git.tanggeliang%40kylinos.cn
