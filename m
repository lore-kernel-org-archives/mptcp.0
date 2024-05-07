Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498136BB20
	for <mptcp@lists.linux.dev>; Tue,  7 May 2024 05:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715060238; cv=none; b=CZ+OomNMAOU1Pf+x52IkiaqhmkpVgfZw/ioD2OagY0vJ1koMH7+dcXaKzax/mobr3+BAf3Mtbt7N0DVlSXj9pUz9jAuBXgt4M+mEtO4UHvOKC+8MxhQUSTjnxIn7+leVxbV2o8qIRQXRMJal1IUEbZz8gE7CBmQJCsmMs3fqYi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715060238; c=relaxed/simple;
	bh=UNGXfs0DBKwfVThyrFxpfna+/M/i52FnwiFXnfu2E4w=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0RCo2Bhbq/iNBbHg2mpelYzf9+4/rDTlQXI2A5CZJeU2CB4Tc4Dq+KZMOHqWXhyCn5P8nxjrHJzcXhhFr2Umpp4fXYnr714JHjydkxyFrs2q0HzmOU7Ln8Z9+jDPhHX1nqarkB/WsQVTSNJhfPbSvG0ofjoP9jdfTb3pL8Qalc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzKZ/H9N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzKZ/H9N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E89C2BBFC
	for <mptcp@lists.linux.dev>; Tue,  7 May 2024 05:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715060237;
	bh=UNGXfs0DBKwfVThyrFxpfna+/M/i52FnwiFXnfu2E4w=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=TzKZ/H9NC/GC97DtNkSoEfNSXIuH+jPT8YXEl4r3iEsF8uSjRi+fMlFuVIdYc5e6R
	 m7C5qkvY4E1PvLqeDg+ekeal5IgMRyZ6OLZt2vAEPegFzBgwDb20DR7BWBGvZLifzQ
	 S9VF9IXVU36CJ/TzBezN3J2DxbcceUVnVBvBTPqlu1sQOgx56yEq8RYDO62PUU6cGg
	 fkVdUnAcIsCSvby66g3kZlDvPzwcXlmaRD9AGwpnVEpGsJA4KqqXPkVofpTFYsWMQx
	 ebE/SSw3/zJ3eaw04zBUVxBM5M/7tslULVcka3BW1t1AVbEU04SEvN1ES8bjdmgR9J
	 oYeR6jW6k545g==
Date: Tue, 7 May 2024 13:37:12 +0800
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v2] mptcp: fix the default value of
 scaling_ratio
Message-ID: <Zjm-CCC2wAR6QRmg@T480>
References: <0ccc1c26d27d6ee7be22806a97983d37c6ca548c.1715053270.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ccc1c26d27d6ee7be22806a97983d37c6ca548c.1715053270.git.tanggeliang@kylinos.cn>

On Tue, May 07, 2024 at 11:46:31AM +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> BPF tests fail sometimes with "bytes != total_bytes" errors:
> 
>  test_default:PASS:sched_init:default 0 nsec
>  send_data:PASS:pthread_create 0 nsec
>  send_data:FAIL:recv 936000 != 10485760 nr_recv:-1 errno:11
>  default: 3041 ms
>  server:FAIL:send 7579500 != 10485760 nr_sent:-1 errno:11
>  send_data:FAIL:pthread_join thread_ret:-11 test_default:PASS: \
> 				has_bytes_sent addr_1 0 nsec
>  test_default:PASS:has_bytes_sent addr_2 0 nsec
>  close_netns:PASS:setns 0 nsec
> 
> In this case mptcp_recvmsg() gets EAGAIN errors. This issue introduces
> by commit b8dc6d6ce931 ("mptcp: fix rcv buffer auto-tuning"). The default
> value of scaling_ratio should be TCP_DEFAULT_SCALING_RATIO, not U8_MAX.

Please update the last line of the commit log as:

'''
  value of scaling_ratio should be TCP_DEFAULT_SCALING_RATIO (128), not
  U8_MAX (255).
'''

Thanks,
-Geliang

> 
> Fixes: b8dc6d6ce931 ("mptcp: fix rcv buffer auto-tuning")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/487
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> v2:
>  - I finally found the root cause of this issue.
>  - cc Martin too.
> ---
>  net/mptcp/protocol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 579031c60937..d00cd21e8d3f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1981,9 +1981,9 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
>   */
>  static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
>  {
> +	u8 scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
>  	struct mptcp_subflow_context *subflow;
>  	struct sock *sk = (struct sock *)msk;
> -	u8 scaling_ratio = U8_MAX;
>  	u32 time, advmss = 1;
>  	u64 rtt_us, mstamp;
>  
> -- 
> 2.43.0
> 
