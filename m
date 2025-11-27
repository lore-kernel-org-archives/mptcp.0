Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313C1328B7B
	for <mptcp@lists.linux.dev>; Thu, 27 Nov 2025 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764236026; cv=none; b=uhvP6t4jW0EWGm93rmDhgwMCm7VxH1gC1mZR390Svsda81Ppx/3l6clJ144xKjxJRg6sIuYzSk8u5BOwx/XPRhhl97zXwvtYKRl0O34pTCheUuIwG6VQY0JxyzBBYJ7Vw5/eTnGMfa0PQLQEtaCXJiU9wT2NWz4LJd/KrOjikWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764236026; c=relaxed/simple;
	bh=vi9I2bmKTgo1ihvsRplzRhnQwKGABLGk22DsIJYydaw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BQJexaHmhw9YdbMfQOXH1HZOcpu1hcEcBFtp/0fVcwJhWdEQ6u6XdAGVzcULdAbwIeM4MC+oWsg0TmQ/tc+qvmhvd3+A45rzFZlg3v7v7KeP5/wuFL9Wig0zyAqz6Ncsm7163nfg5jc5a9KV/zRS7MpD5iPeMdQ/wtPGyKWvL3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDRwX5ZP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDRwX5ZP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFCEC4CEF8;
	Thu, 27 Nov 2025 09:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764236025;
	bh=vi9I2bmKTgo1ihvsRplzRhnQwKGABLGk22DsIJYydaw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=aDRwX5ZPZDxl22j8jHvCk81oMNaRzJhIkpA69FL19BbXFHHtdE6A4Zuzxfkb9ZV8l
	 /DYdxxbgeKyUhSP58Hr9yEnO4WQnKIlsHBdr/qlGOfyBQiZuPJd5N15UrMl/80WsFO
	 wpWBjJzbmteQGhV14iD+oOlGkAfBZrUHGxnl7l8aDhO7A/ib+qXx0YBsno5CCfWY1e
	 E1di6JR+tNSj/yC9ft1I/NcftXfLTEpJK9lPJc8veg9QEKuNa3gk4cN0TndSSFnvl2
	 klezGd3a7XLn3qxiQBk6alTPcHhH7Qy55jFnzlMJutrrvNIplmREbOaPmI3ZzxXJYW
	 ljOSjaELwZp9Q==
Message-ID: <8f6ef1567e3f5af2d7843c87c034a5d90d57ebd1.camel@kernel.org>
Subject: Re: [PATCH mptcp-net] mptcp: sync the msk->sndbuf at accept() time
From: Geliang Tang <geliang@kernel.org>
To: Gang Yan <gang.yan@linux.dev>, mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Date: Thu, 27 Nov 2025 17:33:41 +0800
In-Reply-To: <20251127070417.53513-1-gang.yan@linux.dev>
References: <20251127070417.53513-1-gang.yan@linux.dev>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Gang,

Thanks for this patch.

On Thu, 2025-11-27 at 15:04 +0800, Gang Yan wrote:
> From: Gang Yan <yangang@kylinos.cn>
> 
> After an MPTCP connection is established, the sk_sndbuf of client's
> msk
> can be updated through 'subflow_finish_connect'. However, the newly
> accepted msk on the server side has a small sk_sndbuf than
> msk->first->sk_sndbuf:
> 
> '''
> MPTCP: msk:00000000e55b09db, msk->sndbuf:20480, msk->first-
> >sndbuf:2626560
> '''
> 
> This means that when the server immediately sends MSG_DONTWAIT data
> to
> the client after the connection is established, it is more likely to
> encounter EAGAIN.
> 
> This patch synchronizes the sk_sndbuf by triggering its update during
> accept.
> 
> Fixes: 8005184fd1ca ("mptcp: refactor sndbuf auto-tuning")
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
> Notes:
> 
> Hi, Matt,
> 
> I'm not sure the commit in 'Fix' tag is correct.
> 
> The 3a236aef280e (mptcp: refactor passive socket initialization)
> removes the
> 'propagate_sndbuf' in '__mptcp_finish_join' and
> 'mptcp_stream_accept'.
> And the 8005184fd1ca adds it in '__mptcp_finish_join' but not in
> accept
> time. So I think there exists a miss in 8005184fd1ca.
> 
> Can you help me to check the 'Fix' tag?
> 
> Thanks,
> Gang
> ---
>  net/mptcp/protocol.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index e484c6391b48..33610d638385 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -4213,6 +4213,7 @@ static int mptcp_stream_accept(struct socket
> *sock, struct socket *newsock,
>  
>  		mptcp_graft_subflows(newsk);
>  		mptcp_rps_record_subflows(msk);
> +		__mptcp_propagate_sndbuf(newsk, subflow->tcp_sock);

We generally avoid directly using subflow->tcp_sock and instead use
mptcp_subflow_tcp_sock() helper. What do you think about using this
helper here?

Thanks,
-Geliang

>  
>  		/* Do late cleanup for the first subflow as
> necessary. Also
>  		 * deal with bad peers not doing a complete
> shutdown.
