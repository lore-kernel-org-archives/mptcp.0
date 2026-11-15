Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794739988;
	b=cxX/Khd7XVKuV6+3MhVsZ/jVajxwbV8Ydu+PlM1MX1qA/BYIMwV1jXAttyFP8wkbSpSF
	 hUV/9HMRtxqzgjNMwtkB9VtP4twClbeLW3Ccj3cGGuPz4BficXE5NorKNzQ5xxv5xIDgp
	 tysiTVFzj9q54nC1fly0onw3DtgIkeVuDfidZM2Q6HuakP7MApwVTkQf+Rkci8pveVktS
	 0+koqyrMRRpPOZdDnDUb/roPnnFGUIk/TFHvi5obYU3MWrmrnekHNzDEOjonrxaWbaVFJ
	 QAZQUsXftIt0cbfwhbJrkWGbVMGAQpdcve0SeA8wm9CuKhjWnoA/Etv8X4Cev1EKGgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794739988;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ec4lAoC6x9D+FkC9J36AcC0rBZ1YufbeMB7Qrr+O4RU=;
	b=gYiwAx7HrBIr0qHf0qe/lN1fMLr+loifsVJvqrC9Dwju9G7Kmur/9WWKbza2ZnYgtdn/
	 2/FE0/ORCx0w7BiA7buv6WHanOA5gfwSh5KQ2S4opxWSr+c7VygxB3hT2gQEEpQXdVBKP
	 3EaAtpQO/wZ0LILgSN/OsFX6dHlWhYI4GojMU2eauv/lPdSYcFssWJs7Y6TUGwic5rv14
	 BjqpDAkSoBizczR1XuacCVOj4IzdxcaVEUUfNeolSyMUS3wlKb/umXUSkDNkTKwo8iMdG
	 0wCF2VnZ0rHHlTzYFcaAiEANXpyai6+CoNYVncluW7qxl3xV7sR3GkmgjlzZ47ITPmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mcB+Q3Bd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F259606A31A
	for <mptcp@lists.linux.dev>; Sun, 15 Nov 2026 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mcB+Q3Bd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D951F000C7;
	Sun, 15 Nov 2026 10:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794739987;
	bh=ec4lAoC6x9D+FkC9J36AcC0rBZ1YufbeMB7Qrr+O4RU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mcB+Q3BdKKRs/xj8uvNQenXw8xTS+e/dJzq0NDQ0EL9q+8j73/IVoMkXdwobtH+1a
	 ghihymebVaqADY8xBZvFM7ttO1JNFF2t+uKEgYbByZAPUTyeAkYjQl3BvjkIwdAfWU
	 TFuYbIBIZjpt0Y8N+GDZgIdCzrnBFWmI8jir6hkq47o7BWViC2ba0bDMlOSV+mTPcK
	 y9+EQAJ+u3YA4M/hKzuyyAIZ6+FYPO08et1D7koCLwlDkUQM0tKam87dsulYM17ryy
	 oAxRd0RVTv/LypLfXXuYOVCFOpobmKUpBRLv1vkHDVIwE4k3UQQV7L/IhsvRhgkhPs
	 12dDLTGM3EsmQ==
Subject: Re: [PATCH mptcp-net 06/34] mptcp: pm: don't drop an RM_ADDR because
 of an ADD_ADDR
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc:
 mptcp@lists.linux.dev, mason@kernel.org, pabeni@redhat.com, kuba@kernel.org
Date: Sun, 15 Nov 2026 10:53:07 +0000
Message-ID: <179473998707.488855.15378426192045808798@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-6-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-6-9205b77e9a2f@kernel.org>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The RM_ADDR that this patch now leaves pending behind an
  ADD_ADDR/echo has no reliable carrier, so a removal in the window the…
