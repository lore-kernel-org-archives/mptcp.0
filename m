Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363D837A839
	for <mptcp@lists.linux.dev>; Wed, 19 Aug 2026 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787133408; cv=none; b=A2NPY9ylmJd8vOV/GrRIU1QcLBmPEch7cjpkPiq4kP12Fp7Ugb4R7wrkaGBFCHAuW+3bXQB8FTyJbf8FJWztscTm3zWv7bOmCP0bzflSYSwQZISpceMe0i0EOiD4y7mQjl/a6s4ISMYgnlv8WrC80qGBwkteK8XYcJoq3dJEZK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787133408; c=relaxed/simple;
	bh=awTeO6E3NsBMCkUXnSkv6gKOq2eGf7wJuuR2apOihPE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vw5kTJCONeZQncvDLz/oSZ+pZU2zH65urwf9P90t3ZCXxNVIJa2cGYAgpeEHeGbush4Gy/Lb220zYMGzOCsjACyWidGQGTRPI704QJRntGwKfEiyHHqdEVxyDUsNcMgx9nZ/WDJQt8vC1iysA8pFbNx8IHprel4NT5yDtyJVihI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJHrb/FC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJHrb/FC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237821F00A3A;
	Wed, 19 Aug 2026 09:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787133406;
	bh=My/IoT1Opn0YwzX/j90k4IssKDtcL0jtzSJXPhugGkg=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=dJHrb/FC75LT7l6KhF1HBWMYPZc1xSESPZub8w8vB7ivyCMMQveSpb49DMxPltKff
	 LHE+u5LwCxqJPB+ja8xhADYmT1PNCPfF7YYNKfC0AJffLqo179+frxneaHbqJTZoub
	 neLHvsHmhN0C0VP9ve6AzX8bDZbQu0kJSQtYoJo6vItM4d0kwm62Vl5Ti1vIVNS44r
	 makFm6McwpIhDhkVKPfwbaaKs99DNJ+5CVjeXWpN2FElpcv0/O4gmVMwCKnwixJxuU
	 ktYRS3AcBSDw9e0bTQUc7r4tB+5zmP9koiXgS3NE+EFUjYkI/rDxDV+FolhN+QQCYs
	 XySFcqpL3/Nww==
Message-ID: <b38f34dda21fcfe46b1ecf493c268ca393a8e570.camel@kernel.org>
Subject: Re: [PATCH next mptcp-net 3/3] mptcp: remove thmac from subflow ctx
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Linux
	 <mptcp@lists.linux.dev>
Date: Wed, 19 Aug 2026 17:56:43 +0800
In-Reply-To: <20260818-mptcp-cook-reqb-v1-3-052dea9a7f20@kernel.org>
References: <20260818-mptcp-cook-reqb-v1-0-052dea9a7f20@kernel.org>
	 <20260818-mptcp-cook-reqb-v1-3-052dea9a7f20@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Tue, 2026-08-18 at 19:55 +0200, Matthieu Baerts (NGI0) wrote:
> This entry is only used in subflow_finish_connect().
> 
> Instead, use the original value from mp_opt, and pass it to
> subflow_thmac_valid() to do the validation with the given truncated
> hmac.
> 
> While at it, rename the variables in subflow_thmac_valid() to avoid
> confusions about the received one vs the expected one.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/protocol.h |  1 -
>  net/mptcp/subflow.c  | 18 +++++++++---------
>  2 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 7e168e450fb0..d414065d1966 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -592,7 +592,6 @@ struct mptcp_subflow_context {
>  	bool	fully_established;  /* path validated */
>  	u32	lent_mem_frag;
>  	u32	remote_nonce;
> -	u64	thmac;
>  	u32	local_nonce;
>  	u32	remote_token;
>  	union {
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 01db7edce18a..2d7ccb01d234 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -408,20 +408,21 @@ static struct dst_entry
> *subflow_v6_route_req(const struct sock *sk,
>  #endif
>  
>  /* validate received truncated hmac and create hmac for third ACK */
> -static bool subflow_thmac_valid(struct mptcp_subflow_context
> *subflow)
> +static bool subflow_thmac_valid(struct mptcp_subflow_context
> *subflow,
> +				u64 thmac)

Perhaps we could rename this parameter, say to "subflow_thmac", so that
we don't need to rename the local variable "thmac" to "expected_thmac".
What do you think?

Thanks,
-Geliang

>  {
>  	u8 hmac[SHA256_DIGEST_SIZE];
> -	u64 thmac;
> +	u64 expected_thmac;
>  
>  	subflow_generate_hmac(subflow->remote_key, subflow-
> >local_key,
>  			      subflow->remote_nonce, subflow-
> >local_nonce,
>  			      hmac);
>  
> -	thmac = get_unaligned_be64(hmac);
> -	pr_debug("subflow=%p, token=%u, thmac=%llu, subflow-
> >thmac=%llu\n",
> -		 subflow, subflow->token, thmac, subflow->thmac);
> +	expected_thmac = get_unaligned_be64(hmac);
> +	pr_debug("subflow=%p, token=%u, expected_thmac=%llu,
> thmac=%llu\n",
> +		 subflow, subflow->token, expected_thmac, thmac);
>  
> -	return thmac == subflow->thmac;
> +	return expected_thmac == thmac;
>  }
>  
>  void mptcp_subflow_reset(struct sock *ssk)
> @@ -571,14 +572,13 @@ static void subflow_finish_connect(struct sock
> *sk, const struct sk_buff *skb)
>  		}
>  
>  		subflow->backup = mp_opt.backup;
> -		subflow->thmac = mp_opt.thmac;
>  		subflow->remote_nonce = mp_opt.nonce;
>  		WRITE_ONCE(subflow->remote_id, mp_opt.join_id);
>  		pr_debug("subflow=%p, thmac=%llu, remote_nonce=%u
> backup=%d\n",
> -			 subflow, subflow->thmac, subflow-
> >remote_nonce,
> +			 subflow, mp_opt.thmac, subflow-
> >remote_nonce,
>  			 subflow->backup);
>  
> -		if (!subflow_thmac_valid(subflow)) {
> +		if (!subflow_thmac_valid(subflow, mp_opt.thmac)) {
>  			MPTCP_INC_STATS(sock_net(sk),
> MPTCP_MIB_JOINSYNACKMAC);
>  			subflow->reset_reason = MPTCP_RST_EMPTCP;
>  			goto do_reset;
