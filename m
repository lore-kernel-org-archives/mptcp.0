Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841E227E1DC
	for <mptcp@lists.linux.dev>; Thu,  8 Oct 2026 13:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791464599; cv=none; b=VlHRAKuIo4tEAq+2VfRmcR7IpSQFWvtgD2+Eq47KgRbKhlZh+vKACZCWXwMWTXJ9ZGioLgEv/SaPgh0rbmiePVl2VAVEM9ZzIJAYDg2gOy0ZX/UWhkmdOFfJyx4yxgWcyX+XuJKfYM1b1l3Sh/LFpSY5MkWUsohYrG1Mmy24KTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791464599; c=relaxed/simple;
	bh=mpz9OndGk8cglqmSKEWKMb0ZitgMMBfgne3ep24joJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ejPqIGO5AOmWNu0QQ0SgSebFiPzKVtQ4uvHlvnVmxi+oLiOJVPa7d2DcGruIou/Su2T/Bam2J1F1tpqAXd0laTb7C9g+m/kZbjYYZvTDmS3XDPDzvN0fojBK0bRzNlaBHntnTo2jzoWlQ3mjL30t89WAiL5AmJBYLV1CcKHDL54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBZWM8ys; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBZWM8ys"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E201F000FF;
	Thu,  8 Oct 2026 13:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791464598;
	bh=tbJL1mErH/ULVydLAFJ9T0WTWH26BSGqLxFBll4I4Ag=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OBZWM8ysPWBRjAaK9OQmZDnH+TDG+u3N+oo6Yu/uHlWTuXWHQepluSoAkZ4cSbJZk
	 DT67k9zKfPf232tI8I0h2YEsRajjUDpZV1OT3d1Rdv18NVzmnLWUGVnDjNwesHeyGV
	 iN6UctseXDEkwotPDwT3941CjgEVUMLNlq0Q3zYscRHFEs4WtMnuy1jVQTnWH3WwaL
	 g4r9Hv3Pq1zC4hDON+xu1BSjeawUFCxodd6AHc7u55BzN4Lo5MJIStMGBoMwZzPtrZ
	 yHckigAiqXcLrmEB8DNe1HcdGgLbDYYF3ffRsJZ/2H05Q7JK9zyf9zqetjwn9gTy25
	 0BlZ7pMhueqbA==
Message-ID: <a6269e21-a506-4607-b39a-3b4d2e4cccf6@kernel.org>
Date: Thu, 8 Oct 2026 15:03:13 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v4] mptcp: push queued data on passive TFO subflows
 becoming established
Content-Language: fr
To: T S Rameshkumar <rameshsv06@gmail.com>, mptcp@lists.linux.dev
Cc: petar.sakic@ink.fish, T S Rameshkumar <rameshkumar.t@phytecembedded.in>
References: <20261008124220.213016-1-rameshkumar.t@phytecembedded.in>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261008124220.213016-1-rameshkumar.t@phytecembedded.in>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi T S,

Thank you for the patch, but *please* stop sending multiple version the
same day without waiting for reviews. The patch traffic is already high:
if everybody sends so many versions like that, we (human) cannot deal
with that, plus it is unlikely the patch can be tested properly. Also,
please increment the patch version and include a changelog ("b4" can
help with that).

  https://docs.kernel.org/process/maintainer-netdev.html

Also, if you send your patch to the MPTCP list only, please base your
patch on top of our "export" branch: this version doesn't apply on top
of it.

On 08/10/2026 14:42, T S Rameshkumar wrote:
> With TCP Fast Open on an MPTCP listener, if the server application
> writes data while the passive subflow is still in SYN_RECV (after
> consuming the client's SYN data but before the MP_CAPABLE third ACK
> arrives), __mptcp_subflow_active() refuses transmission and the data
> is queued into the msk write queue.
> 
> When the MPC third ACK arrives, the subflow transitions to
> TCP_ESTABLISHED and is marked fully established in
> check_fully_established(), but because the third ACK carries no
> DSS data, the queued bytes remain stranded until the peer sends
> more data.
> 
> Fix this in check_fully_established() by checking if the subflow
> was doing passive TFO (subflow->is_mptfo). Under mptcp_data_lock(),
> flush queued bytes via __mptcp_check_push() and clear is_mptfo.

Why do you need to clear is_mptfo?

If it is not needed, you probably don't need to move is_mptfo. Also, we
would go back to the version shared by Petar.

@Petar: are you working with T S? Because if you suggested the patch, we
should at least add a "Suggested-by" tag. Is it OK with the
attributions? (Next time, please send a formal patch to avoid any
conflicts here ;))

> Also move is_mptfo from the shared u32 bitfield to a standalone
> bool in struct mptcp_subflow_context to avoid any read-modify-write
> data races with concurrent bitfield modifications (e.g.
> close_event_done in mptcp_close_ssk()).
> 
> Reported-by: Petar Sakic <petar.sakic@ink.fish>
> Closes: https://lore.kernel.org/netdev/CAFPPu1gU2Y-D+d4i3F0MoNkYK+e1U+=X3qf6QycjfKBw+8snPg@mail.gmail.com/
> Fixes: fb7084501a61 ("mptcp: add support for TCP_FASTOPEN sockopt")
> Assisted-by: Gemini 3.7
> Signed-off-by: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
> ---
>  net/mptcp/fastopen.c | 2 +-
>  net/mptcp/options.c  | 9 +++++++++
>  net/mptcp/protocol.h | 4 ++--
>  3 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
> index f71775090..c11fc3c5c 100644
> --- a/net/mptcp/fastopen.c
> +++ b/net/mptcp/fastopen.c
> @@ -29,7 +29,7 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
>  	if (!skb)
>  		return;
>  
> -	subflow->is_mptfo = 1;
> +	subflow->is_mptfo = true;
>  
>  	/* dequeue the skb from sk receive queue */
>  	__skb_unlink(skb, &ssk->sk_receive_queue);
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index ce0de02f5..7ea97b283 100644
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
> +		subflow->is_mptfo = false;
> +		__mptcp_check_push((struct sock *)msk, ssk);
> +	}
>  	mptcp_data_unlock((struct sock *)msk);
>  
>  check_notify:
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 0384d6a02..0e44de129 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -582,15 +582,15 @@ struct mptcp_subflow_context {
>  		disposable : 1,	    /* ctx can be free at ulp release time */
>  		closing : 1,	    /* must not pass rx data to msk anymore */
>  		valid_csum_seen : 1,        /* at least one csum validated */
> -		is_mptfo : 1,	    /* subflow is doing TFO */
>  		close_event_done : 1,       /* has done the post-closed part */
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

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

