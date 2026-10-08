Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB043E00B8
	for <mptcp@lists.linux.dev>; Thu,  8 Oct 2026 10:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791455370; cv=none; b=ZdhPjxqA4YxH15MfHE4OJMmJkvN7S9bjqi7IqHWHI5N+bOElJqyFPDugOmA6Xp2Tcfl0omIzDWFBEOExAbTnoT5IOMz+guyFwiB+2F2bjk+b+d8VkQMZm/R+srxikZbAN5OrKOLV6Gk2RLfXJR5JWn5jdMfeqSImsYrd3DjpOPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791455370; c=relaxed/simple;
	bh=/GztcdQ12soDcamBB9Jl9VyNUjlB+FVbvNUPe+k94zc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=UhdFKG4wIwTLcoXvktnfHsnTSUjzEPPENs5QI6/r4KLSiY2iBWCcS+oa8PY2bLEXmaEgN3I0iJFuoYSug0Pv50OjNcUoxXypIwcMy2Zu/+xjp5nIAo7lnid8T2Fc4j+T7owm8mfai21XQDLwEme0pPPYIPK4PopTqpxEmT7ppbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihMxXBrE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihMxXBrE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AFDB1F000FF;
	Thu,  8 Oct 2026 10:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791455369;
	bh=pOfFiosbJxG4HbrOjnxUn/JDX76Aj2UcXiZFUUoAUCk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ihMxXBrEIP5Tfrwjl2wzn95yiuw6y3OK0hpXEQyOe9x0l+ztT31fupjOvRUB/KtJV
	 PS+fq9gYWsBeHlH8ifCnVr1Q2NNGUmAsMSo8m3hjt35CeoJzJshPSTorpWGI3T13YE
	 NG8B159/iUvwRVN3eLyu+cJIeOKjm18VLiG2cnKbxIPkRjQfeLujhwLit/UXcCBkHi
	 OI8+2V/pu8WHsvZWeRKa0/Z59zFT+rAhaj8kqiF1Tw1W3CO2ByGYb7PFT5er5QNcgK
	 AXoKUrx1LB9JUDHK6hqhgf+wt20xHMu3iruAaO2V6gwYZj3pB7f5bZ5NlskvNJLOkT
	 TdaH8FEe23kJw==
Message-ID: <sashiko-outbox-164014@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] mptcp: push queued data on passive TFO subflows
 becoming established
Reply-To: sashiko-reviews@lists.linux.dev
To: "T S Rameshkumar" <rameshsv06@gmail.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20261008100941.104715-1-rameshkumar.t@phytecembedded.in>
References: <20261008100941.104715-1-rameshkumar.t@phytecembedded.in>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 10:29:28 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mptcp: premature clear of is_mptfo breaks passive TFO sequence val=
idation
--

commit 22ac3fb6b29817664eb5b68ac5a70275e689140e
Author: T S Rameshkumar <rameshsv06@gmail.com>

mptcp: push queued data on passive TFO subflows becoming established

This commit flushes queued data on passive TCP Fast Open subflows
when the subflow transitions to TCP_ESTABLISHED. It checks for
subflow->is_mptfo in subflow_state_change() and check_fully_established()
to push the data, and clears the flag so subsequent state transitions
are ignored.

Closes: https://lore.kernel.org/netdev/CAFPPu1gU2Y-D+d4i3F0MoNkYK+e1U+=3DX3=
qf6QycjfKBw+8snPg@mail.gmail.com/

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index ce0de02f5a3a1..d5238fa111dee 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1042,6 +1042,13 @@ static bool check_fully_established(struct mptcp_s=
ock *msk, struct sock *ssk,
> =20
>  	mptcp_data_lock((struct sock *)msk);
>  	__mptcp_subflow_fully_established(msk, subflow, mp_opt);
> +	/* Passive TFO: the application may have written data while the
> +	 * subflow was still in SYN_RECV; __mptcp_subflow_active() refused
> +	 * it then and nothing else spools the msk write queue when the
> +	 * MPC third ack (no DSS) arrives. Push it now.
> +	 */
> +	if (subflow->is_mptfo)
> +		__mptcp_check_push((struct sock *)msk, ssk);

[Severity: High]
Does this block become entirely unreachable dead code?

When an MPTCP connection using passive TCP Fast Open receives the 3rd ACK,
tcp_rcv_state_process() executes sk_state_change() (transitioning from SYN_=
RECV
to ESTABLISHED) before executing tcp_data_queue().

Since the newly added code in subflow_state_change() clears the
is_mptfo flag during this state transition, subflow->is_mptfo will evaluate
to 0 by the time check_fully_established() is reached here.

>  	mptcp_data_unlock((struct sock *)msk);
> =20
>  check_notify:
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index f0a6725d2c376..c7112284254a5 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1894,6 +1894,13 @@ static void subflow_state_change(struct sock *sk)
>  	if (subflow->resetting)
>  		return;
> =20
> +	if (subflow->is_mptfo && sk->sk_state =3D=3D TCP_ESTABLISHED) {
> +		subflow->is_mptfo =3D 0;

[Severity: High]
Does prematurely clearing the is_mptfo flag here break passive TFO sequence
validation?

After this state change runs, tcp_data_queue() calls mptcp_incoming_options=
()
which evaluates check_fully_established(). Because the flag is already 0, t=
he
preexisting sequence number check bypass for passive TFO fails:

net/mptcp/options.c:check_fully_established() {
    ...
	if (TCP_SKB_CB(skb)->seq !=3D subflow->ssn_offset + 1) {
		if (subflow->mp_join)
			goto reset;
		if (subflow->is_mptfo && mp_opt->suboptions & OPTION_MPTCP_MPC_ACK)
			goto set_fully_established;
		return subflow->mp_capable;
	}
    ...
}

The TFO 3rd ACK sequence number includes the data length sent in the SYN and
does not equal ssn_offset + 1. Since the bypass condition fails, doesn't th=
is
prevent the subflow from becoming fully established?

> +		mptcp_data_lock(parent);
> +		__mptcp_check_push(parent, sk);
> +		mptcp_data_unlock(parent);
> +	}
> +
>  	/* as recvmsg() does not acquire the subflow socket for ssk selection
>  	 * a fin packet carrying a DSS can be unnoticed if we don't trigger
>  	 * the data available machinery here.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008100941.1047=
15-1-rameshkumar.t@phytecembedded.in?part=3D1
