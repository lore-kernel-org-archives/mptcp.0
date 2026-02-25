Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C557819A2A3
	for <mptcp@lists.linux.dev>; Wed, 25 Feb 2026 04:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771992774; cv=none; b=ofyhLdM9dQwNipZOI6scNvL99GYAbAMRjuPsBV3lLfOogIHOQ/B0vkag0rLmWscVi5DYmQd1Ia7Q5jM+fQp/mrRFeGkoHBFoa2IIQVawQ7o+OxcpMjC3ZIDr1RwukwhpjRr+rNtMfYsiJk/82/F2FNA0JQvpXGOGt1k93kxwxgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771992774; c=relaxed/simple;
	bh=R3CI/lbDD3BWP5eQAT1khfGiXMYzSnbTwUdgAe2jWS0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oOnYI5ptewL57QDU+vH7DZVtBXOLb2nH3Abx1Y1dKJaenFjK1r1BK2YORUnBLIs2DvX68Nmst/X0i+anERM3rke2QAyx5OCqV4Lsfbcimry6gSDrHO9Ut2+fkE7KUYF58zKibi7YAU8boWq5Gb6NSWlEgSoCRFMUC683hk8HaVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkNVUWwV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkNVUWwV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C288C116D0;
	Wed, 25 Feb 2026 04:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771992774;
	bh=R3CI/lbDD3BWP5eQAT1khfGiXMYzSnbTwUdgAe2jWS0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=SkNVUWwVFOcH+KVluqJa4nb06lM8wt7pOjm0UG7g4BZdoTrcX1PPt6sV5rxoouP4K
	 IO5RLdCWDkN/Mz3EJKXKXGWYa7BqnETKw6/jxRA0QKWQOAdr1JvuG0OhxLidfRV5e/
	 n2Ov2+2Gk8OUWAckYBVlYUkL7hJPo3fwStVliGEw0oHcH7OAfkVh07YUb5gWJOIiYU
	 wBSHB1q7GGpcy8y7a45D3a/gBzf0hvTAnllI4G9tU7/kACLutKrT//ZehmIRMxk3T9
	 wBbCjGHtmJb8glHu4UP8P1mgktq6Td+t4wG74fvDYf0BgIIsJg/+PCqSVTUT+KJYmd
	 Abc8NFn1kWP5w==
Date: Tue, 24 Feb 2026 20:12:53 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-net v2 1/2] mptcp: pm: avoid sending RM_ADDR over
 same subflow
In-Reply-To: <20260220-mptcp-issue-612-v2-1-089684a6edcb@kernel.org>
Message-ID: <60bfc032-effc-f85f-6e64-7af0cd3daeeb@kernel.org>
References: <20260220-mptcp-issue-612-v2-0-089684a6edcb@kernel.org> <20260220-mptcp-issue-612-v2-1-089684a6edcb@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 20 Feb 2026, Matthieu Baerts (NGI0) wrote:

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
> Note: in my initial version, I only used one alternative for both
> "stale" and "same id" subflows. I guess it is better to send over the
> same subflow than a stale one, hence the priority, but there are then a
> few more lines of code (but still readable, I think). To be discussed.
>
> v2:
> - reduce one indentation level and s/rlist/rm_list/g
> ---
> net/mptcp/pm.c | 55 +++++++++++++++++++++++++++++++++++++++++++------------
> 1 file changed, 43 insertions(+), 12 deletions(-)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 8206b0fd2377..daef91e597ae 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -212,9 +212,24 @@ void mptcp_pm_send_ack(struct mptcp_sock *msk,
> 	spin_lock_bh(&msk->pm.lock);
> }
>
> -void mptcp_pm_addr_send_ack(struct mptcp_sock *msk)
> +static bool subflow_in_rm_list(const struct mptcp_subflow_context *subflow,
> +			       const struct mptcp_rm_list *rm_list)
> {
> -	struct mptcp_subflow_context *subflow, *alt = NULL;
> +	u8 i, id = subflow_get_local_id(subflow);
> +
> +	for (i = 0; i < rm_list->nr; i++) {
> +		if (rm_list->ids[i] == id)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void
> +mptcp_pm_addr_send_ack_avoid_list(struct mptcp_sock *msk,
> +				  const struct mptcp_rm_list *rm_list)
> +{
> +	struct mptcp_subflow_context *subflow, *stale = NULL, *same_id = NULL;
>
> 	msk_owned_by_me(msk);
> 	lockdep_assert_held(&msk->pm.lock);
> @@ -224,19 +239,35 @@ void mptcp_pm_addr_send_ack(struct mptcp_sock *msk)
> 		return;
>
> 	mptcp_for_each_subflow(msk, subflow) {
> -		if (__mptcp_subflow_active(subflow)) {
> -			if (!subflow->stale) {
> -				mptcp_pm_send_ack(msk, subflow, false, false);
> -				return;
> -			}
> +		if (!__mptcp_subflow_active(subflow))
> +			continue;
>
> -			if (!alt)
> -				alt = subflow;
> +		if (unlikely(subflow->stale)) {
> +			if (!stale)
> +				stale = subflow;
> +		} else if (unlikely(rm_list &&
> +				    subflow_in_rm_list(subflow, rm_list))) {
> +			if (!same_id)
> +				same_id = subflow;
> +		} else {
> +			goto send_ack;

Hi Matthieu -

This is definitely an improvement over the older code, thanks! It does 
still send RM_ADDR exactly once. It could also RM_ADDR using *all* active 
non-stale subflows (any that are delivered after the first would be 
ignored). In terms of interoperability there is the risk of confusing the 
peer's path manager if it doesn't handle RM_ADDR for a non-existant 
subflow.

Maybe that's more of a mptcp-next feature (if it makes sense to do at 
all).

The v2 patch here is closer to the existing behavior so I'm ok with 
approving it:

Reviewed-by: Mat Martineau <martineau@kernel.org>

> 		}
> 	}
>
> -	if (alt)
> -		mptcp_pm_send_ack(msk, alt, false, false);
> +	if (same_id)
> +		subflow = same_id;
> +	else if (stale)
> +		subflow = stale;
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
> }
>
> int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
> @@ -470,7 +501,7 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
> 	msk->pm.rm_list_tx = *rm_list;
> 	rm_addr |= BIT(MPTCP_RM_ADDR_SIGNAL);
> 	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
> -	mptcp_pm_addr_send_ack(msk);
> +	mptcp_pm_addr_send_ack_avoid_list(msk, rm_list);
> 	return 0;
> }
>
>
> -- 
> 2.51.0
>
>
>
