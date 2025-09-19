Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA544277C95
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 06:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758264744; cv=none; b=cGVVOKmUwwkPQ/+n9kMd/lqZ0Pymx1TZ2xdZFt3LPgho5E/kMi4JC41OUc/4jZQpyLU1qQYWO77DwDYAPSmJk+BAKQGxsdsm72JqNMtMXcQMPH6LG211tAo4zip0vbPVLXxbyn9qqpz264YJygt/OncvF7iuvotHKRx3XJDhsbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758264744; c=relaxed/simple;
	bh=Coz55viuUxzX3FbAycIQW9HhH60bGopawQDGduFw+kE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bwOu21v/d0kheFltumdPzURbUrBeHYvTdsl1rXZbbxHt6BEZMmeIHMGY3FGAzouatV1bDquUZWZ6ZEiPMoQEsvkqUl3zhVo5SopTR3GNaYf3UzSfzTebtOZHKmCsYC3edL+W6JFVqg3eMhHMSCrwiOy3UuDYt7ZmOsxsT+2F0QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gma5HNZj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gma5HNZj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90292C4CEF0;
	Fri, 19 Sep 2025 06:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758264743;
	bh=Coz55viuUxzX3FbAycIQW9HhH60bGopawQDGduFw+kE=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=Gma5HNZj6PDhnGtmkt/eMM3vij2KK5HaljcpmVapjWCwD5sJdPTAb/2hjWbh/v/vn
	 aJAVNYlsIKKplBGGZtYo6VF2SqThI6uB53WsUlJ3ALaz+CvxS+sxcw21/0RPqoIuYV
	 NRZcskQrlCXqRYg2wvlEhCXTaen3l7sEKZwab03f4Cjo70v9gmRDq1ef7SrH9nI9Ls
	 W1nwHBpBo985x0ncZJ7loFbiGg3C4yjsZzKvpji8PEANUeM5SLwy1yjX47o8L28nUc
	 j9X5lrLasQRnltITIQXsuH/DL1ZllzytWjfab28GGol4phfTmjTUWHedAnH5QnHzkc
	 iUKlARrhRHA0Q==
Message-ID: <fc0faacf990d5c422dac4525ae02f64a448a8e9f.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 03/10] mptcp: pm: in-kernel: refactor
 fill_remote_addresses_vec
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Fri, 19 Sep 2025 14:52:20 +0800
In-Reply-To: <20250918-pm-kern-endp-add_addr-v1-3-e12e58770a11@kernel.org>
References: <20250918-pm-kern-endp-add_addr-v1-0-e12e58770a11@kernel.org>
	 <20250918-pm-kern-endp-add_addr-v1-3-e12e58770a11@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Thu, 2025-09-18 at 19:42 +0200, Matthieu Baerts (NGI0) wrote:
> Before this modification, this function was quite long with many
> levels
> of indentations.
> 
> Each case can be split in a dedicated function: fullmesh, non-
> fullmesh.

How about splitting this patch into two, one for 'fullmesh', one for
'non-fullmesh'.

