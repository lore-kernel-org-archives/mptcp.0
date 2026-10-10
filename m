Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545BD3644A2
	for <mptcp@lists.linux.dev>; Sat, 10 Oct 2026 07:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791618051; cv=none; b=JRJ66YavfhVXyaasy1/el50peHzp/MhhNtX6CxDWVGDcdNOQMRkQotiXj12IXAxA1j0L2WCBkSCqn/X7BJa1+qKULuGn8vXaG3n17ZqE3FWGwI1LJ+heXfq3LM+ant6W2IFZbmuyM1d47AY4CMCMeDR6qG0yQMUZrt9Swk9jiPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791618051; c=relaxed/simple;
	bh=TnSRswjN3Kanb2GmwnX7m4/m/iXuBJN8GmDzereUqsE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rWSqMLggICx/isJPBq4HAEcoLPPYc078WjbIrmsXtBHECfN2//4Tkbz6u5D8SJvRz6oeWxGQz5ZKxrKTDOqwMVLR1YnR84VmU9SGDSg2L9q4Axb15vvUMcBJaARHPbNomYUNICNlyC4JSO6cGhFisuIdoSVGNBWfk0mdMqyM3ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4Sszgzs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4Sszgzs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD4F1F000FF;
	Sat, 10 Oct 2026 07:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791618050;
	bh=tng7DGY2k2nn2J3dfLf04w41dKm8WD8Vt3fGUPaWbzI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=S4SszgzsMaoJvSGIqVijOhAidnMUxy0EzvtfC+5LrZ2Dqt21b9/TkPvYIqZ5WPIoI
	 9mdzJxLCCB/TkNl+qtReS+9+k6u/8H89rK6Pwzj/C5CMxLMznaLGmYo5IFBGJ3tPSN
	 hEcPh3ZADEGkdg857Q5FCQ5xBkubWoaCUfdHkTSgE73RxOGzPuxrkqaW3wrI4ajp/P
	 pIFyPjWWWbGEfMVU+FlYGaGgqbhrQtwDwQyenHHAY0NtSnFlwtewPHwawd28O4RZVR
	 kIc2znrsjwMg4fBBkz6NJPfHyHIYg1drcSThBSdv03tciZvg0UeT6+okIBoIdTOGWY
	 WrjizlYWrq2mA==
Subject: Re: [PATCH v4] mptcp: push queued data on passive TFO subflows
 becoming established
From: netdev-bot+sashiko@kernel.org
To: rameshsv06@gmail.com
Cc: matttbe@kernel.org, mptcp@lists.linux.dev, petar.sakic@ink.fish,
 rameshkumar.t@phytecembedded.in, kuba@kernel.org
Date: Sat, 10 Oct 2026 07:40:49 +0000
Message-ID: <179161804927.3135.965833184585507271@kernel.org>
In-Reply-To: <20261008124220.213016-1-rameshkumar.t@phytecembedded.in>
References: <20261008124220.213016-1-rameshkumar.t@phytecembedded.in>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete: data-less passive TFO subflows are still
  left with stranded data.
- [Medium] Sibling path left unfixed: fallback on the third ACK.
- [Low] The Fixes: tag 'fb7084501a61 ("mptcp: add support for
  TCP_FASTOPEN sockopt")' points to a SHA that does not exist in the…
- [Low] The commit author is 'T S Rameshkumar <rameshsv06@gmail.com>',
  but the only Signed-off-by is 'T S Rameshkumar…

--

mptcp: push queued data on passive TFO subflows becoming established

When a passive TFO subflow with is_mptfo set becomes fully established,
this patch pushes the msk write queue from check_fully_established().
Without that push, data written while the subflow was still in SYN_RECV
stays stranded. The patch also moves is_mptfo out of the shared u32
bitfield and makes it a standalone bool.

Closes: https://lore.kernel.org/netdev/CAFPPu1gU2Y-D+d4i3F0MoNkYK+e1U+=X3qf6QycjfKBw+8snPg@mail.gmail.com/

> Fixes: fb7084501a61 ("mptcp: add support for TCP_FASTOPEN sockopt")

[Severity: Low]
Is this Fixes: tag correct? fb7084501a61 doesn't resolve to a commit in
the tree.