- [Medium] After this patch an RM_ADDR that has to wait behind a pending
  ADD_ADDR or echo loses the rule from commit 2f79a7def595 ('avoid…

--

mptcp: pm: don't drop an RM_ADDR because of an ADD_ADDR

This patch relaxes the check in mptcp_pm_remove_addr(). An RM_ADDR is now
refused only when another RM_ADDR is pending, not whenever any bit of
pm.addr_signal is set. A pending ADD_ADDR or echo goes out first, and the
RM_ADDR is expected to follow with the next packet.

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 32885e80486ee..5f844b9a32d81 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -529,7 +529,7 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
>  
>  	pr_debug("msk=%p, rm_list_nr=%d\n", msk, rm_list->nr);
>  
> -	if (rm_addr) {
> +	if (mptcp_pm_should_rm_signal(msk)) {
>  		MPTCP_ADD_STATS(sock_net((struct sock *)msk),
>  				MPTCP_MIB_RMADDRTXDROP, rm_list->nr);
>  		return -EINVAL;

[Severity: Medium]
When an ADD_ADDR or echo is pending, which subflow carries this RM_ADDR on
the in-kernel PM endpoint removal path?

mptcp_pm_remove_addr() sets the RM bit and calls
mptcp_pm_addr_send_ack_avoid_list(). That picks a subflow that is not in
rm_list and sends one pure ACK. mptcp_established_options() checks
ADD_ADDR first:

net/mptcp/options.c:mptcp_established_options() {
    ...
	if (mptcp_established_options_add_addr(sk, skb, &opt_size, remaining,
					       has_ts, opts)) {
		...
	} else if (mptcp_established_options_rm_addr(sk, &opt_size, remaining, opts)) {
    ...
}

So that ACK carries the ADD_ADDR or echo, and the RM bit stays set.

Right after that, mptcp_nl_remove_subflow_and_signal_addr() shuts down the
matching subflows:

mptcp_nl_remove_subflow_and_signal_addr()
  mptcp_pm_remove_announced()
    mptcp_pm_remove_addr()       <- RM bit left pending
  mptcp_pm_rm_subflow()
    mptcp_pm_rm_addr_or_subflow()
      mptcp_subflow_shutdown()
        tcp_send_ack(ssk)        <- DATA_FIN ACK on the removed subflow

No ADD is pending any more at that point, so
mptcp_established_options_rm_addr() puts the RM_ADDR into this DATA_FIN
ACK. That ACK goes out on the subflow being removed.

Doesn't this get around the rule from commit 2f79a7def595 ("mptcp: avoid
sending RM_ADDR over same subflow")? That commit says endpoints are
"likely removed because the attached network is no longer available". In
that case the pure ACK is lost and is not retransmitted. The RM bit has
already been cleared, so the peer still never learns that the address is
gone.

This is no worse than before the patch, when the RM_ADDR was dropped
outright. But it leaves part of the targeted case unfixed.

The commit message says:

    The ACK that is sent at once carries the ADD_ADDR or the
    echo then, and the RM_ADDR goes with the next packet, e.g. the ACK that
    the PM worker sends for the pending echo.

On this path, isn't the next packet the DATA_FIN ACK on the removed
subflow, which is sent before the PM worker runs?

[Severity: High]
What guarantees that this deferred RM_ADDR actually gets sent?

The only transmission triggered here is the avoid-list ACK, and that ACK
takes the pending ADD_ADDR or echo. Worker ACKs are only scheduled for the
ADD bits:

net/mptcp/pm.c:mptcp_pm_add_addr_send_ack() {
	if (!mptcp_pm_should_add_signal(msk))
		return;

	mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
}

Both ECHO and SIGNAL can be pending at once, for example an ADD_ADDR
retransmit from mptcp_pm_add_addr_timer() plus a received ADD_ADDR. Then
the immediate ACK takes the echo, the single worker ACK takes the SIGNAL,
and nothing is scheduled for the RM_ADDR.

The same applies when a SIGNAL bit was left pending with no worker
scheduled. That happens when the ACK at announce time could not carry it,
e.g. there was no active subflow or tcp_can_send_ack() was false.

On an idle connection, would the RM_ADDR ever go out?

While it stays pending, every later mptcp_pm_remove_addr() call hits the
new mptcp_pm_should_rm_signal() check. Each one counts RMADDRTXDROP and
returns -EINVAL. These callers all ignore that return value:

mptcp_pm_remove_announced()
mptcp_nl_remove_id_zero_address()
mptcp_pm_flush_addrs_and_subflows()
mptcp_userspace_pm_remove_addr_entry()
mptcp_userspace_pm_remove_id_zero_address()

Are those later removals silently lost too?

Can the RM bit also be consumed without being sent? tcp_current_mss()
computes the header length with a NULL skb:

net/ipv4/tcp_output.c:tcp_current_mss() {
    ...
	header_len = tcp_established_options(sk, NULL, &opts, &key) +
		     sizeof(struct tcphdr);
    ...
}

mptcp_established_options_add_addr() returns false for a NULL skb, so
mptcp_established_options_rm_addr() runs. That function has no skb check,
and mptcp_pm_rm_addr_signal() clears BIT(MPTCP_RM_ADDR_SIGNAL) and counts
RMADDRTX:

net/mptcp/pm.c:mptcp_pm_rm_addr_signal() {
    ...
	*size = len;
	*rm_list = msk->pm.rm_list_tx;
	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
	ret = true;
    ...
}

The NULL skb behaviour is older than this patch. Before it, though, the
RM bit was set and sent in the same call. Now the RM_ADDR can stay pending
much longer. Any data push on any subflow before the worker ACK could
clear it without putting it on the wire: tcp_push_pending_frames(),
tcp_send_mss() in mptcp_sendmsg_frag(), or a retransmit.

This also looks like a new ordering problem with the userspace PM.
mptcp_pm_announce_addr() only checks its own bit. Suppose a peer echo is
pending and userspace removes and then re-announces ID X before the
worker runs:

userspace removes ID X
  mptcp_userspace_pm_remove_addr_entry()
    mptcp_pm_remove_addr()         <- ACK carries the echo, RM(X) pending
userspace re-announces ID X
  mptcp_pm_nl_announce_doit()
    mptcp_pm_announce_addr(..., false)
    mptcp_pm_addr_send_ack()       <- ACK carries ADD(X), ADD wins
PM worker
  mptcp_pm_addr_send_ack()         <- ACK carries the stale RM(X)

The peer would then process RM(X) after ADD(X) in
mptcp_pm_rm_addr_or_subflow(). It would drop an address that is still
valid locally and close its subflows with remote_id == X. Before this
patch, RM(X) was dropped and the peer ended up with X valid.

The commit message says the RM_ADDR "goes with the next packet". Would
closing this gap need more than relaxing the check? Two options would be
to schedule a worker ACK whenever the RM_ADDR is deferred, or to stop an
option size computation with a NULL skb from consuming it.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f%40kernel.org
