Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561D44766B1;
	Mon, 12 Oct 2026 11:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805791; cv=none; b=aRoBXpZKQPTfkDD7wYsE5nuYE5zFTLIFHz0DZOqQYkS39jHh3K/QRWKpcLuwRRsVbLwPj48oxxdSCd1np3REAUFtZhBI7oy/h5gmPDcznfzPpLDtMw8Uorer43FbyVCxF0+/1c0u4JnPPWEZaxQUNUCfm22wxS6Z2P8rwYHVwRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805791; c=relaxed/simple;
	bh=eEGHR1mGzXV2D56jleqiwMUkHuS2xYotBOpfGB3XqRI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F50CmbVwv/KDJHWRYr/0/NpYVdiepKwKxbo1qfqIxruBFGNA01MvFDeVY3pITgCFsiu7F9hW4gdaB91Nh8xlbQEXP7YxmFLirc8N5BsSaHxPPRp4SUNaVvBWSFoQP3sNO9pCvCgKdlrVt9nDfH5GEj6vmeqH37wFo2Z5HaoseWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXmx+Frb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXmx+Frb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7931E1F0089B;
	Mon, 12 Oct 2026 11:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791805788;
	bh=PaRI2t53VPJ+0vnPAZfKfUr2oOawUBTdE9uZt78o1Uc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kXmx+FrbPvCsEW2vEl21Q/yVnEthdkJSytQmPizNFEsodSCilD0W/WvMklCWfIwUY
	 GDpsGQC7cxBmotApKOmze5p9lwyEoPeeahfNhKXGu0jEPib35XcDC+rmuHb9PzH78O
	 aoCFLjU2I0rA9OUGi0kXD+BM/VhT5AFmsmlPZXdfNaxC6DcNQrzwwLYJEIhpjS03Eg
	 SvtrvUuh05md8ltiTsK3NgurxraDY1njvesDM90QQ4jYMg+Tj3OXtOi11FAksJU1+Z
	 M2l2Wsq+XliKD95SiU/tlfBnLUAPA/RgEyio7RY+Zey3FdekkPcZGtTOgI4Db436GH
	 lwWrgJlVsLMyw==
Subject: Re: [PATCH v3] mptcp: push queued data on passive TFO subflows
 becoming established
From: netdev-bot+sashiko@kernel.org
To: rameshsv06@gmail.com
Cc: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 petar.sakic@ink.fish, rameshkumar.t@phytecembedded.in, kuba@kernel.org
Date: Mon, 12 Oct 2026 11:49:46 +0000
Message-ID: <179180578699.434549.17104698101547866638@kernel.org>
In-Reply-To: <20261008104840.131986-1-rameshkumar.t@phytecembedded.in>
References: <20261008104840.131986-1-rameshkumar.t@phytecembedded.in>
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

- [High] The fix only covers passive TFO children whose SYN carried data.
- [Medium] If the passive TFO subflow's third ACK has no MP_CAPABLE
  option (for example a middlebox strips MPTCP options from non-SYN…
- [Low] The author and sign-off addresses do not match.

--

mptcp: push queued data on passive TFO subflows becoming established

This patch handles data that the server application writes while a
passive TFO subflow is still in SYN_RECV. When the MPC third ACK makes
the subflow fully established in check_fully_established(), the patch
calls __mptcp_check_push() under mptcp_data_lock() if subflow->is_mptfo
is set, and then clears is_mptfo.

Closes: https://lore.kernel.org/netdev/CAFPPu1gU2Y-D+d4i3F0MoNkYK+e1U+=X3qf6QycjfKBw+8snPg@mail.gmail.com/

> Signed-off-by: T S Rameshkumar <rameshkumar.t@phytecembedded.in>

[Severity: Low]
This isn't a bug, but the author address (rameshsv06@gmail.com) does not
match the only Signed-off-by address (rameshkumar.t@phytecembedded.in).
checkpatch.pl reports this as FROM_SIGN_OFF_MISMATCH.

Could the sign-off or the From: line be changed so they match?

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index ce0de02f5a3a1..b865ee6afb00c 100644
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
> +		subflow->is_mptfo = 0;
> +		__mptcp_check_push((struct sock *)msk, ssk);
> +	}

[Severity: High]
Does this cover passive TFO children created from a SYN that carried no
data?

Only mptcp_fastopen_subflow_synack_set_params() sets is_mptfo, and only
when SYN data is on the child's receive queue:

net/mptcp/fastopen.c:mptcp_fastopen_subflow_synack_set_params() {
    ...
	/* A valid TFO cookie does not guarantee SYN data. */
	skb = skb_peek(&ssk->sk_receive_queue);
	if (!skb)
		return;

	subflow->is_mptfo = 1;
    ...
}

tcp_try_fastopen() still creates a full TFO child in TCP_SYN_RECV from a
data-less SYN in two cases:

  - a SYN with a valid cookie and no payload
  - a cookie-request SYN when TFO_SERVER_COOKIE_NOT_REQD is set

The comment in tcp_try_fastopen() says:

	 * Note: Data-less SYN with valid cookie is allowed to
	 * send data in SYN_RECV state.

In both cases tcp_fastopen_add_skb() returns early on
end_seq == rcv_nxt. Nothing gets queued, so is_mptfo stays 0.

The msk is cloned in TCP_ESTABLISHED, so the server can accept() and
write right away. __mptcp_subflow_active() rejects the SYN_RECV ssk, so
the data stays at msk->first_pending.

When the pure MPC third ACK arrives, check_fully_established() reaches
set_fully_established but skips this push. mptcp_incoming_options() then
returns before ack_update_msk():

		if (!(mp_opt.suboptions & OPTION_MPTCP_DSS))
			return true;

Neither subflow_state_change() nor mptcp_pm_fully_established() pushes
the msk write queue. No rtx timer is armed either, because nothing was
ever sent.

Wouldn't a server-speaks-first protocol still stall in this case? That
is the same symptom the commit message describes.

Would it work better to trigger the push when a passive MPC subflow
becomes fully established while msk->first_pending is set, rather than
on is_mptfo?

[Severity: Medium]
What happens if the third ACK on a passive TFO subflow with SYN data has
no MP_CAPABLE option? That can happen if a middlebox strips MPTCP
options from non-SYN segments, or if the peer leaves them out.

The SYN payload advanced ssn_offset, so the third ACK has
seq == ssn_offset + 1 and skips the out-of-order branch. Without DSS or
ADD_ADDR, it then takes the fallback branch earlier in
check_fully_established():

	if (!(mp_opt->suboptions & OPTIONS_MPTCP_MPC)) {
		if (subflow->mp_join)
			goto reset;
		subflow->mp_capable = 0;
		if (!mptcp_try_fallback(ssk, MPTCP_MIB_MPCAPABLEDATAFALLBACK)) {
			...
		}
		return false;
	}

That branch returns before set_fully_established, so the new push never
runs. mptcp_incoming_options() then returns without pushing:

	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
		return sk->sk_state != TCP_CLOSE;

tcp_data_snd_check() finds the ssk write queue empty, because the data
is still in the msk write queue. __mptcp_check_push() only runs on the
next incoming segment, through the __mptcp_check_fallback() branch at
the top of mptcp_incoming_options().

If the client is waiting for the server's reply to its TFO request,
could the data written in SYN_RECV stay stuck in this fallback case too?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008104840.131986-1-rameshkumar.t%40phytecembedded.in
