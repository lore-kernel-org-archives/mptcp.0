Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AF84F7CC4;
	Mon, 21 Sep 2026 18:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015956; cv=none; b=GNrfrBqxoM1ipdaiObxrjX2ATezpdBxVP6OhTaCiiRRAjYSiO7hvl+FunDxDT0s4BttKibHOOtm7PhsNoNl0C/6+BtOb257h9JfohiW9RLpDPu+EtHrW8A0tlpYKcpN5yedaqiRKH+ot4ybITq9mRPR5xyfUIjFpFvwRBaWawwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015956; c=relaxed/simple;
	bh=olsD80mMDlFuGYVeYchcMqcZveypPBx6KFTLIMfnjFI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EvkedZ+fCUGvsSGg2RhT1QbnPFf5/hyIuTvN7I+3y3d4ovSKIA4w7qSl7tEoGaHkefn5GwpB5kwt+98FnZ8XEy4seo0ncNwhuDSxYt70rsnR945h6G8qvrSVUmn8aYtDEjbrmG0v8U2FeCI09gcZTwYu8p4wO55g0TPnszPKI+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKMS/rgL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKMS/rgL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CFC61F000FF;
	Mon, 21 Sep 2026 18:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790015952;
	bh=hmFoNOaYgnKI62IvYdNCaoJ9gU/3laqa9xZtEOHnT5Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aKMS/rgLxGm5ThY4AIVMJokRbpuU/3jknVvjqsOFiz1uxZV6cYjx0vSqYmVC4/gNb
	 GbmD0OKCefLz+HPb34xWKsofV9wwPuQ5+2DihSEcvz3WtnyGxy++vr1MoFgt0Brm4q
	 0uV7gWkcifoiQbf+nPDLTRRMUoYe8wY0/aW19OfkJI4N5jEvUYEg39/9jX95FlTvG2
	 noeOVI+Tj0h0L/tEHX6c0BlUBGy11e9ngI5kLEHQoy9J1Ageq0h7zQM251YgeYWGlp
	 zW7+Iq9WC0MLiwqUTpqFObuFIr5WqUW7l8go6D4AXwNPGa6uFxlJuy2qrjLzKwdUST
	 iIJikNwEiSmFw==
Subject:
 Re: [PATCH net-next 1/4] mptcp: support MSG_ERRQUEUE on the parent socket
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 devnexen@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org
Date: Mon, 21 Sep 2026 18:39:11 +0000
Message-ID: <179001595171.2160803.3670624686905872378@kernel.org>
In-Reply-To:
 <20260918-net-next-mptcp-msg_errqueue-v1-1-dd77e1738248@kernel.org>
