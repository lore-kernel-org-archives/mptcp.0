Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC93C4A24
	for <mptcp@lists.linux.dev>; Wed, 23 Oct 2024 00:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729643477; cv=none; b=DFXLV13WnkvESwHuHc/yLsJATFrXkkfKZ5dkC7RTOPxpJSjgxJSUN6ugT+aUiWUe2+Yu2AO/oP89wPOhzPsVApMZSby58g6VJ/ukQ2T9mW+2qxzVmPaQnL7hBgTpSEF3w/Ebj6/NjV17TiWS7hS3h5QQVYcwC38VWrYPA9/zVYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729643477; c=relaxed/simple;
	bh=cG90TB4Hykf/8jJ3gzYLolUuXuVv4xdP8dVLirrup4A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XBmbvvyvTDEoSbUqFm0YP6hFlq/0k+NX+HAoX8GscGXPRdDFX20InO8kRZL6XspSb/5AiZVgdW1+8gCanF26EQqzGLgPpsVxOuN4KmyBrF9G9zNYwUbaqEaAA4zXcJ1KmNUWnZ126BXYonkBJBPZEJ2lVhEuIZg7l/FdEaS5G4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTmPjdPv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTmPjdPv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C12C4CEC3;
	Wed, 23 Oct 2024 00:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729643476;
	bh=cG90TB4Hykf/8jJ3gzYLolUuXuVv4xdP8dVLirrup4A=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=hTmPjdPv8Ma6pBSoAoX3sS8G6rMdnZcjryLP7g6SDrgNcQOYQugMX5u9Zi6bTx2Zq
	 YWwgoURtMVVUGGrW1u4rWuM+3x/0DQng6kEh4Z9K4vxTa9hn9u9USQkA7DLNERfQrN
	 PCODZhhVEyMz0pMa3AD4SW2dgyn4YjSILB5kRTVSFWITMuk6ysnMoNfrEgAOiEIJk5
	 OOaG/7Q6XAXL5axCXmdAHX0e3RDh19YjfpnfR6VjThpwHjqA16yanPis+OcxxOCnsp
	 CReDWaXGVv80e82C3oEaoOiAtnU122HODdvjnmwPaFE8IiG3mneyL4Qq6cOHUJUem/
	 W9OfwSfBExwUA==
Date: Tue, 22 Oct 2024 17:31:15 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: pm: use _rcu variant under
 rcu_read_lock
In-Reply-To: <20241022-mptcp-pm-lookup_addr_rcu-v1-1-19d45f26c872@kernel.org>
Message-ID: <58a788f7-1703-ac02-e307-08f26efc0e9c@kernel.org>
References: <20241022-mptcp-pm-lookup_addr_rcu-v1-1-19d45f26c872@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 22 Oct 2024, Matthieu Baerts (NGI0) wrote:

> In mptcp_pm_create_subflow_or_signal_addr(), rcu_read_(un)lock() are
> used as expected to iterate over the list of local addresses, but
> list_for_each_entry() was used instead of list_for_each_entry_rcu() in
> __lookup_addr() (and lookup_id_by_addr() before). It is important to use
> this variant which adds the required READ_ONCE() (and diagnostic checks
> if enabled).
>
> Because __lookup_addr() is also used in mptcp_pm_nl_set_flags() where it
> is called under the pernet->lock because the returned entry might be
> modified, the _rcu variant cannot be used in all cases. It is then
> required to create a new helper. Note that this new helper can be reused
> later to reduce some duplicated code elsewhere in this file.

Hi Matthieu -

I'm not sure this is the case, if you add rcu read lock/unlocks to 
mptcp_pm_nl_set_flags() then the _rcu variant could be used there (and 
then only one __lookup_addr() would be needed).

- Mat

>
> Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> net/mptcp/pm_netlink.c | 14 +++++++++++++-
> 1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 618289aac0ab7f558d55d8b2ebb00dc62fc72f88..fe84a11cfbab1afa34ee3586ecc29658931e9a4c 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -531,6 +531,18 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
> 	return NULL;
> }
>
> +static struct mptcp_pm_addr_entry *
> +__lookup_addr_rcu(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
> +{
> +	struct mptcp_pm_addr_entry *entry;
> +
> +	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
> +		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
> +			return entry;
> +	}
> +	return NULL;
> +}
> +
> static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
> {
> 	struct sock *sk = (struct sock *)msk;
> @@ -556,7 +568,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
>
> 		mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
> 		rcu_read_lock();
> -		entry = __lookup_addr(pernet, &mpc_addr);
> +		entry = __lookup_addr_rcu(pernet, &mpc_addr);
> 		if (entry) {
> 			__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
> 			msk->mpc_endpoint_id = entry->addr.id;
>
> ---
> base-commit: 66bee427d4db76bd1afbf0184a2fd1f238a4ee27
> change-id: 20241022-mptcp-pm-lookup_addr_rcu-01833ea95155
>
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
