Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4F249C4BD
	for <mptcp@lists.linux.dev>; Thu,  8 Oct 2026 12:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791464177; cv=none; b=YmVckZgLlay14LyWiZaDWOiuADUDnCTfLOuyaoHvey6tLTpi3AbNRySrowzy/Wk9jJHawp0IDfZyZ7+g7Ju4IeYMTUGyLz2nO0rsXqpgIuAylXDLBbLHqL2aTKfYH27GqzwhYd0foFBvBQFHFTRW4tOjGxVJ7xeYv0CCfYbFrOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791464177; c=relaxed/simple;
	bh=YJUumDLn6OFrEQa/nK0ZAp3LhNihpwFrg829riOIhIk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Somn5auSLErmFTLGCLsXJwCFyEOLU2kFljwGKEaYBuM4xrIXj5P1bxTcOnQD1W/8FCHyEXmxTJyJIIvW5GD+2kLN1buAMOAxS4E0Lzoh+SsAAI2ZXZxx/8xOEcIa9HhJIGbzsN1fllBVYnwFObNQnV5hFBEPeTzq0Oo8MeDQPCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNge3NE7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNge3NE7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA8D1F000FF;
	Thu,  8 Oct 2026 12:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791464176;
	bh=Odjzgxj59zwG0sN0WuVlx/kfxworsJlb5kORKnTuLsI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MNge3NE7wfc+IkYPRgVJQ2LikL4sK0/Z+6Zf/IAWzVEGJikDISsywXFe71ujy6jf8
	 T4ymrpwGQCtN5asW8RxaApSoOIjb0pEgc9UdSvFNxYjncQbe037PPg49Ups/vpAf2P
	 c0GDqzMlW+/Fx3O5aoTRf6hbDOzZhLgrUFs9GH3ztJLBJrcrqzDwapVDl/ZrJnWKT6
	 kCQb1aNsp1JvdGQLt6xCp0CVs4ND315V2KCSFTLKrrjka/tliCEqmL48SN9fkhBZdB
	 6mgTzcfcbVVGWu7Fqr0LNnVns1l8KxeIOzG6c39jKg02ujqsdFP2X7C7m4eJHTgHQJ
	 DGIp4bUK7uHzw==
Message-ID: <sashiko-outbox-164183@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] mptcp: push queued data on passive TFO subflows
 becoming established
Reply-To: sashiko-reviews@lists.linux.dev
To: "T S Rameshkumar" <rameshsv06@gmail.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20261008124220.213016-1-rameshkumar.t@phytecembedded.in>
References: <20261008124220.213016-1-rameshkumar.t@phytecembedded.in>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 12:56:16 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mptcp: data race in mptcp_subflow_context bitfield on close_event_=
done
--

commit 5833b858d2930ce8da576be275d9bd667c3816cd
Author: T S Rameshkumar <rameshsv06@gmail.com>

mptcp: push queued data on passive TFO subflows becoming established

With TCP Fast Open on an MPTCP listener, if the server application
writes data while the passive subflow is still in SYN_RECV,
__mptcp_subflow_active() refuses transmission and the data is queued
into the msk write queue.

Closes: https://lore.kernel.org/netdev/CAFPPu1gU2Y-D+d4i3F0MoNkYK+e1U+=3DX3=
qf6QycjfKBw+8snPg@mail.gmail.com/

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 0384d6a023f9d..0e44de1298007 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -582,15 +582,15 @@ struct mptcp_subflow_context {
>  		disposable : 1,	    /* ctx can be free at ulp release time */
>  		closing : 1,	    /* must not pass rx data to msk anymore */
>  		valid_csum_seen : 1,        /* at least one csum validated */
> -		is_mptfo : 1,	    /* subflow is doing TFO */
>  		close_event_done : 1,       /* has done the post-closed part */

[Severity: High]
Does leaving close_event_done in this bitfield still result in a data race?

In net/mptcp/protocol.c:mptcp_close_ssk(), subflow->close_event_done is set
to true while holding only the msk lock.

Concurrently, the TCP RX path calls subflow_data_ready() ->
mptcp_subflow_data_available() -> subflow_check_data_avail() in
net/mptcp/subflow.c, which sets subflow->map_valid =3D 1 holding only the
ssk (subflow) lock.

Since close_event_done and map_valid are part of the same u32 bitfield,
could these uncoordinated read-modify-write operations cause concurrent
updates to be silently lost, potentially dropping valid data or executing
mptcp_close_ssk() multiple times?

>  		mpc_drop : 1,	    /* the MPC option has been dropped in a rtx */
>  		resetting : 1,	    /* subflow is resetting */
> -		__unused : 8;
> +		__unused : 9;
>  	bool	data_avail;
>  	bool	scheduled;
>  	bool	pm_listener;	    /* a listener managed by the kernel PM? */
>  	bool	fully_established;  /* path validated */
> +	bool	is_mptfo;	    /* subflow is doing TFO */
>  	u32	lent_mem_frag;
>  	u32	remote_nonce;
>  	u64	thmac;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008124220.2130=
16-1-rameshkumar.t@phytecembedded.in?part=3D1
