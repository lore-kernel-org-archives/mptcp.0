Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795735794;
	b=wMKDMay5mMAXuT8Q4vlJnLWkQlNdoDfrAeaCuHV5Kc/kkPh3f+IhtFtBJLrMbZXD8BG7
	 Zfoi0ccTk2qZ5zLSKEBgG4SYQfiEyU3wnOxBRWAp+dLR8vSBhVY1YqPfsRGS+jJpJcVXI
	 tfruG9EHZ+d1O56D+nkDkkjXyYIs/V0P6IMPbN/fqkI36upSnUn3js5IQBo7dI6iagMu9
	 TwLWh/5FmKCjs5e3s0eQJUgFntfshpy3SvaV3aTouXmPPzmuuG0B7ol9yzZTo2NHlDi31
	 olJfsqCi+7dd5iHNn+G3ho3NZK4zsLU3A7RaQcWNHvuChocMcc08emKieDsQqpFdQHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795735794;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=GrJsTVCV5iXDhoYKH4Mu017SrXtovaEt6A28iTVjnNc=;
	b=083HyiMDVJtDJasrXnlveXWE9IOsyZ5orcZYDIjvWR1twf+yDlYAx2kC1XN08S2jAuZt
	 DY0Yo5RpYN0FGfKTvsPH9LaUpiWf8tYPycSkLVxUNAMP98XPrLVJrQkKcyPfjcVVNX3Cb
	 BemSZayuRWsNGJa3ANWfPNyyE5Wt4dl61Gyk2GroAuPJEBvmPI+7oKJASpYMFGZWZryY5
	 DspDw/c52gR7NrnSkVDVSZvG+KYE/G0mP7sQzrO/Dqy3i/0PLbdBj7FGjcyZkXOHGcKoQ
	 rhex3IyNa24p708fGbykGwknCIA+WC1sUNcIAY62h8oBn2jwG1tZ3miXTKkRa8RGixg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YqNivcOP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12CA606A31C
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 23:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YqNivcOP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60B31F00893;
	Thu, 26 Nov 2026 23:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795735794;
	bh=GrJsTVCV5iXDhoYKH4Mu017SrXtovaEt6A28iTVjnNc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YqNivcOPS7WmmRonAeQ34HL/D7zuW4V41trhR1elkDwZvxMFOoi1Y4HGB6J8Z4QJa
	 mA8L7pxSreG7fT87n9Es9qINXz3m+u4YzZfF8X0gdQRPDYYby82dB4rvrzcslkBZBw
	 MCmpzvIK/mx6cb/46M9TTmAWmZBH9Wq6eNSFhelPoV+wi1DHgiVMNVAatEYsR9OfgP
	 EQOV8zcVRphSfSyNPT3tDaYEvaL4seVdo847MWGD1WCWj0KQoddO1/aMXXMWmjZlia
	 metlxgGhK7Duow+hlDDepQC3U95mmwZx2/fNCPUFqv1aEtMQjXtdVZ2DMD+JQu1kwN
	 iBVJ/a1HvricQ==
Subject: Re: [PATCH mptcp-net v3 37/50] mptcp: keep the first byte after a
 simult connect
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Thu, 26 Nov 2026 23:29:53 +0000
Message-ID: <179573579346.3133.9770579761176811228@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-37-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-37-416c0920c73f@kernel.org>
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

- [High] The fix is incomplete: there is still a simultaneous-connect
  path where ssn_offset ends up wrong, and on that path the patch makes…
- [Medium] mptcp: mptcp_syn_options() sets ssn_offset on MP_JOIN simult
  connect

--

mptcp: keep the first byte after a simult connect

