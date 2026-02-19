Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BC42E0914
	for <mptcp@lists.linux.dev>; Thu, 19 Feb 2026 19:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771528953; cv=none; b=QK98wdsi93myAaZNcmZg6103BIVgcWAepM1mCPz8qrTpcdl/A+XbSEDi5+Q+ZrqJ3f4VvZPh84dOTtApPgl/8OcI9PC3c+HpYMonqoKE407aDdry0uWKA7JnRgzUIaai8Tja5vx6MtLiAXG2shuG3U5Ok/XaSe+tOY6YB2az+2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771528953; c=relaxed/simple;
	bh=b6/ZToctzbBhLIWI3bECb7eEH6oTKYAjlcfjeCl7+00=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ipO5DAXrePZLZZhNjK71UZ5NjJpc0Gn+zFPGhmmvGnDaL2i718c3uHWtfmWIBi9/YDmQI2jUAw6o7Zx1hJinHB1U2E0AYEZdnSgq/BjmYj7Y+7j1ybv5hUtB4ZnzK2MkR/c7VLVfwPRwtKEHmekNMkH1aj6HLq+g9WGAnR7/0rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQuWKSi8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQuWKSi8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1421BC4CEF7
	for <mptcp@lists.linux.dev>; Thu, 19 Feb 2026 19:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771528952;
	bh=b6/ZToctzbBhLIWI3bECb7eEH6oTKYAjlcfjeCl7+00=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=hQuWKSi8uJ7JYyKHtmvhRRQ0mRzHJBuRic/PdVjVyiXXZHD1Sa0Gn4OQc+2UV+ctx
	 oTDj4ay/+y/JywsPWrvSjTETgO6c7Fa0wH4nQVanHoZ1bn+6fIhpiBiBkDPuRkBhWT
	 19qkW1HcEA2yQgnfk/lhMKZOIscb1zbMyeaTK57Rpih2fBwMc6SL1VvBFkyagU4GrN
	 WOeUNKcR1hgd7TSif6DFdCbeogEuseLd79TIpqjMB8z4qS9BKw3rLNUnka8cYsix/N
	 z7ARPyp3vIf4ceQiRlTHNfo2WdqYbuuuSRHFct9JwdH2s2oPffSzvVczzHu29/r3MC
	 GFWk30Oq1tX4w==
Message-ID: <ddb914a8-a93a-4f76-a9d2-8dcaa9f625ec@kernel.org>
Date: Thu, 19 Feb 2026 20:22:29 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 1/2] mptcp: pm: avoid sending RM_ADDR over same
 subflow
Content-Language: en-GB, fr-BE
To: MPTCP Linux <mptcp@lists.linux.dev>
References: <20260219-mptcp-issue-612-v1-0-839e20d96fe7@kernel.org>
 <20260219-mptcp-issue-612-v1-1-839e20d96fe7@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260219-mptcp-issue-612-v1-1-839e20d96fe7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/02/2026 20:01, Matthieu Baerts (NGI0) wrote:
> RM_ADDR are sent over an active subflow, the first one in the subflows
> list. There is then a high chance the initial subflow is picked. With
> the in-kernel PM, when an endpoint is removed, a RM_ADDR is sent, then
> linked subflows are closed. This is done for each active MPTCP
> connection.
> 
> MPTCP endpoints are likely removed because the attached network is no
> longer available or usable. In this case, it is better to avoid sending
> this RM_ADDR over the subflow that is going to be removed, but prefer
> sending it over another active and non stale subflow, if any.
> 
> This modification avoids situations where the other end is not notified
> when a subflow is no longer usable: typically when the endpoint linked
> to the initial subflow is removed, especially on the server side.
> 
> Fixes: 8dd5efb1f91b ("mptcp: send ack for rm_addr")
> Reported-by: Frank Lorenz
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/612
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/pm.c | 52 +++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 41 insertions(+), 11 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 8206b0fd2377..ef76fbc40915 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -212,9 +212,24 @@ void mptcp_pm_send_ack(struct mptcp_sock *msk,
>  	spin_lock_bh(&msk->pm.lock);
>  }
>  
> -void mptcp_pm_addr_send_ack(struct mptcp_sock *msk)
> +static bool subflow_in_rlist(const struct mptcp_subflow_context *subflow,
> +			     const struct mptcp_rm_list *rlist)
>  {
> -	struct mptcp_subflow_context *subflow, *alt = NULL;
> +	u8 i, id = subflow_get_local_id(subflow);
> +
> +	for (i = 0; i < rlist->nr; i++) {
> +		if (rlist->ids[i] == id)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void
> +mptcp_pm_addr_send_ack_avoid_list(struct mptcp_sock *msk,
> +				  const struct mptcp_rm_list *rlist)
> +{
> +	struct mptcp_subflow_context *subflow, *stale = NULL, *same_id = NULL;
>  
>  	msk_owned_by_me(msk);
>  	lockdep_assert_held(&msk->pm.lock);
> @@ -225,18 +240,33 @@ void mptcp_pm_addr_send_ack(struct mptcp_sock *msk)
>  
>  	mptcp_for_each_subflow(msk, subflow) {
>  		if (__mptcp_subflow_active(subflow)) {

I should probably remove one level by doing:

  if (!__mptcp_subflow_active(subflow))
       continue;

I can send a v2 later, but feel free to review, it doesn't change the
fix here.

> -			if (!subflow->stale) {
> -				mptcp_pm_send_ack(msk, subflow, false, false);
> -				return;
> +			if (unlikely(subflow->stale)) {
> +				if (!stale)
> +					stale = subflow;
> +			} else if (unlikely(rlist &&
> +					    subflow_in_rlist(subflow, rlist))) {
> +				if (!same_id)
> +					same_id = subflow;
> +			} else {
> +				goto send_ack;
>  			}
> -
> -			if (!alt)
> -				alt = subflow;
>  		}
>  	}
>  
> -	if (alt)
> -		mptcp_pm_send_ack(msk, alt, false, false);
> +	if (same_id)
> +		subflow = same_id;
> +	else if (stale)
> +		subflow = stale;

Note: in my initial version, I only used one alternative for both
"stale" and "same id" subflows. I guess it is better to send over the
same subflow than a stale one, hence the priority, but there are then a
few more lines of code. To be discussed.

> +	else
> +		return;
> +
> +send_ack:
> +	mptcp_pm_send_ack(msk, subflow, false, false);
> +}
> +
> +void mptcp_pm_addr_send_ack(struct mptcp_sock *msk)
> +{
> +	mptcp_pm_addr_send_ack_avoid_list(msk, NULL);
>  }
>  
>  int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
> @@ -470,7 +500,7 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
>  	msk->pm.rm_list_tx = *rm_list;
>  	rm_addr |= BIT(MPTCP_RM_ADDR_SIGNAL);
>  	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
> -	mptcp_pm_addr_send_ack(msk);
> +	mptcp_pm_addr_send_ack_avoid_list(msk, rm_list);
>  	return 0;
>  }
>  
> 

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

