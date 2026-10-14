Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE7E1F3B85
	for <mptcp@lists.linux.dev>; Wed, 14 Oct 2026 00:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791936677; cv=none; b=RCH3faVRC7BbVDgWIZmeczgBweaV4UfCCSyk1saMERr4CuODbU6FsWMas5nsbW6yoJ7YXvW/wZ+u1R9//4woS5MLr718Puhdk7Uq9NC1KIz4aJwNBYTivO3Bf50Y4YUjMBhZCpWkSnC4laLlh45XVQBmdhmw+Z2z3swKNUqLvQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791936677; c=relaxed/simple;
	bh=i1SEHtwn4xfDH3W8Ve60GnVa7hbGikbiCTpnVDdIU+Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oc2XmDj9LrrPpD8p3nn1UykxdZwVcr4xEkt/CPrNKXlsWRawtheRAfjbzMXm/FPozikEao5lBkx59EunnMC1cfDQTxclFV3SqWBht+alxjHinV0I/SQfs2GGVSEwgU3Sp9WLle8TJgymEHuJgfgFjanbezl+SGccQwQG5OxibnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4xwtmQ+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4xwtmQ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FBF1F000FF;
	Wed, 14 Oct 2026 00:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791936673;
	bh=5SNzA+saJcAZ0SRSLwsMbOc4QLweQOSUJwAb3w4uzHw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=K4xwtmQ+Yl58YQrIfd79OKbSNQMIYBQag94LAUFuKiUKjUrv6Lkma61E/UIY81pY8
	 c0gBg71DodoBxfXEEaDSHOofyPYxJu+O5MBMVNsrByXvQx5GBgVjgMIO1p80W1fDIa
	 pgeC+61OzOw0jG+taNXImLVNDj6uimnRHeMCIPp5Wo49SJKFmB+KARHvogb/hzP3nJ
	 wDyu6Be5lJMYBtTokYDppIki1dai1nfe+jKBNKL68a48kSErXoSe9FrO51tteNBIAj
	 oHP4l0cq5M5cVt+2mMcoAlxKJF8uzd529hOwmZ/3JiyYTsbzrDWdjWISHPA++s1f3e
	 lQ0C3KY1yp6VA==
Subject: Re: [PATCH mptcp-net v2] mptcp: push queued data on passive TFO
 subflows becoming established
From: netdev-bot+sashiko@kernel.org
To: rameshsv06@gmail.com
Cc: mptcp@lists.linux.dev, matttbe@kernel.org, petar.sakic@ink.fish,
 rameshkumar.t@phytecembedded.in, kuba@kernel.org
Date: Wed, 14 Oct 2026 00:11:12 +0000
Message-ID: <179193667256.3135.13011798294766264196@kernel.org>
In-Reply-To: <20261012111001.542847-1-rameshkumar.t@phytecembedded.in>
References: <20261012111001.542847-1-rameshkumar.t@phytecembedded.in>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [Medium] The fix also misses the fallback path.
- [Low] The commit tags are wrong.

--

mptcp: push queued data on passive TFO subflows becoming established

This commit makes check_fully_established() call __mptcp_check_push()
when a passive TFO subflow (subflow->is_mptfo) becomes fully
established. The goal is to flush data the server wrote while the
subflow was still in SYN_RECV. Without the flush, that data stays in
the msk write queue because the MPC third ACK carries no DSS.

Closes: https://lore.kernel.org/netdev/CAFPPu1gU2Y-D+d4i3F0MoNkYK+e1U+=X3qf6QycjfKBw+8snPg@mail.gmail.com/

> Fixes: fb7084501a61 ("mptcp: add support for TCP_FASTOPEN sockopt")
> Signed-off-by: T S Rameshkumar <rameshkumar.t@phytecembedded.in>

[Severity: Low]
This isn't a bug, but does fb7084501a61 exist? The hash doesn't resolve
in the tree, and no commit has that subject.

The passive TFO and is_mptfo handling seem to have come from these
commits:

  36b122baf6a8 ("mptcp: add subflow_v(4,6)_send_synack()")
  dfc8d0603033 ("mptcp: implement delayed seq generation for passive fastopen")
  4ffb0a02346c ("mptcp: add TCP_FASTOPEN sock option")