After a simultaneous connect, this patch sets subflow->ssn_offset in
mptcp_syn_options() when the crossed SYN-ACK is sent from SYN_RECV.
subflow_finish_connect() now takes ssn_offset only from a SYN. The first
non-SYN packet received in ESTABLISHED no longer overwrites it, so the
first received byte is kept.

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 05b9c66aaed63..41eb39968a9a6 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -474,6 +474,11 @@ bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
>  	 * in mptcp_established_options_mp()
>  	 */
>  	subflow->snd_isn = TCP_SKB_CB(skb)->end_seq;
> +
> +	/* simult connect: the peer's SYN-ACK will not set ssn_offset */
> +	if (unlikely(sk->sk_state == TCP_SYN_RECV))
> +		subflow->ssn_offset = tcp_sk(sk)->rcv_nxt - 1;
> +
>  	if (subflow->request_mptcp) {
>  		if (unlikely(subflow_simultaneous_connect(sk))) {
>  			WARN_ON_ONCE(!mptcp_try_fallback(sk, MPTCP_MIB_SIMULTCONNFALLBACK));
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index f73e4b8deca42..439a11d92281b 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -591,7 +591,9 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
>  	subflow->rel_write_seq = 1;
>  	subflow->opt_ack_seq = tcp_sk(sk)->snd_una;
>  	subflow->conn_finished = 1;
> -	subflow->ssn_offset = TCP_SKB_CB(skb)->seq;
> +	/* simult connect: not a SYN-ACK, see mptcp_syn_options() */
> +	if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN)
> +		subflow->ssn_offset = TCP_SKB_CB(skb)->seq;

[Severity: Medium]
Does this assignment also need to be limited to the MPC case?

It is done for any subflow in TCP_SYN_RECV, before the request_mptcp
check. An active MP_JOIN subflow created by __mptcp_subflow_connect()
(request_join = 1, remote_key_valid = 1, mp_join = 0) can also receive
a crossed bare SYN while in TCP_SYN_SENT.
tcp_rcv_synsent_state_process() then sets rcv_nxt to the peer ISN + 1,
moves the socket to TCP_SYN_RECV and calls tcp_send_synack(). That ends
up here, so ssn_offset now becomes the peer ISN on the join subflow.
This path has no fallback and no reset, because
subflow_simultaneous_connect() is only checked under request_mptcp.

Suppose the peer then sends an ACK with seq == ssn_offset + 1.
tcp_rcv_state_process() moves the subflow from TCP_SYN_RECV to
TCP_ESTABLISHED without going through sk_rx_dst_set(), so
subflow_finish_connect() never validates the MP_JOIN handshake. The
same skb then goes through tcp_data_queue() -> mptcp_incoming_options()
-> check_fully_established().

Before this patch, ssn_offset was still 0 at that point, so the
"TCP_SKB_CB(skb)->seq != subflow->ssn_offset + 1" test returned early.
Now the test passes with mp_join == 0, and there are three outcomes:

- If the ACK carries a DSS with use_ack, or a non-echo ADD_ADDR, the
  remote_key_valid check jumps to set_fully_established without any
  HMAC validation. Any payload then triggers the WARN_ON_ONCE() in
  subflow_data_ready(), because neither mp_capable nor mp_join is set.

- If the ACK carries no MPTCP option, the subflow is not reset because
  mp_join is 0. Instead, mptcp_try_fallback(ssk,
  MPTCP_MIB_MPCAPABLEDATAFALLBACK) can make the parent msk fall back
  to TCP while allow_infinite_fallback is still true.

- If the ACK carries an MP_CAPABLE option on a client msk, it triggers
  WARN_ONCE(1, "bogus mpc option on established client sk").

A remote peer can drive all of this by crossing a SYN with one of our
MP_JOIN SYNs.

Should the new ssn_offset assignment move under the request_mptcp &&
subflow_simultaneous_connect() branch, where the fallback is actually
done? Or should an MP_JOIN subflow hitting a simultaneous connect be
reset instead?

[Severity: High]
Can ssn_offset stay at 0 here after a simultaneous connect?

With this change, mptcp_syn_options() is the only place that sets
ssn_offset for a simultaneous connect. It only runs if the crossed
SYN-ACK gets far enough to build its options. The return value of
tcp_send_synack() is ignored by its caller:

net/ipv4/tcp_input.c:tcp_rcv_synsent_state_process() {
    ...
		tcp_send_synack(sk);
    ...
}

tcp_send_synack() can fail before any option is built:

net/ipv4/tcp_output.c:tcp_send_synack() {
    ...
			nskb = skb_copy(skb, GFP_ATOMIC);
			...
			if (!nskb)
				return -ENOMEM;
    ...
}

The clone or copy in __tcp_transmit_skb() can also return -ENOBUFS
before tcp_syn_options() is reached.

When that happens, neither the new ssn_offset assignment nor the
SIMULTCONN fallback runs. Suppose the peer's crossed SYN-ACK then moves
the socket to ESTABLISHED before the RTO retransmits our SYN-ACK. The
next skb that subflow_finish_connect() sees is not a SYN, so ssn_offset
keeps its initial value of 0.

The later "mptcp: move to ESTABLISHED after a simult connect" change in
subflow_state_change() only applies when mptcp_check_fallback(sk) is
already true. It doesn't set ssn_offset either, so this path still
seems reachable at the end of the series.

With ssn_offset at 0, the fallback dummy mapping in
subflow_check_data_avail() becomes:

	subflow->map_subflow_seq = TCP_SKB_CB(skb)->seq - subflow->ssn_offset;
	subflow->map_seq = __mptcp_expand_seq(subflow->map_seq,
					      subflow->dsn_base +
					      subflow->map_subflow_seq - 1);

Every mapping is then off by the peer's ISN relative to msk->ack_seq,
which starts at 0 after the fallback.

Would the received data then be dropped as old, or left in the msk
out-of-order queue forever? It has already been acked at the TCP level,
so it would not be retransmitted.

Before this patch, this path lost one byte. After it, the whole receive
stream looks like it could be lost.

The v2 note below the '---' calls the allocation failure case
theoretical, but that note won't end up in the commit message.

Could subflow_finish_connect() keep a fallback assignment for non-SYN
skbs on this path? Another option would be to derive the peer ISN once
the socket reaches ESTABLISHED.

>  	pr_debug("subflow=%p synack seq=%x\n", subflow, subflow->ssn_offset);
>  
>  	mptcp_get_options(skb, &mp_opt);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261124-mptcp-cmason-fixes-v3-0-416c0920c73f%40kernel.org
