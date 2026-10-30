Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793324270;
	b=HyVBp8xRUyLl5J8kykCElzNXiR5sk9ufJjVFh440EAftyCF0EXL93FrhD4wT8jF//6Nv
	 KIVhLT560Z2oCLSNXD2EdfR3gCBsirabqcga6etopg0IlTWqx1x4ME1zWDwJ20FFky8Sc
	 Krm4A5zrQ2JIqszUzctQo2AzBX5eaoNWfBi1xUnxiiCjwVILh9L3OmSZDh83oXU3ToCAq
	 zZWzO49ZzcCKgcQhPg410l+831S+upljGNDdIHdJBKQh6fySwUPuoXpiftOJjTn/9dbnn
	 9DxZxpZUC+lt8tUpxdiiilAjBoAsMrIRQSLVu/x7flVLfEGFh+wudNxcaAlHBVq4+xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793324270;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=9V+1kx9OJDTws/jau8bbDEUhbBaMuAMGwO7L+9KlkPk=;
	b=VP32a7OxDjWKAj+hb57Wpt6qzApBhyDsI51fLzTiI+n/X6aMsSlcce/vd4LA3MMnyTJg
	 JoP6b5ktcICu/xWtubBIkL1tqeT6TU46qEPeChlYnoThFWI010iYEcvHeW2yp9WtTgtnC
	 CNpSaGaYB+buKy29vjSgU4VNfkiHES1yhrfcn7ilWS472dhEbVmGZb/ruonFwYIIQeb8L
	 ++q4IaRUgEFZiW3An7LXnu7AQ8MHqXVlOdK/jXO6+EHmQpuEx6SCjJ+gOYMhHtk7SD+pe
	 3n3+rEr41aG1kuxTF8KMol+x3GVrVRP81Lbg9adIokX2fCKCawwtWC+PVS4wDwhnTPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fwhI7Q0x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB23606A31A
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 01:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fwhI7Q0x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26DD1F000C1;
	Fri, 30 Oct 2026 01:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793324269;
	bh=9V+1kx9OJDTws/jau8bbDEUhbBaMuAMGwO7L+9KlkPk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fwhI7Q0xo6vNBvnwQftycHOOIjyvcJMO4WPbm+OPnEUflp3QKc4+lRoWhCUX+KPRS
	 wj6paFVa09W8jB0xVSDfqI0D/o/jhVobmLtusyyq4NRRVh5iPzREUqegpfPyX9n3YR
	 l33DjTueU8EbTcLc+idkg3DCMFy4xhYJPh0mXXOKg1BuNcQvdR1TBHr/q5JPCeBDFH
	 F45UOBuO6ST8+p/SC9KnpIcuofzx3N9FCNsHfR9yia0RSc+AKyaBFQMwOPdJaFKWhE
	 mGhM+85t2b7g74DWaP9Y8YrmVSccNSvVKrQecXvvGvb24QoW156YSlkmgaZ3ZWMc3p
	 e83pDrUC9YCZA==
Subject: Re: [PATCH mptcp-next v5 3/4] mptcp: sched: do not penalise when
 receive-window-limited
From: netdev-bot+sashiko@kernel.org
To: shardul.b@mpiricsoftware.com
Cc: mptcp@lists.linux.dev, matttbe@kernel.org, janak@mpiric.us,
 kalpan.jani@mpiricsoftware.com, shardulsb08@gmail.com, w453y.me@gmail.com,
 kuba@kernel.org
Date: Fri, 30 Oct 2026 01:37:48 +0000
Message-ID: <179332426836.3132.10907231021496841665@kernel.org>
In-Reply-To:
 <20261028-mptcp_penalise_send_v2-v5-3-32fb379ce117@mpiricsoftware.com>
References:
 <20261028-mptcp_penalise_send_v2-v5-3-32fb379ce117@mpiricsoftware.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new gate does not test for receive-window limitation, even
  though its comment and the commit message say it does.
- [Low] mptcp_snd_wnd_test() is evaluated only when
  mptcp_subflow_get_send() sets subflow->penalise (line 1761).

--

mptcp: sched: do not penalise when receive-window-limited