References:
 <20260918-net-next-mptcp-msg_errqueue-v1-1-dd77e1738248@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new error-queue splice is dead code for MPTCP-native data:
  its only accepted input (SO_EE_ORIGIN_TIMESTAMPING skbs on a subflow…
- [Medium] Forwarded TX timestamps expose per-subflow identifiers instead
  of parent-socket byte-stream identifiers, breaking the…

--

mptcp: support MSG_ERRQUEUE on the parent socket

This moves pending error skbs from each subflow's error queue onto the
parent msk error queue at error-report time, keeping only
SO_EE_ORIGIN_TIMESTAMPING events and dropping subflow ICMP errors.  It
also makes mptcp_poll() report EPOLLERR when the parent error queue is
non-empty, and drops the stale comment in front of the MSG_ERRQUEUE
branch of mptcp_recvmsg().

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index e89a69ab927c..15ae270ee6fd 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -919,21 +920,52 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
>  	return moved;
>  }
>  
> +static bool mptcp_errqueue_skb_forwardable(const struct sk_buff *skb)
> +{
> +	/* Subflow-level ICMP errors are dropped: the legacy RECVERR ABI
> +	 * cannot convey their per-subflow peer identity.
> +	 */
> +	return SKB_EXT_ERR(skb)->ee.ee_origin == SO_EE_ORIGIN_TIMESTAMPING;
> +}
> +
> +static bool __mptcp_subflow_splice_errqueue(struct sock *sk, struct sock *ssk)
> +{
> +	struct sk_buff *skb;
> +	bool moved = false;
> +
> +	while ((skb = skb_dequeue(&ssk->sk_error_queue))) {

[Severity: Medium]
Is there anything today that can put a SO_EE_ORIGIN_TIMESTAMPING skb on a
subflow's sk_error_queue?

mptcp_errqueue_skb_forwardable() accepts only ee_origin ==
SO_EE_ORIGIN_TIMESTAMPING, and the producers of those events
(skb_tx_timestamp() in drivers, the SKBTX_SCHED_TSTAMP check in
__dev_queue_xmit(), and tcp_ack_tstamp() -> __skb_tstamp_tx()) all key off
per-skb state: skb_shinfo(skb)->tx_flags, skb_shinfo(skb)->tskey and
TCP_SKB_CB(skb)->txstamp_ack.

Those bits are set by tcp_tx_timestamp(), which is only reached from
tcp_sendmsg_locked().  mptcp_sendmsg_frag() builds the subflow skbs itself:

	skb = mptcp_alloc_tx_skb(sk, ssk, info->data_lock_held);
	...
	TCP_SKB_CB(skb)->end_seq += copy;

so it never goes through tcp_sendmsg_locked() and never arms timestamping.
The fastopen path is not an exception either, since
mptcp_sendmsg_fastopen() calls tcp_sendmsg_fastopen() directly.  A
"git grep -E 'tx_timestamp|tskey|txstamp_ack|tsflags' net/mptcp/" finds no
arming site.

If that reading is right, then __mptcp_subflow_splice_errqueue() always
returns false for real traffic, and the commit message statement

  "so poll() and recvmsg(MSG_ERRQUEUE) on the parent socket observe TX
   timestamps through the standard inet ABI"

does not hold yet: recvmsg(MSG_ERRQUEUE) on the parent still returns
-EAGAIN.  Note that mptcp_setsockopt_sol_socket_timestamping() in
net/mptcp/sockopt.c does accept SO_TIMESTAMPING_OLD/NEW and replicates it
to every subflow via sock_set_timestamping(), so the configuration side
advertises something the transmit side does not implement.

The last patch in this series ("selftests: mptcp: cover IP_RECVERR sockopt
propagation") acknowledges this, saying end-to-end errqueue delivery
depends on subflow-side producers that are out of scope for the series.
Could this commit message be reworded the same way, so it describes the
plumbing rather than claiming the observable behaviour?

> +		/* sock_queue_err_skb() re-homes skb->sk onto the parent and
> +		 * charges sk_rmem_alloc, bounding the queue by sk_rcvbuf.
> +		 */
> +		if (!mptcp_errqueue_skb_forwardable(skb) ||
> +		    sock_queue_err_skb(sk, skb)) {

[Severity: Medium]
Once producers do exist, will the forwarded ee_data still mean anything on
the parent socket?

__skb_complete_tx_timestamp() fills the identifier from the originating
socket's counters:

	if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID) {
		serr->ee.ee_data = skb_shinfo(skb)->tskey;
		if (sk_is_tcp(sk))
			serr->ee.ee_data -= atomic_read(&sk->sk_tskey);
	}

so ee_data is relative to the subflow's sk_tskey and TCP sequence space.
mptcp_setsockopt_sol_socket_timestamping() enables timestamping on the msk
and on each subflow separately, giving every subflow its own baseline.

__mptcp_subflow_splice_errqueue() re-homes the skb without translating
ee_data into the msk write_seq space.  With two or more subflows, does
userspace reading MSG_ERRQUEUE on the parent then see duplicate or
unrelated identifiers for one socket?  Documentation/networking/
timestamping.rst describes SOF_TIMESTAMPING_OPT_ID as unique among
outstanding timestamp requests for that socket, and byte-incrementing for
stream sockets.

Even with a single subflow the value is relative to the subflow's TCP
sequence space rather than msk->write_seq.  Would remapping ee_data here
require replacing the plain re-home rather than extending it later?

> +			kfree_skb(skb);
> +			continue;
> +		}
> +		moved = true;
> +	}
> +
> +	return moved;
> +}
> +

[ ... ]

> @@ -4523,7 +4559,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
>  
>  	/* This barrier is coupled with smp_wmb() in __mptcp_error_report() */
>  	smp_rmb();
> -	if (READ_ONCE(sk->sk_err))
> +	if (READ_ONCE(sk->sk_err) ||
> +	    !skb_queue_empty_lockless(&sk->sk_error_queue))
>  		mask |= EPOLLERR;
>  
>  	return mask;

With the splice unable to fire for MPTCP-native data, can this new
sk_error_queue term ever become true through the path described in the
commit message?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918-net-next-mptcp-msg_errqueue-v1-0-dd77e1738248%40kernel.org
