Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDC230594E
	for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786981014; cv=none; b=IOQt+JW/rUR907hZ37FuVJLG+AQtg4cy9SCaScC7fWwU4qEpB8xTRiLbMobqUW8MLD5xJP0CKIPBXcBqvJgm2bJPQhinIsXAZkBIjbyHCl6hxHznKT0B2MSt4nXdmEMHccO0HNVJ7PbJ2ik3xBbMuLL57W/LRm3Icq5F18dpMZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786981014; c=relaxed/simple;
	bh=Anl67Kl3lo/XBfsQvR8pVkP1ZH/uxYLLoHMb8JnCFuE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fHPg9jcFEyt4f2qLc3XelcQw9aadVArUI+yuWYSZhrt4jTR467576L3ngiYaBNPPZALnHIXQOofpO6obQEBe/SIin7BgujUwN6dy2XhDTnki/vpIPekdYgTxSk5tstnxpgSLAL1kJlLz7uTkD5QoqXY27jqcIZGxXBoo1R7Rnw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noyAxelN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noyAxelN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C8A1F00A3A;
	Mon, 17 Aug 2026 15:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786981013;
	bh=2iS9zLges3RidrEGb2El0aJ2gnZmSsh7uFOqcV75S8s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=noyAxelNxUQHjkGkiPNFvY+8OH6P1bk93wmHLcNtBWBhcU+w3k1yLIvycOz7y6Bu3
	 Z9gefhNInWBgcN6sXWbpgNlR1+evKoSLXwp9H7buJLTqp1dnPZiy6QB6WunQnwridK
	 b9c7Qe/DtTD8nFmh0hhbLX21caeFWMCfqvp8UFpoajDef0NOd+93ZNZhphGtVh5NgM
	 k4klDZtCTTXErwPD5AeklJ8BGO0razvlFO7bcgwGEHjmcv4Co8vDILzHqAv/Br1+Fx
	 Z9JGiGyJFAKUbnhB3EXrpL3L22cXbzcNCeEjsTGtf5UcvRqI9HyX2doRCK6oojzLSf
	 SAiFzpn306piA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v3 3/4] mptcp: sched: do not penalise when
 receive-window-limited
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shardul Bankar" <shardul.b@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260817-mptcp_penalise_send_v2-v3-3-e6a2ad2f1b82@mpiricsoftware.com>
References: <20260817-mptcp_penalise_send_v2-v3-0-e6a2ad2f1b82@mpiricsoftware.com>
 <20260817-mptcp_penalise_send_v2-v3-3-e6a2ad2f1b82@mpiricsoftware.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 15:36:53 +0000
Message-Id: <20260817153653.73C8A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `mptcp_snd_wnd_test()` heuristic incorrectly disables the slow=
-subflow penalty for standard bulk transfers by equating application queue =
depth with receive-window limitation.
--

--- Patch [3]: [PATCH mptcp-next v3 3/4] mptcp: sched: do not penalise when=
 receive-window-limited ---
commit 97d5176c170e6dd87e10d2ec2eefd7e6a38340c4
Author: Shardul Bankar <shardul.b@mpiricsoftware.com>

mptcp: sched: do not penalise when receive-window-limited

This commit disables the slow-subflow cwnd penalty when the connection
is receive-window limited. It introduces mptcp_snd_wnd_test to skip the
penalty if the application has queued past the window edge.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1635,6 +1635,14 @@ static bool mptcp_penalise_throttle_ok(struct mptc=
p_subflow_context *subflow)
>  	return tcp_jiffies32 - subflow->last_penalise >=3D max_t(u32, rtt, 1);
>  }
> =20
> +/* Like tcp_snd_wnd_test() but without an skb: true while queued data st=
ill fits
> + * the send window, i.e. not receive-window-limited.
> + */
> +static bool mptcp_snd_wnd_test(const struct mptcp_sock *msk)
> +{
> +	return !after64(msk->write_seq, mptcp_wnd_end(msk));

[Severity: High]
During a standard bulk data transfer, the application typically pushes data
into the socket buffer up to sk_sndbuf, which is often much larger than the
peer's advertised receive window.

Because of this, won't msk->write_seq naturally exceed mptcp_wnd_end(msk),
causing this test to return false even when the network is bottlenecked by
a small congestion window rather than the receive window?

If this evaluates to false during bulk transfers, doesn't it unconditionally
disable the slow-subflow penalty and prevent the intended shift of load to
faster subflows?

> +}
> +
>  /* Halve cwnd (and ssthresh if past it) under the subflow socket lock. */
>  static void mptcp_penalise_cwnd(struct sock *ssk)

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-mptcp_pena=
lise_send_v2-v3-0-e6a2ad2f1b82@mpiricsoftware.com?part=3D3