This patch adds mptcp_snd_wnd_test(), which compares msk->write_seq with
mptcp_wnd_end(). It uses the result to gate the cwnd penalty flag set in
mptcp_subflow_get_send(). The goal is to skip halving a slow subflow's cwnd
when the receiver's advertised window, not cwnd, is the bottleneck.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 395f9582ece89..5eef96fa4f3e0 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1642,6 +1642,14 @@ static bool mptcp_penalise_throttle_ok(struct mptcp_subflow_context *subflow)
>  	return tcp_jiffies32 - subflow->last_penalise >= max_t(u32, rtt, 1);
>  }
>  
> +/* Like tcp_snd_wnd_test() but without an skb: true while queued data still fits
> + * the send window, i.e. not receive-window-limited.
> + */
> +static bool mptcp_snd_wnd_test(const struct mptcp_sock *msk)
> +{
> +	return !after64(msk->write_seq, mptcp_wnd_end(msk));
> +}

[Severity: Medium]
Does this predicate actually detect a receive-window-limited connection?

tcp_snd_wnd_test() only checks whether the first segment of the head skb
fits the window:

net/ipv4/tcp_output.c:tcp_snd_wnd_test() {
	u32 end_seq = TCP_SKB_CB(skb)->end_seq;

	if (skb->len > cur_mss)
		end_seq = TCP_SKB_CB(skb)->seq + cur_mss;

	return !after(end_seq, tcp_wnd_end(tp));
}

mptcp_snd_wnd_test() instead compares the tail of the whole application
backlog (write_seq) with wnd_end. Is the "Like tcp_snd_wnd_test()" comment
accurate, then?

mptcp_subflow_get_send() already checks the send point:

	burst = min(MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);

When burst is 0, penalise is already cleared. So the new term only makes a
difference when snd_nxt < wnd_end < write_seq. In that state the window
still has room and fast_limited says the fastest subflow is cwnd-limited.
Isn't that the case the previous patch was meant to handle?

The commit message says:

    If the application has queued
    past the window edge the receive window is the binding constraint, so skip
    the penalty.

Does this hold for bulk senders? mptcp_sendmsg() advances write_seq by the
whole copied amount before it pushes anything:

	WRITE_ONCE(msk->write_seq, msk->write_seq + psize);

The copy is limited by mptcp_send_limit(), not by the peer window:

	if (sk->sk_wmem_queued >= READ_ONCE(sk->sk_sndbuf))
		return 0;

notsent_lowat defaults to UINT_MAX, so it does not add a limit either.

Take an 8 MiB SO_SNDBUF, a 1 MiB rwnd and 64 KiB in flight on a
cwnd-limited fastest subflow. write_seq ends up past wnd_end, so the
penalty never fires, even though the receive window is not the limit.

The msk sk_sndbuf is tcp_wmem[0] plus the sum of the subflow sndbufs. Would
this switch off the penalty for most bulk transfers? If so, the predicate
probably needs to change, not just the comment.

[ ... ]

> @@ -1750,7 +1758,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
>  	burst = min(MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
>  	wmem = READ_ONCE(ssk->sk_wmem_queued);
>  	/* the conditions on this subflow are re-checked on apply, under its lock */
> -	subflow->penalise = burst && fast_limited;
> +	subflow->penalise = burst && fast_limited && mptcp_snd_wnd_test(msk);

[Severity: Low]
The window test is only evaluated here, and its result is cached in
subflow->penalise. __subflow_push_pending() later uses the flag through
mptcp_penalise_cwnd(). That function re-checks only subflow-local
conditions:

	subflow->penalise = false;
	if (cwnd <= MPTCP_PENALISE_MIN_CWND ||
	    inet_csk(ssk)->icsk_ca_state != TCP_CA_Open ||
	    !mptcp_penalise_throttle_ok(subflow))
		return;

Can a flag set while write_seq <= wnd_end be applied after write_seq has
moved past wnd_end? One possible sequence:

__mptcp_subflow_push_pending()
   mptcp_subflow_delegate(subflow, MPTCP_DELEGATE_SEND)

mptcp_sendmsg()
   advances write_seq past wnd_end

__mptcp_push_pending()->mptcp_sched_get_send()
	mptcp_for_each_subflow(msk, subflow) {
		if (READ_ONCE(subflow->scheduled))
			return 0;
	}

mptcp_subflow_process_delegated()->__mptcp_subflow_push_pending() can
also reach the same path.

This looks consistent with the previous patch's design. There, msk-level
inputs such as burst and fast_limited are snapshotted at scheduling time,
and only subflow-local conditions are re-checked on apply. The worst case
seems to be one extra cwnd halving, limited to once per RTT.

Is it intended that the new window condition can go stale in the same way?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028-mptcp_penalise_send_v2-v5-0-32fb379ce117%40mpiricsoftware.com
