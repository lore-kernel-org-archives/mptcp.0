Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FCF501F48
	for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 16:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792169279; cv=none; b=SzeOX/Wlaj8/SHD/Yyh6BzCQ1TfTTOXwJ7kJbHZDyXZr8cNnhpOicnVquIjQu2eg+ZT1nH7DXrnzvjeJsZO7AcxvyOO+oztV267x2uJA6Uz8Ejg7ePTPnc+uTWs+QmhoaTHyhM5GjsKz1nKQPGizR1KcWs4HVb7cCTb60TkLhqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792169279; c=relaxed/simple;
	bh=H5X7AE/Sy+Mv1up5iyNiT/bBFdJjaulzGEdfd+9It+g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=g6PSDJvLyu9VacEy0nJqHLn6GSUsJ97506FM39c+pQGBwykhzTknNHlpadK5ndYro41v9gVWrh1Aiss6vAbTpzRpJwpLkajGoFNPXpATvA0dGX/J8unTbHH5FC58Wc2IwSwz7kLoMaSWs8CfhAEU3K2nsQaqlTbLJZCZ23Gmkhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bb5B99UI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bb5B99UI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DF61F000C5;
	Fri, 16 Oct 2026 16:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792169277;
	bh=D7Rnhu0tbZB3PDfG7wIQMB18hE4Hn+p/9Bm2Io968YM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Bb5B99UIcvCEZy+tBt46+nUvFV9QC8/iXKhOMTfSoMqa7FWmxztkGc1HFJ2DE8jZK
	 CYdiK+B8uR9moba9WqnsAqMyOL52B7DYokej/TWxid/l8j60mNlP1bVZFZop0w+Xqv
	 OQPnEtcu9iclgFOLrPV6deN7C79kal86nw+DtrY+HXYheFHGCci0bl9nW+jp3abWxh
	 f0+c4aaQpF/SXoUMFzdLaEflHW9A9tWq+sn4FeWXFIS81CPoHFqLti/aMCR9S7E4Gi
	 TY/QI/l5F3+5ybyRkNtj+1aLrR9dzoAJ26CVyCSxgj/sKgNYVfFrfTSk+RHI3T8Fg2
	 dGrfzbh/JVJcA==
Date: Fri, 16 Oct 2026 09:47:56 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-net] mptcp: disconnect: reset first subflow's
 local_id
In-Reply-To: <20261015-mptcp-first-disco-id-reset-v1-1-6ae41e8f02c6@kernel.org>
Message-ID: <308170eb-b0f2-fff0-0d9a-7610e148fa0c@kernel.org>
References: <20261015-mptcp-first-disco-id-reset-v1-1-6ae41e8f02c6@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 15 Oct 2026, Matthieu Baerts (NGI0) wrote:

> The first subflow can get disconnected for various reasons and
> mptcp_subflow_ctx_reset() will reset most fields and set local_id to -1.
> That's fine until the subflow is reused after a reconnect.
>
> As mentioned by Clashiko [1]: on the retry, local_id is -1, so the
> connect goes through:
>
>  tcp_connect()
>    subflow_rebuild_header()
>      subflow_chk_local_id()
>        mptcp_pm_get_local_id()
>
> mptcp_pm_get_local_id() returns 0 only when the msk local address
> matches the subflow's address. The addresses can change, but even if
> they don't, for an unbound msk, the address is therefore still zero at
> this point. (Note: in MPTCP disconnect selftests, the address is the
> same, and mptcp_pm_get_local_id() will return 0.)
>
> At this stage, the kernel PM might then give the MPC subflow a non-zero
> ID, either from a matching endpoint or by adding an "implicit" endpoint.
> The RFC 8684 says that the first subflow always has the ID 0, and the
> PMs rely on that for special cases. So it is important to reset it to 0.
>
> Note that we need to keep it to -1 in mptcp_subflow_ctx_reset() to avoid
> a double closures in mptcp_close_ssk().
>
> This issue was found by code analysis, and confirmed by looking at the
> ID after a reconnection.
>
> Fixes: a7cfe7766370 ("mptcp: fix data races on local_id")
> Link: https://lore.kernel.org/179198834484.434549.4616694240552704738@kernel.org
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> net/mptcp/protocol.c | 1 +
> 1 file changed, 1 insertion(+)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 60cbd91be632..4a6f16e0d809 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3654,6 +3654,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
> 	 */
> 	mptcp_do_fastclose(sk);
> 	mptcp_destroy_common(msk);
> +	WRITE_ONCE(mptcp_subflow_ctx(msk->first)->local_id, 0);
>
> 	/* The first subflow is already in TCP_CLOSE status, the following
> 	 * can't overlap with a fallback anymore
>
> ---
> base-commit: 6a6728a8e881c12c984d104403ecaa0523d3b7e8
> change-id: 20261015-mptcp-first-disco-id-reset-a0866d67d9a6
>

Fix looks good, thanks Matthieu

Reviewed-by: Mat Martineau <martineau@kernel.org>
