Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533994;
	b=WespfW0xbE4NsmA6NC/DpGGWgo/xtF1e0dbjDYGYbizetuyzNkHORq2nbQ0AH0YC9tLN
	 +lDIYKFaGRT1QjR//Fn+rCmGtzl5hptJws1h2KcPqA+NGFv1ypdUSCpr7sNmGybAziAwB
	 tox0V6BpCYMTwsXvM1mD93NKVg6ipSZGKM4B5O/V7H6V2zaMkB0+VifLmxANmYik5+AI1
	 AyDGqPzl4womo7jaPWvAbp10fKGSd8inPTqjd6QN/533HfNZLdgkeWdgjYHBWfnR7WbzI
	 PLil0jrCvjSpWZQi6FZNDXSiNttYqVckA0g8DN1LN92P1e/br4PdPoP6rejBEN68LrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533994;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=eOPOY3kD1nHROhayG8Zom+BAuaBIGgEijSaQPLYIga4=;
	b=EmahJl7eNROWT4v9T+E2FdZzwBaZqsq4ap4BwjnihgzdLJMkDrcTeO+gnRfGZj0/i7ap
	 Y9KyMutUa5uhp/pO57WfOON67DaKWkUFsdM1wcMvABGVvCZji/bptar4f9zpGPVRb+ssj
	 2q/ISHstutd0mRBQgPSh2+2ltie3nBHTyAcISJ8lSHEhXVkHScOlKBqzGD3NYovzhAUTZ
	 St5em5VIZOJNyHma+8fqymsY0n55ShnCqSBlx5sT2ehxmYvcFuMbRdWtLAH6s/0Rg6e8R
	 cpj6N6Tzm6CL9Lie6M3yFyC/9sYpxLeD24TRqJSb0QrH15pF9dxmG6TOqK53UbeW4BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ba9vH5bb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A59606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 15:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ba9vH5bb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054811F000C4;
	Tue, 24 Nov 2026 15:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795533993;
	bh=eOPOY3kD1nHROhayG8Zom+BAuaBIGgEijSaQPLYIga4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ba9vH5bbKEFTzxxYrVEVw0KnCnWBwG9mZMZoMw9FplB0ScQgp1zinrU6LFGHcxIE/
	 k1Gno6CTp6ALpsEzyWUGjMGerBl+tFqIUfsqPP7vnvB+byWxmK2SEKg31/63iowgUF
	 qSz+zym0gjKthm4syOu+Rjk60J5LqhyWxQ6xQ3yr7goTXDKKAqRo/gmzqzONS+KIzf
	 r6CRqK8JjpwQJM1qzJ7E95IzvBZYS0zOdBGY5WJWnUI7TskRbNpq+ospCNxJQ3GOzM
	 ypILvyDt1Ht3tG/i1Wse06MqOwWXeX6R/eE7QTcGZ20cdBm6HqjksDgNYaCWfT43DD
	 kFiI6d8gIOhmA==
Subject: Re: [PATCH mptcp-net v3 1/4] mptcp: handle ack_seq advancing past
 rcv_data_fin_seq
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Tue, 24 Nov 2026 15:26:32 +0000
Message-ID: <179553399254.3133.1494414493820106441@kernel.org>
In-Reply-To: <84d2d4f05df024cd45c1936a3d53ea1d2797ae2a.1795396910.git.tanggeliang@kylinos.cn>
References: <84d2d4f05df024cd45c1936a3d53ea1d2797ae2a.1795396910.git.tanggeliang@kylinos.cn>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] After the patch, mptcp_pending_data_fin() (protocol.c:571)
  returns true whenever ack_seq is at or after rcv_data_fin_seq, and…
- [High] Replacing the exact match with `!before64(ack_seq,
  rcv_data_fin_seq)` in mptcp_pending_data_fin() (protocol.c:571)…
- [Medium] The commit message gives a trigger the code cannot produce.
- [Low] The commit author is Geliang Tang <geliang@kernel.org>, but the
  only Signed-off-by is Geliang Tang <tanggeliang@kylinos.cn>.

--

mptcp: handle ack_seq advancing past rcv_data_fin_seq

This commit changes the check in mptcp_pending_data_fin() from
ack_seq == rcv_data_fin_seq to !before64(ack_seq, rcv_data_fin_seq). The
goal is to process a DATA_FIN even after out-of-order processing has
moved ack_seq past the DATA_FIN sequence number.

> This handles the case where
> out-of-order segments in the OFO queue advance ack_seq past
> rcv_data_fin_seq before mptcp_pending_data_fin() runs.

[Severity: Medium]
Can this happen with a compliant peer?

In get_mapping_status(), a DATA_FIN sent with a data mapping uses one
byte of sequence space, and the mapped payload is shortened by one:

net/mptcp/subflow.c:get_mapping_status() {
    ...
		data_fin_seq = mpext->data_seq + data_len - 1;
    ...
		/* Adjust for DATA_FIN using 1 byte of sequence space */
		data_len--;
    ...
}

So the mapped payload ends exactly at the DATA_FIN DSN. A DATA_FIN with
data_len == 1 maps no data at all.

ack_seq only moves to the end of mapped data. In __mptcp_move_skb():

	WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);

and in __mptcp_ofo_queue():

	WRITE_ONCE(msk->ack_seq, end_seq);

