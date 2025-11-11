Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C73A29CEB
	for <mptcp@lists.linux.dev>; Tue, 11 Nov 2025 09:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762852190; cv=none; b=W8lLsaqlIIY9N9LlO26Dr0rsPKyindrmECzBOzMpUb99uhQlV1Hg/6oJDB4GJoCCIGHE5IV5qoI+VjTuspJ4/Jnx+RgiGPfpCh9alZqgw2cW/yRd5C9xfxJxZsNMjY4g5RS9dEy8XOjV7lPdAgYWhmKcxqJXHqcmylOPOzWVysU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762852190; c=relaxed/simple;
	bh=nrosOXAbxQSNRNHuSDtIOp5ULpESw81u6ZaYwwL3v9g=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XzcbQvxSX3w2xVfxUAsDz9vhFDAB4wMoJ6u9LcPjnkLnzEgI7a6Y2/QmidIQIW+ogsZuQDRWo/fGbVb/uFOABKhOX1N3SYfnh7LRoGBbCbfenFpYYrqdELzmFTdTmc9ia1Ca6VW6Vhj+64ZAoGo0JwVo/3kDGhtpuzNUCxkwMdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrUUdpAX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrUUdpAX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FFBC4CEF7;
	Tue, 11 Nov 2025 09:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762852188;
	bh=nrosOXAbxQSNRNHuSDtIOp5ULpESw81u6ZaYwwL3v9g=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=OrUUdpAXzGe/1eGGPurNmluV9PScHlTF26mw6x5NNc8slLa89OE7p/nPLGYVTrTLF
	 zVN0WRNHUs9/dmfnVZ8AmJ69xYYQdrE2SAwhdBkGVYiv36l0lenBj9wZeXONrclz79
	 nTvhYvNENMEN9Wqt9O6kU6hGMrKo5ih00hfFwGhGh/Zo1AeGYXBcWlGFoLcxtNLbN9
	 3qZ6m4yZfVpbQoywYMfZZwtq9aOkKbhg+JEC3pmaTKtOxWmc9CN3M/RO73jM/970vm
	 ZztP+k9I5h5Ra7uR0LmySzBvoGns5O1UOcYPFWeiIIdBMOqQmTAXhAS0zwN9wtBwHG
	 CXrMopzmJWTSw==
Message-ID: <5070437517392bc9a2499152ad873cdcaf4a58eb.camel@kernel.org>
Subject: Re: [PATCH mptcp-net] mptcp: fix ack generation for fallback msk
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Date: Tue, 11 Nov 2025 17:09:44 +0800
In-Reply-To: <14a868192851deb4145a90e3b7eec616544da262.1762474159.git.pabeni@redhat.com>
References: 
	<14a868192851deb4145a90e3b7eec616544da262.1762474159.git.pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo,

Thanks for this fix.

On Fri, 2025-11-07 at 01:10 +0100, Paolo Abeni wrote:
> mptcp_cleanup_rbuf() need to know the last most recent, mptcp-level
> rcv_wnd sent, and such information is tracked into the msk-
> >old_wspace
> field, updated at ack transmission time by mptcp_write_options().
> 
> Fallback socket do not add any mptcp options, such helper is never
> invoked, and msk->old_wspace value remain stale. That in turn makes
> ack generation at recvmsg() time quite randomic.
> 
> Address the issue ensuring mptcp_write_options() is invoked even
> for fallback sockets, and just update the needed info in such a
> case.
> 
> The issue went unnoticed for a long time, as mptcp overshot the
> fallback socket receive buffer autotune significantly.
> 
> Fixes: e3859603ba13 ("mptcp: better msk receive window updates")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/594
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

This patch looks good to me!

    Reviewed-by: Geliang Tang <geliang@kernel.org>

-Geliang

> ---
>  net/mptcp/options.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index ad51dcf18984..8d3b0f9754dc 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -838,8 +838,11 @@ bool mptcp_established_options(struct sock *sk,
> struct sk_buff *skb,
>  
>  	opts->suboptions = 0;
>  
> +	/* Force later mptcp_write_options(), but do not use any
> actual
> +	 * option space.
> +	 */
>  	if (unlikely(__mptcp_check_fallback(msk) &&
> !mptcp_check_infinite_map(skb)))
> -		return false;
> +		return true;
>  
>  	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags &
> TCPHDR_RST)) {
>  		if (mptcp_established_options_fastclose(sk,
> &opt_size, remaining, opts) ||
> @@ -1351,6 +1354,20 @@ static void mptcp_set_rwin(struct tcp_sock
> *tp, struct tcphdr *th)
>  	subflow->rcv_wnd_sent = rcv_wnd_new;
>  }
>  
> +static void mptcp_track_rwin(struct tcp_sock *tp)
> +{
> +	const struct sock *ssk = (const struct sock *)tp;
> +	struct mptcp_subflow_context *subflow;
> +	struct mptcp_sock *msk;
> +
> +	if (!ssk)
> +		return;
> +
> +	subflow = mptcp_subflow_ctx(ssk);
> +	msk = mptcp_sk(subflow->conn);
> +	WRITE_ONCE(msk->old_wspace, tp->rcv_wnd);
> +}
> +
>  __sum16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16
> data_len, __wsum sum)
>  {
>  	struct csum_pseudo_header header;
> @@ -1643,6 +1660,9 @@ void mptcp_write_options(struct tcphdr *th,
> __be32 *ptr, struct tcp_sock *tp,
>  				      opts->reset_transient,
>  				      opts->reset_reason);
>  		return;
> +	} else if (unlikely(!opts->suboptions)) {
> +		mptcp_track_rwin(tp);
> +		return;
>  	}
>  
>  	if (OPTION_MPTCP_PRIO & opts->suboptions) {

