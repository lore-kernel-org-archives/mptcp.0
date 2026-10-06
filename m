Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A6526CE32
	for <mptcp@lists.linux.dev>; Tue,  6 Oct 2026 19:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791314283; cv=none; b=fa3uMJ+MZJ8MFxf5C+ljT5VfGZej+gooL022+Ns6kzzWwGq0k7PoxXJws4uYujihKalURASJHPgnaCKrNWcmyrs88ksfzPliB6WHIjoxk7oLmyc2cTzTApIqNNlPeRESxTh6QyIpE5/607hMNSw6pJzzcE1sc2Ib5TI1WBmawNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791314283; c=relaxed/simple;
	bh=N/dK9JuKhTPvt7bC3j2gviv1K8XGDV4+uDAZz+yMGh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eFYB12pDL9MmeC79taayXnOtBlKodiFRYAU7vC/sB2nDqds7+f5YPjIoC3P+gMAaTLKu704WwtSgk8kcj35pZz1J8bWlw/8j9IAqCBOsA/BKPD1JKCOt77X5KSjukYnHugy8fCE5ieyMJl8ZPRklRRH1HgRGRGYVkpo90lOaiZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzLNUVd7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzLNUVd7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D51B1F0089B;
	Tue,  6 Oct 2026 19:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791314280;
	bh=IPoK5EVQauvha5sCEw35wog2pjJZaW+4FMXiiFba4UE=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=PzLNUVd7ZBT/8EEbg3C9zD5lW+aTZBSkmaJKd/JHCtEBFFtgOafaB2DUavp+EgbQP
	 jo3DSSV0q7Oa8CH//Bht7DjaSSS0B0rW6HHzCsolI8suYmcI2+eMNoWu/c7s2wsKP6
	 Fmng0ml6BqDo+sFXl6hvqC9M23umrOa3ZJd4vey+1zF7Psa9bERqSfUExAQ8rVESwE
	 ysBA6qspDYeg2EAP4InfWFeDIcUyf/egsCzSsUbzZxUSU1YIbR4XkZ4W/dFj3hKKZW
	 iRdvcD5/EpbJM42HCq/1D89ZS5pUwFQyK67TEUGA8LsTt4C/see7LcGKODgkUHXm/m
	 qpwMvlCIMI/DA==
Message-ID: <099068f7-36a0-4937-b92d-27ac8b781043@kernel.org>
Date: Tue, 6 Oct 2026 21:17:58 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2] mptcp: fix subflow bitfield misuse
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <0c859a0153b64833949f03be2391e4d2a60f8d6d.1790160379.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <0c859a0153b64833949f03be2391e4d2a60f8d6d.1790160379.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 23/09/2026 12:47, Paolo Abeni wrote:
> The subflow status bitfield is protected by the subflow socket
> lock, with one notable exception: the `close_event_done` bit
> is actually under the msk socket lock protection.
> 
> Flipping the latter bit may corrupt other entries in the same
> bitfield.

Thank you for the fix!

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

> Move the  `close_event_done` outside the bitfield in a 32bit
> hole.
> 
> Fixes: d82809b6c5f2 ("mptcp: avoid duplicated SUB_CLOSED events")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>   - place close_event_done in the reset area, drop the chunk in
>     mptcp_close_ssk
> ---
>  net/mptcp/protocol.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 4bf04f9ecbd9..d18272fee2be 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -598,14 +598,16 @@ struct mptcp_subflow_context {
>  		closing : 1,	    /* must not pass rx data to msk anymore */
>  		valid_csum_seen : 1,        /* at least one csum validated */
>  		is_mptfo : 1,	    /* subflow is doing TFO */
> -		close_event_done : 1,       /* has done the post-closed part */
>  		mpc_drop : 1,	    /* the MPC option has been dropped in a rtx */
>  		resetting : 1,	    /* subflow is resetting */
> -		__unused : 8;
> +		__unused : 9;
>  	bool	data_avail;
>  	bool	scheduled;
>  	bool	pm_listener;	    /* a listener managed by the kernel PM? */
>  	bool	fully_established;  /* path validated */
> +	bool	close_event_done;   /* netlink event generated,

Small detail: I kept "has done the post-closed part", because it is not
just about the netlink event, but also not to call __mptcp_close_ssk() a
second time for example.

Now in our tree:

New patches for t/upstream-net and t/upstream:
- b0fee7fb1388: mptcp: fix subflow bitfield misuse
- Results: 791d82ad3995..1fbd5c79d0b0 (export-net)
- Results: 1ca5a862adc9..cc3d41a12d90 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/e8ca111352cd94ad7f8409694086020cd54589dc/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/d36866855349a0689ae2ff0b426fe1476f987238/checks

> +				     * protected by msk socket lock
> +				     */
>  	u32	lent_mem_frag;
>  	u32	remote_nonce;
>  	u32	local_nonce;

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