The fallback dummy DATA_FIN in subflow_sched_work_if_closed() uses
map_seq + map_data_len, which is also where ack_seq stops.

With well-formed mappings, ack_seq reaches rcv_data_fin_seq and stops there,
so the old == test already matched. Getting ack_seq > rcv_data_fin_seq
seems to need a misbehaving peer or a forged segment. That means either
data mapped at or past its own DATA_FIN DSN, or a DATA_FIN DSN that is
already behind ack_seq.

Could the commit message describe the real trigger, ideally with a
reproducer or trace? As written, the Fixes: tag suggests a hang that
ordinary connections can hit.

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the Author address (geliang@kernel.org) and the
Signed-off-by address (tanggeliang@kylinos.cn) differ, so checkpatch.pl will
warn with FROM_SIGN_OFF_MISMATCH. .mailmap maps both addresses to the same
person, so there is no DCO problem.

Could the sign-off use the author address, or could an in-body From: be
added?

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index d3878160f936c..1a4b921136a60 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -568,7 +568,7 @@ static bool mptcp_pending_data_fin(struct sock *sk, u64 *seq)
>  	     (TCPF_ESTABLISHED | TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2))) {
>  		u64 rcv_data_fin_seq = READ_ONCE(msk->rcv_data_fin_seq);
>  
> -		if (READ_ONCE(msk->ack_seq) == rcv_data_fin_seq) {
> +		if (!before64(READ_ONCE(msk->ack_seq), rcv_data_fin_seq)) {

[Severity: High]
Does the caller still assume ack_seq == rcv_data_fin_seq here?

mptcp_check_data_fin() ignores the rcv_data_fin_seq returned through *seq
and increments the current ack_seq instead:

net/mptcp/protocol.c:mptcp_check_data_fin() {
    ...
	 * If we are caught up to the sequence number of the incoming
	 * DATA_FIN, send the DATA_ACK now and do state transition.  If
    ...
	if (mptcp_pending_data_fin(sk, &rcv_data_fin_seq)) {
		WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);
		WRITE_ONCE(msk->rcv_data_fin, 0);
    ...
}

This patch only changes behaviour when ack_seq > rcv_data_fin_seq. In
that case the DATA_FIN is counted at ack_seq + 1 instead of
rcv_data_fin_seq + 1, and mptcp_send_ack() then sends that value to the
peer.

On a Linux peer, ack_update_msk() ignores a DATA_ACK beyond snd_nxt:

	if (unlikely(before64(snd_nxt, old_snd_una) ||
		     after64(new_snd_una, snd_nxt)))
		new_snd_una = old_snd_una;

So the peer's DATA_FIN can stay unacknowledged after the local side has
moved to CLOSE_WAIT, CLOSING or CLOSE. The peer then waits for its own
timeout.

If the peer does have data in flight past ack_seq, a DATA_ACK of
ack_seq + 1 acknowledges a byte that was never received. When the real
segment at the old ack_seq arrives, could mptcp_subflow_discard_data() or
the partial-packet path in __mptcp_move_skb() drop its first byte?

Any data at or past the DATA_FIN DSN also stays in the receive queue and
is counted in ack_seq and bytes_received, even though RCV_SHUTDOWN is set.

Would it be better to keep the exact-match check and validate the DSN when
it is recorded? Another option is to decide explicitly how data past the
DATA_FIN should be handled.

[Severity: High]
Does this change remove the only check on the DATA_FIN DSN sent by the
peer?

That value is stored without validation. For a zero-length segment that
carries a DSS DATA_FIN, mptcp_incoming_options() does:

	if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq) {
		if (mp_opt.data_fin && mp_opt.data_len == 1 &&
		    mptcp_update_rcv_data_fin(msk, mp_opt.data_seq, mp_opt.dsn64))
			mptcp_schedule_work((struct sock *)msk);

This path has no DSS checksum and no window check.
mptcp_update_rcv_data_fin() only refuses if rcv_data_fin is already set,
and otherwise stores the value as is:

	WRITE_ONCE(msk->rcv_data_fin_seq,
		   mptcp_expand_seq(READ_ONCE(msk->ack_seq), data_fin_seq, use_64bit));

Before this patch, the DATA_FIN only took effect when its DSN was exactly
ack_seq. After it, any DSN at or behind ack_seq takes effect right away
(for example data_seq = 0 with dsn64):

mptcp_worker()
  mptcp_check_data_fin()
    mptcp_pending_data_fin()   <- now true for any past DSN
    sets RCV_SHUTDOWN, moves to CLOSE_WAIT/CLOSING/CLOSE

A DSN ahead of ack_seq also takes effect once a single skb move jumps
past it.

Can one in-window segment on any single subflow now force what looks like
a clean EOF on the whole MPTCP connection? The application would get a
truncated stream that it cannot tell apart from a normal close.

mptcp_check_data_fin() then writes ack_seq + 1, so the DATA_ACK also
acknowledges a byte that was never received. The peer's real segment
starting at the old ack_seq would then lose its first byte.

A legitimate peer never sends a DATA_FIN DSN behind ack_seq, so the newly
accepted inputs seem to come only from misbehaving peers or injected
segments. An attacker still needs a segment the subflow will accept.
However, instead of guessing the exact DSN, roughly half the sequence
space now works.

>  			if (seq)
>  				*seq = rcv_data_fin_seq;
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1795396910.git.tanggeliang%40kylinos.cn