Should the Fixes tag point at 36b122baf6a8 or dfc8d0603033 instead?

Also, the Signed-off-by address (rameshkumar.t@phytecembedded.in) doesn't
match the author address (rameshsv06@gmail.com). Checkpatch reports this
as FROM_SIGN_OFF_MISMATCH.

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 20490410fa22f..33eede084af8d 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1046,6 +1046,8 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
>  
>  	mptcp_data_lock((struct sock *)msk);
>  	__mptcp_subflow_fully_established(msk, subflow, mp_opt);
> +	if (subflow->is_mptfo)
> +		__mptcp_check_push((struct sock *)msk, ssk);

[Severity: High]
Does this check miss passive TFO children whose SYN carried no data?

mptcp_fastopen_subflow_synack_set_params() sets is_mptfo only after it
finds SYN data in the subflow receive queue:

net/mptcp/fastopen.c:mptcp_fastopen_subflow_synack_set_params() {
    ...
	/* A valid TFO cookie does not guarantee SYN data. */
	skb = skb_peek(&ssk->sk_receive_queue);
	if (!skb)
		return;

	subflow->is_mptfo = 1;
    ...
}

The TCP core still creates a full TFO child for a data-less SYN that has
a valid cookie. It also does this when TFO_SERVER_COOKIE_NOT_REQD is set:

net/ipv4/tcp_fastopen.c:tcp_try_fastopen() {
    ...
	if (!((tcp_fastopen & TFO_SERVER_ENABLE) &&
	      (syn_data || foc->len >= 0) &&
	      tcp_fastopen_queue_check(sk))) {
    ...
}

tcp_conn_request() then puts that child straight into the accept queue,
while the subflow is still in SYN_RECV.

Suppose the application accepts and writes at once, as a
server-speaks-first protocol does. mptcp_sendmsg_frag() returns -EAGAIN
because !__tcp_can_send(ssk). __mptcp_push_pending() then exits with
nothing copied, so the rtx timer is never armed.

When the pure MPC third ACK arrives, is_mptfo is 0 at this point and the
push is skipped. mptcp_incoming_options() then returns before
ack_update_msk():

	if (!(mp_opt.suboptions & OPTION_MPTCP_DSS))
		return true;

So won't the queued bytes stay stuck until the peer sends something,
exactly as before this patch?

Would it work better to replace the is_mptfo test with one that covers
every passive TFO child, such as tcp_sk(ssk)->syn_fastopen_child? Another
option is to push whenever data is pending.

[Severity: Medium]
What happens on the fallback path of a passive TFO subflow?

The third ACK may carry no MP_CAPABLE option. That happens if a middlebox
stripped MPC and the client fell back, or if the peer doesn't conform. In
that case check_fully_established() never reaches set_fully_established:

net/mptcp/options.c:check_fully_established() {
    ...
	if (!(mp_opt->suboptions & OPTIONS_MPTCP_MPC)) {
		if (subflow->mp_join)
			goto reset;
		subflow->mp_capable = 0;
		if (!mptcp_try_fallback(ssk, MPTCP_MIB_MPCAPABLEDATAFALLBACK)) {
			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_FALLBACKFAILED);
			goto reset;
		}
		return false;
	}
    ...
}

mptcp_try_fallback() switches the msk to fallback mode, but it doesn't
push pending data.

The fallback push in mptcp_incoming_options() is checked before
check_fully_established() runs, so it only fires on later segments:

net/mptcp/options.c:mptcp_incoming_options() {
	if (__mptcp_check_fallback(msk)) {
		...
		if (sk_stream_memory_free(sk))
			__mptcp_check_push(subflow->conn, sk);
		...
	}
	...
	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
		return sk->sk_state != TCP_CLOSE;
	...
}

In a typical TFO request/response, the client already sent its request in
the SYN and has nothing more to send.

Could a server reply written during SYN_RECV also get stuck in the msk
write queue on this path, with no rtx timer armed?

>  	mptcp_data_unlock((struct sock *)msk);
>  
>  check_notify:

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012111001.542847-1-rameshkumar.t%40phytecembedded.in