By subject, the closest match is 4ffb0a02346c ("mptcp: add TCP_FASTOPEN
sock option"). The passive TFO path changed here, including is_mptfo and
mptcp_fastopen_subflow_synack_set_params(), came from:

  36b122baf6a8 ("mptcp: add subflow_v(4,6)_send_synack()")

The closely related fix e00b63056fb4 ("mptcp: fastopen: only mark MPTFO
subflows with SYN data") also uses 36b122baf6a8 as its Fixes: target.

Should this be:

  Fixes: 36b122baf6a8 ("mptcp: add subflow_v(4,6)_send_synack()")

> Assisted-by: Gemini 3.7
> Signed-off-by: T S Rameshkumar <rameshkumar.t@phytecembedded.in>

[Severity: Low]
The author is rameshsv06@gmail.com, but the only Signed-off-by uses
rameshkumar.t@phytecembedded.in. checkpatch reports this as a
"From:/Signed-off-by: email address mismatch".

Could the author and Signed-off-by identities be aligned? The patch also
carries an Assisted-by: tag, so a matching DCO sign-off from the author
is worth having.

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index ce0de02f5a3a1..7ea97b283fda1 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1042,6 +1042,15 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
>  
>  	mptcp_data_lock((struct sock *)msk);
>  	__mptcp_subflow_fully_established(msk, subflow, mp_opt);
> +	/* Passive TFO: the application may have written data while the
> +	 * subflow was still in SYN_RECV; __mptcp_subflow_active() refused
> +	 * it then and nothing else spools the msk write queue when the
> +	 * MPC third ack (no DSS) arrives. Push it now.
> +	 */
> +	if (subflow->is_mptfo) {
> +		subflow->is_mptfo = false;
> +		__mptcp_check_push((struct sock *)msk, ssk);
> +	}

[Severity: High]
Does this cover passive TFO children whose SYN carried no data?

Since e00b63056fb4 ("mptcp: fastopen: only mark MPTFO subflows with SYN
data"), mptcp_fastopen_subflow_synack_set_params() returns before setting
is_mptfo when the receive queue is empty:

net/mptcp/fastopen.c:mptcp_fastopen_subflow_synack_set_params() {
    ...
	/* A valid TFO cookie does not guarantee SYN data. */
	skb = skb_peek(&ssk->sk_receive_queue);
	if (!skb)
		return;

	subflow->is_mptfo = true;
    ...
}

But tcp_try_fastopen() still creates a full Fast Open child for a
data-less SYN. This happens when the SYN has a valid cookie, or when the
listener has TFO_SERVER_COOKIE_NOT_REQD and the SYN carries a cookie
option:

net/ipv4/tcp_fastopen.c:tcp_try_fastopen() {
    ...
			 * Note: Data-less SYN with valid cookie is allowed to
			 * send data in SYN_RECV state.
			 */
fastopen:
			child = tcp_fastopen_create_child(sk, skb, req);
    ...
}

That child can be accept()ed while it is still in SYN_RECV.
mptcp_sk_clone_init() has already moved the msk to TCP_ESTABLISHED, so
mptcp_sendmsg() queues the data without waiting. Every push attempt is
then refused by __mptcp_subflow_active()->__tcp_can_send(), which only
allows TCPF_ESTABLISHED and TCPF_CLOSE_WAIT.

The sequence looks like this:

tcp_try_fastopen()
  tcp_fastopen_create_child()
    subflow_syn_recv_sock()->mptcp_sk_clone_init()  /* msk ESTABLISHED */
subflow_prep_synack()
  mptcp_fastopen_subflow_synack_set_params()        /* is_mptfo stays false */
accept() + write()                                  /* queued, ssk SYN_RECV */
mptcp_incoming_options()                            /* MPC third ACK */
  check_fully_established()                         /* reaches set_fully_established */

When the MPC third ACK arrives, seq == ssn_offset + 1 because there was
no SYN data to offset. There is no DSS and MPC is present, so the code
reaches set_fully_established. At that point is_mptfo is false and
__mptcp_check_push() is never called.

Wouldn't the queued data then stay in the msk write queue until the peer
sends again? That is the same symptom the commit message describes.

Would it work better to gate this on something that covers every passive
Fast Open child? Options include tcp_sk(ssk)->syn_fastopen_child, or
just checking for pending data with mptcp_send_head(), rather than
is_mptfo.

>  	mptcp_data_unlock((struct sock *)msk);
>  
>  check_notify:

[Severity: Medium]
What happens when the in-sequence third ACK on a passive TFO subflow
arrives without an MP_CAPABLE option? That could happen if a middlebox
strips it or the peer leaves it out.

In that case check_fully_established() takes the earlier fallback
branch. It returns before reaching set_fully_established, so it skips
the new push:

	if (!(mp_opt->suboptions & OPTIONS_MPTCP_MPC)) {
		if (subflow->mp_join)
			goto reset;
		subflow->mp_capable = 0;
		if (!mptcp_try_fallback(ssk, MPTCP_MIB_MPCAPABLEDATAFALLBACK)) {
			...
		}
		return false;
	}

mptcp_incoming_options() then returns without pushing:

	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
		return sk->sk_state != TCP_CLOSE;

The fallback branch in mptcp_incoming_options() that does spool the
write queue is checked before check_fully_established():

	if (__mptcp_check_fallback(msk)) {
		...
		mptcp_data_lock(subflow->conn);
		if (sk_stream_memory_free(sk))
			__mptcp_check_push(subflow->conn, sk);

So that branch only runs on the next incoming segment.
__mptcp_try_fallback() itself only updates msk->flags and does not
schedule a push.

In this fallback case, would the data written while the subflow was in
SYN_RECV also stay queued until the peer sends something else?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008124220.213016-1-rameshkumar.t%40phytecembedded.in
