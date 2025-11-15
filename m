Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B6810FD
	for <mptcp@lists.linux.dev>; Sat, 15 Nov 2025 01:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763171011; cv=none; b=qBt/Uc9luQJIsc+/DMnvvCCJWc3pRLEJSSEAVeR6+lq+s+uHXbfV0NCnAAsfSfcMBgsWrIiSaAJn+6DG2csogQN5wwDW1+LclmeZgNs/tn9dXcqD+2+V4ikglzg6wezndTANOruzRVzOhtd/2q+s3qSRTGZW3IKH2Vc5h0/CKOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763171011; c=relaxed/simple;
	bh=DQcuh9hzd6DwdCAgmJFjy7hqukEZ/paQp2W5tEtoW9Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WBuCYmgvFsttB/xcktFPkuUVZ0YZe9bfrSGVB6WCYRVfw5gReEEXHZ9UjW4dmPOz67vfZrCwdiE16VRtUjJlpiKOX+Bmn5wuQIzypSe5PS3t2SfyuR51hgH+fS1xyG2zXIZcgEQNaT6nPAkFvlMVUQUIYMeIhHpMwqHDJDknKpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rChJtocK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rChJtocK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7F0C19425;
	Sat, 15 Nov 2025 01:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763171010;
	bh=DQcuh9hzd6DwdCAgmJFjy7hqukEZ/paQp2W5tEtoW9Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=rChJtocKo4bMW/1y+Kn72jq/xKQfqksFYUnKlxpxWJp0TNBkGQ3U5vx7IbXIP2rlh
	 dxL07xwgPbkoZgyPX5s/uCCG7s0ov20IlSepP8rtuPQmFUTj6zX9HAVFAnrEUGM6HU
	 bS4BB2qu/WfhI4pVSR6MhEBeDucApMZzD29ufNGovAm7GTD7PNewI76N95bNvsqGSX
	 CkJfMmMJnHJzVNNK7unPfvqW4A0qccnI9INoUdC6lYl+YO/1hhMRGXO4yRnuZsl7FC
	 NEPGvPplN0xEq7UXEhvmjRGu5DYntIKRS3//uXUAXEte7jpJ9WoQw73lcWUyDcGtdy
	 zK/EST8v4z3CA==
Date: Fri, 14 Nov 2025 17:43:29 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v4 mptcp-next 5/6] mptcp: better mptcp-level RTT
 estimator
In-Reply-To: <bf25344f52c064882ade22ceafec095d4dead682.1762940290.git.pabeni@redhat.com>
Message-ID: <b1660aec-6b7e-4c71-d121-b570085ffb65@kernel.org>
References: <cover.1762940290.git.pabeni@redhat.com> <bf25344f52c064882ade22ceafec095d4dead682.1762940290.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 12 Nov 2025, Paolo Abeni wrote:

