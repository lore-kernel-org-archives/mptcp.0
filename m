Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789E510A1E
	for <mptcp@lists.linux.dev>; Thu,  8 Aug 2024 22:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723156881; cv=none; b=ZIordetVPClTg3Fuc74jZe0Tjwh9wCNjeRN4Xp2R97WMP5Qu7w0Ctymg38NZimwaCSzfvOHYQ5+VXrikLJMre9E1AsaX1hVE9yLS/q3Rhsq4q+eqM+PbdFryv8ESgNtJQNnHPu4eijL2dnlQcwUHfYrZScmclRHVcyhCWK+eQ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723156881; c=relaxed/simple;
	bh=zPUocssk4IiKNcoAKtbpDKlmN3puKjP5O2xUy9r+8M4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=E5dJWNvBiq4CrMXuMkVrV09KnTzPIzL0wGNHPvndqfx0R7aYxG9b8HdUECetXcanoF02uwkoM5w/V8k1gic61YrOnHXiGuLe/d1xVox4WbHPWedc6wXmTNyd+rtNjZst/yWMLkC3R11c07fev27CLUtV7HlHwTQlaeu3AmItdRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKNxrZ4O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKNxrZ4O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1572C32782;
	Thu,  8 Aug 2024 22:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723156880;
	bh=zPUocssk4IiKNcoAKtbpDKlmN3puKjP5O2xUy9r+8M4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=gKNxrZ4OMHUIA1eZCtFQUCnRgj6Yig/7tzr79TGmNkEngRCcD8W6UK76QfTaeb4KH
	 WQ6M72Pv52IkajKYTZH+9hmnUHgX03fQPb8VjxSBlnK63FfBVfnLdKQStyBuR60p/A
	 cuday5yOwLMiTAZQzAK7JfIKdLpzuTZ7kZFJMJgYsfKkaDNYYuVIOU8rN1efs5H7MO
	 MLKOr8qh+yTxpAAlMuMYrIMVGrmQ37yrZTjYj2eU9wbB1j3bfRMZ0Kqz1fJJuzqnsi
	 wwPbi+aLjZPzoUZcJ8eGf+we/I9EM7Atb78LNBmIGYfDdZddbBRppFw5zAMU21D9x1
	 Pcs7AXjeKQxpg==
Date: Thu, 8 Aug 2024 15:41:20 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH] Squash to "mptcp: pm: send ACK on non stale subflows"
In-Reply-To: <20240807143438.1471057-2-matttbe@kernel.org>
Message-ID: <a14d403e-2fbd-8596-c2b8-d74908caede0@kernel.org>
References: <20240807143438.1471057-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 7 Aug 2024, Matthieu Baerts (NGI0) wrote:

> If there are only "staled" subflows, pick the first one we found (Mat).
>
> Note that we could also check:
>
>  !subflow>backup && !subflow->request_bkup
>
> It's only a ACK, maybe OK to send that on the backup paths?
>
> If we want this, should we have two alternatives?
>
>  - First try on backup if any ; if not, on "staled" ones?
>
>  - Or just on one of them?
>
> We can also fill an issue, and wait for feedback.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Thanks Matthieu, looks good to squash.

- Mat

> ---
> Based-on: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org>
> ---
> net/mptcp/pm_netlink.c | 16 ++++++++++++----
> 1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index cb8f7de7ed6c..3bdb0219188f 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -762,7 +762,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
>
> void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
> {
> -	struct mptcp_subflow_context *subflow;
> +	struct mptcp_subflow_context *subflow, *alt = NULL;
>
> 	msk_owned_by_me(msk);
> 	lockdep_assert_held(&msk->pm.lock);
> @@ -772,11 +772,19 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
> 		return;
>
> 	mptcp_for_each_subflow(msk, subflow) {
> -		if (!subflow->stale && __mptcp_subflow_active(subflow)) {
> -			mptcp_pm_send_ack(msk, subflow, false, false);
> -			break;
> +		if (__mptcp_subflow_active(subflow)) {
> +			if (!subflow->stale) {
> +				mptcp_pm_send_ack(msk, subflow, false, false);
> +				return;
> +			}
> +
> +			if (!alt)
> +				alt = subflow;
> 		}
> 	}
> +
> +	if (alt)
> +		mptcp_pm_send_ack(msk, alt, false, false);
> }
>
> int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
> -- 
> 2.45.2
>
>
>