> 
> To remove one level of indentation, msk->pm.subflows >= subflows_max
> is
> now checked after having added one subflow, and stops the loop if it
> is
> no longer possible to add new subflows. This is fine to do this
> because
> this function should only be called if msk->pm.subflows <
> subflows_max.
> 
> No functional changes intended.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/pm_kernel.c | 112 ++++++++++++++++++++++++++++------------
> ----------
>  1 file changed, 63 insertions(+), 49 deletions(-)
> 
> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index
> 5bdcfcc26308841c49375ce35205097f30592279..8d5df9b98589e5cd69f16dc54e9
> 140e88a1835e2 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -159,74 +159,88 @@ select_signal_address(struct pm_nl_pernet
> *pernet, const struct mptcp_sock *msk,
>  	return found;
>  }
>  
> -/* Fill all the remote addresses into the array addrs[],
> - * and return the array size.
> - */
> -static unsigned int fill_remote_addresses_vec(struct mptcp_sock
> *msk,
> -					      struct mptcp_addr_info
> *local,
> -					      bool fullmesh,
> -					      struct mptcp_addr_info
> *addrs)
> +static unsigned int
> +fill_remote_addr(struct mptcp_sock *msk, struct mptcp_addr_info
> *local,
> +		 struct mptcp_addr_info *addrs)
>  {
>  	bool deny_id0 = READ_ONCE(msk->pm.remote_deny_join_id0);
> +	struct sock *sk = (struct sock *)msk;
> +	struct mptcp_addr_info remote = { 0 };

This breaks 'Reverse X-Mas Tree' order.

> +
> +	if (deny_id0)
> +		return 0;
> +
> +	mptcp_remote_address((struct sock_common *)sk, &remote);
> +
> +	if (!mptcp_pm_addr_families_match(sk, local, &remote))
> +		return 0;
> +
> +	msk->pm.subflows++;
> +	*addrs = remote;
> +
> +	return 1;

How about still using:

addrs[i++] = remote;
return i;

here, to keep it consistent with other fill_*_addr helpers.

> +}
> +
> +static unsigned int
> +fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
> +			       struct mptcp_addr_info *local,
> +			       struct mptcp_addr_info *addrs)
> +{
> +	bool deny_id0 = READ_ONCE(msk->pm.remote_deny_join_id0);
> +	DECLARE_BITMAP(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
>  	struct sock *sk = (struct sock *)msk, *ssk;
>  	struct mptcp_subflow_context *subflow;
> -	struct mptcp_addr_info remote = { 0 };
>  	unsigned int subflows_max;
>  	int i = 0;
>  
>  	subflows_max = mptcp_pm_get_subflows_max(msk);
> -	mptcp_remote_address((struct sock_common *)sk, &remote);
>  
> -	/* Non-fullmesh endpoint, fill in the single entry
> -	 * corresponding to the primary MPC subflow remote address
> +	/* Forbid creation of new subflows matching existing ones,
> possibly
> +	 * already created by incoming ADD_ADDR
>  	 */
> -	if (!fullmesh) {
> -		if (deny_id0)
> -			return 0;
> +	bitmap_zero(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
> +	mptcp_for_each_subflow(msk, subflow)
> +		if (READ_ONCE(subflow->local_id) == local->id)
> +			__set_bit(subflow->remote_id, unavail_id);
>  
> -		if (!mptcp_pm_addr_families_match(sk, local,
> &remote))
> -			return 0;
> +	mptcp_for_each_subflow(msk, subflow) {
> +		ssk = mptcp_subflow_tcp_sock(subflow);
> +		mptcp_remote_address((struct sock_common *)ssk,
> &addrs[i]);
> +		addrs[i].id = READ_ONCE(subflow->remote_id);
> +		if (deny_id0 && !addrs[i].id)
> +			continue;
>  
> +		if (test_bit(addrs[i].id, unavail_id))
> +			continue;
> +
> +		if (!mptcp_pm_addr_families_match(sk, local,
> &addrs[i]))
> +			continue;
> +
> +		/* forbid creating multiple address towards this id
> */
> +		__set_bit(addrs[i].id, unavail_id);
>  		msk->pm.subflows++;
> -		addrs[i++] = remote;
> -	} else {
> -		DECLARE_BITMAP(unavail_id, MPTCP_PM_MAX_ADDR_ID +
> 1);
> +		i++;
>  
> -		/* Forbid creation of new subflows matching existing
> -		 * ones, possibly already created by incoming
> ADD_ADDR
> -		 */
> -		bitmap_zero(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
> -		mptcp_for_each_subflow(msk, subflow)
> -			if (READ_ONCE(subflow->local_id) == local-
> >id)
> -				__set_bit(subflow->remote_id,
> unavail_id);
> -
> -		mptcp_for_each_subflow(msk, subflow) {
> -			ssk = mptcp_subflow_tcp_sock(subflow);
> -			mptcp_remote_address((struct sock_common
> *)ssk, &addrs[i]);
> -			addrs[i].id = READ_ONCE(subflow->remote_id);
> -			if (deny_id0 && !addrs[i].id)
> -				continue;
> -
> -			if (test_bit(addrs[i].id, unavail_id))
> -				continue;
> -
> -			if (!mptcp_pm_addr_families_match(sk, local,
> &addrs[i]))
> -				continue;
> -
> -			if (msk->pm.subflows < subflows_max) {
> -				/* forbid creating multiple address
> towards
> -				 * this id
> -				 */
> -				__set_bit(addrs[i].id, unavail_id);
> -				msk->pm.subflows++;
> -				i++;
> -			}
> -		}
> +		if (msk->pm.subflows >= subflows_max)
> +			break;
>  	}
>  
>  	return i;
>  }
>  
> +/* Fill all the remote addresses into the array addrs[],
> + * and return the array size.
> + */
> +static unsigned int
> +fill_remote_addresses_vec(struct mptcp_sock *msk, struct
> mptcp_addr_info *local,
> +			  bool fullmesh, struct mptcp_addr_info
> *addrs)

How about keeping this unchanged:

static unsigned int fill_remote_addresses_vec(struct mptcp_sock
*msk,
					      struct mptcp_addr_info
*local,
					      bool fullmesh,
					      struct mptcp_addr_info
*addrs)

This can make the patch smaller.

> +{

-	/* Non-fullmesh endpoint, fill in the single entry
-	 * corresponding to the primary MPC subflow remote address

We can keep this comment here.

-	if (!fullmesh) {

... and test "!fullmesh" just like the original code.

Thanks,
-Geliang

> +	if (fullmesh)
> +		return fill_remote_addresses_fullmesh(msk, local,
> addrs);
> +
> +	return fill_remote_addr(msk, local, addrs);
> +}
> +
>  static struct mptcp_pm_addr_entry *
>  __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
>  {