> The current MPTCP-level RTT estimator has several issues. On high speed
> links, the MPTCP-level receive buffer auto-tuning happens with a frequency
> well above the TCP-level's one. That in turn can cause excessive/unneeded
> receive buffer increase.
>
> On such links, the initial rtt_us value is considerably higher
> than the actual delay, and the current mptcp_rcv_space_adjust() updates
> msk->rcvq_space.rtt_us with a period equal to the such field previous
> value. If the initial rtt_us is 40ms, its first update will happen after
> 40ms, even if the subflows see actual RTT orders of magnitude lower.
>
> Additionally, setting the msk rtt to the maximum among all the subflows
> RTTs makes DRS constantly overshooting the rcvbuf size when a subflow has
> considerable higher latency than the other(s).
>
> Finally, during unidirectional bulk transfers with multiple active
> subflows, the TCP-level RTT estimator occasionally sees considerably higher
> value than the real link delay, i.e. when the packet scheduler reacts to
> an incoming ack on given subflow pushing data on a different subflow.
>
> Address the issue with a more accurate RTT estimation strategy: the
> MPTCP-level RTT is set to the minimum of all the subflows, in a rcv-win
> based interval, feeding data into the MPTCP-receive buffer.
>
> Use some care to avoid updating msk and ssk level fields too often and
> to avoid 'too high' samples.
>
> Fixes: a6b118febbab ("mptcp: add receive buffer auto-tuning")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v3 -> v4:
>  - really refresh msk rtt after a full win per subflow (off-by-one in prev
>    revision)
>  - sync mptcp_rcv_space_adjust() comment with the new code
>
> v1 -> v2:
>  - do not use explicit reset flags - do rcv win based decision instead
>  - discard 0 rtt_us samples from subflows
>  - discard samples on non empty rx queue
>  - discard "too high" samples, see the code comments WRT the whys
> ---
> include/trace/events/mptcp.h |  2 +-
> net/mptcp/protocol.c         | 77 ++++++++++++++++++++++--------------
> net/mptcp/protocol.h         |  7 +++-
> 3 files changed, 55 insertions(+), 31 deletions(-)
>
> diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
> index 0f24ec65cea6..d30d2a6a8b42 100644
> --- a/include/trace/events/mptcp.h
> +++ b/include/trace/events/mptcp.h
> @@ -218,7 +218,7 @@ TRACE_EVENT(mptcp_rcvbuf_grow,
> 		__be32 *p32;
>
> 		__entry->time = time;
> -		__entry->rtt_us = msk->rcvq_space.rtt_us >> 3;
> +		__entry->rtt_us = msk->rcv_rtt_est.rtt_us >> 3;
> 		__entry->copied = msk->rcvq_space.copied;
> 		__entry->inq = mptcp_inq_hint(sk);
> 		__entry->space = msk->rcvq_space.space;
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 4f23809e5369..9a0a4bfa25e6 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -870,6 +870,42 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
> 	return moved;
> }
>
> +static void mptcp_rcv_rtt_update(struct mptcp_sock *msk,
> +				 struct mptcp_subflow_context *subflow)
> +{
> +	const struct tcp_sock *tp = tcp_sk(subflow->tcp_sock);
> +	u32 rtt_us = tp->rcv_rtt_est.rtt_us;
> +	u8 sr = tp->scaling_ratio;
> +
> +	/* MPTCP can react to incoming acks pushing data on different subflows,
> +	 * causing apparent high RTT: ignore large samples; also do the update
> +	 * only on RTT changes
> +	 */
> +	if (tp->rcv_rtt_est.seq == subflow->prev_rtt_seq ||
> +	    (subflow->prev_rtt_us && (rtt_us >> 1) > subflow->prev_rtt_us))

Hi Paolo -

It's still this "ignore the new rtt for this subflow if it more than 
doubles" clause that concerns me. subflow->prev_rtt_us is only used in 
this function, and it seems like there will be cases (especially with low 
rtt values) where this could ratchet down and get stuck at a low value. 
This would make the subflow get ignored forever for msk-level rtt updates. 
If there's only one subflow then the msk rtt could become constant.

Is the TCP-level rtt noisy/random enough that this is unlikely to happen?

Are there other characteristics of the "apparent high RTT" that would 
allow us to avoid this ratcheting-down behavior? For example, if the 
"apparent high RTT" was usually just one high outlier it might make sense 
to set subflow->prev_rtt_us = 0 when this condition is detected so the 
value will get reinitialized on a later sample.

- Mat


> +		return;
> +
> +	/* Similar to plain TCP, only consider samples with empty RX queue. */
> +	if (!rtt_us || mptcp_data_avail(msk))
> +		return;
> +
> +	/* Refresh the RTT after a full win per subflow */
> +	subflow->prev_rtt_us = rtt_us;
> +	subflow->prev_rtt_seq = tp->rcv_rtt_est.seq;
> +	if (after(subflow->map_seq, msk->rcv_rtt_est.seq)) {
> +		msk->rcv_rtt_est.seq = subflow->map_seq + tp->rcv_wnd *
> +				       (msk->pm.extra_subflows + 1);
> +		msk->rcv_rtt_est.rtt_us = rtt_us;
> +		msk->scaling_ratio = sr;
> +		return;
> +	}
> +
> +	if (rtt_us < msk->rcv_rtt_est.rtt_us)
> +		msk->rcv_rtt_est.rtt_us = rtt_us;
> +	if (sr < msk->scaling_ratio)
> +		msk->scaling_ratio = sr;
> +}
> +
> void mptcp_data_ready(struct sock *sk, struct sock *ssk)
> {
> 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
