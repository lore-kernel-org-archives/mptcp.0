Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9236A30E0E5
	for <mptcp@lists.linux.dev>; Sat, 18 Apr 2026 18:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776535759; cv=none; b=Od8cMckd7T1etGDWVP4/aGCY8Ao8tQxY1hqZ9H6YG22aJU64i390uHsY5zAPNzagZO2pbR97OsNXNsOKH1WRlRcNq4DRN5fwW0PUM3BgxOBihXTsTcC5f29IAdi7kHa5Vh3EswwrO3vM1JSvLxG8cHHH3wCsboTn+jbPOemzl98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776535759; c=relaxed/simple;
	bh=peasedNtfhJHSn//vG0EIrbyYiHSntaL62TPXdTsLDo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AXUo3tumr4/P8mf1tL2J9r+4tZgaBZM4Mp1qkhAVDqVbgzXHOpv4dwAMZlJLap2SguTVczAcCSHM4RwCbd7QJD1INUX39FlYUhKjrbBJiqqbsONkGLFL/dp0wZEwMwDhLeYiz6N93WbBZSnUKIXqFPNuRyA05jYTOzQpK+h33/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpmcEsvU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpmcEsvU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F43EC19424;
	Sat, 18 Apr 2026 18:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776535759;
	bh=peasedNtfhJHSn//vG0EIrbyYiHSntaL62TPXdTsLDo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=NpmcEsvU/PMi2LjOKYPARn6kYpu3JI1+TKBnyzyh4iDo6h+N0OVLSUgQFndsd6BOM
	 BG1wPcI8FJRkGi/YEm8XpDaHYWSLBt6xAe+QUOeA5cdlh5ybmHMm5caCDDrOGwSfIy
	 NruDrl0k0VfBRAtoeQbzL3vcK9sFCTttlHd2X6v1vKLAyTrOFnbG52H6HpG8atOsZ6
	 qJnikXQEGEWBhdpQ4NPfPFHnwmKT489rTXGDQMfhNG11RKmcFy2NHI0p7z2oG+/zOu
	 HzsoPuh3CY8Z87rTew7SBAA58rd8aCtTJyCRn+FktLSV8hWdy2a+WfWnaakRJ30u3a
	 CfjwgiNRuOjXA==
Date: Sat, 18 Apr 2026 11:09:18 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-net v5 07/20] mptcp: pm: ADD_ADDR rtx: skip inactive
 subflows
In-Reply-To: <20260415-mptcp-inc-limits-v5-7-e54c3bf80e4e@kernel.org>
Message-ID: <632253e0-5a82-3594-ad77-df344e71cccb@kernel.org>
References: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org> <20260415-mptcp-inc-limits-v5-7-e54c3bf80e4e@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 15 Apr 2026, Matthieu Baerts (NGI0) wrote:

> When looking at the maximum RTO amongst the subflows, inactive subflows
> were taken into account: that includes stale ones, and the initial one
> if it has been already been closed.
>
> Unusable subflows are now simply skipped. Stale ones are used as an
> alternative: if there are only stale ones, to take their maximum RTO and
> avoid to eventually fallback to net.mptcp.add_addr_timeout, which is set
> to 2 minutes by default.
>
> Fixes: 30549eebc4d8 ("mptcp: make ADD_ADDR retransmission timeout adaptive")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> v2: restore accidentally deleted icsk->icsk_rto > max check
> ---
> net/mptcp/pm.c | 17 ++++++++++++-----
> 1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index bc5168831085..22ba75fa876c 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -306,20 +306,27 @@ static unsigned int mptcp_adjust_add_addr_timeout(struct mptcp_sock *msk)
> 	const struct net *net = sock_net((struct sock *)msk);
> 	unsigned int rto = mptcp_get_add_addr_timeout(net);
> 	struct mptcp_subflow_context *subflow;
> -	unsigned int max = 0;
> +	unsigned int max = 0, max_stale = 0;
>
> 	mptcp_for_each_subflow(msk, subflow) {
> 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> 		struct inet_connection_sock *icsk = inet_csk(ssk);
>
> -		if (icsk->icsk_rto > max)
> +		if (!__mptcp_subflow_active(subflow))
> +			continue;
> +
> +		if (unlikely(subflow->stale)) {
> +			if (icsk->icsk_rto > max_stale)
> +				max_stale = icsk->icsk_rto;
> +		} else if (icsk->icsk_rto > max) {
> 			max = icsk->icsk_rto;
> +		}
> 	}
>
> -	if (max && max < rto)
> -		rto = max;
> +	if (max)
> +		return max < rto ? max : rto;
>
> -	return rto;
> +	return max_stale && max_stale < rto ? max_stale : rto;

I'd find this more readable as

if (max)
         return min(max, rto);
else if (max_stale)
         return min(max_stale, rto);
else
         return rto;

- Mat


> }
>
> static void mptcp_pm_add_timer(struct timer_list *timer)
>
> -- 
> 2.53.0
>
>
>
