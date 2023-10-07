Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A09256A
	for <mptcp@lists.linux.dev>; Sat,  7 Oct 2023 21:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEHldLDK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CB1C433C8;
	Sat,  7 Oct 2023 21:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696712446;
	bh=yXJdwRhxsFK/h6jr497xM6SRY8/y4A+Wz75X8ZtWS5I=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=GEHldLDKF3TgpqjxKl0l1LAIw5hSklSeMfkQWwsbco5slBgcSggKiTCtYJD3FToqE
	 XbIunT1gXQI1kZ+GscWl39zVDc+f3XSY/xE4EpXVBDu8fVTZgOWOTbySvEms2PKUyk
	 PHkcySo0Sfyq6zuuh1f9kWjdmfWkN4hHA/9HgwOH5DnHiU71qfyv+iOJHO+RcR+SLn
	 O3Bfw6bE4Aazpsgatq5DHqDP/PVqUA8HD9/0HxJhTiga5ejlrX+gAOJ4lHKt5U4V4h
	 Bt/8nuR2HdioOLP4/d7OwYdH3IPnUKfsdTL7AsD94m2NQkgmQVQdPlf+yrIr7ikmzA
	 7WwdjEK2NqHNQ==
Message-ID: <2560578b-a908-4ede-b11c-369ef464e3cf@kernel.org>
Date: Sat, 7 Oct 2023 23:00:43 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 17/29] mptcp: add userspace_pm_get_entry
 helper
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1695631132.git.geliang.tang@suse.com>
 <120e561574e993cb50c610bab222fc0d76d1b147.1695631132.git.geliang.tang@suse.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 Fe7fduHbABmYz9cefQpO7wDE/Q==
Organization: Tessares
In-Reply-To: <120e561574e993cb50c610bab222fc0d76d1b147.1695631132.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

Thank you for looking at the issue 403!

On 25/09/2023 10:41, Geliang Tang wrote:
> This patch adds a new helper mptcp_userspace_pm_get_entry() to find out
> the address entry on the userspace_pm_local_addr_list through the given
> address. Use this helper in mptcp_userspace_pm_delete_local_addr() and
> mptcp_nl_cmd_sf_destroy().
Please always explain why this is needed, e.g. for this case:

  This will be reused in the following commits.

(also, please see my comment here below and on the next commit: maybe
you don't need this helper? → Except to clarify the code?)

> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/pm_userspace.c | 43 ++++++++++++++++++++++++++--------------
>  1 file changed, 28 insertions(+), 15 deletions(-)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 8d97cf475cac..30f4dd074a70 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -80,6 +80,19 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
>  	return ret;
>  }
>  
> +static struct mptcp_pm_addr_entry *mptcp_userspace_pm_get_entry(struct mptcp_sock *msk,
> +								struct mptcp_addr_info *addr)
> +{
> +	struct mptcp_pm_addr_entry *entry, *tmp;
> +
> +	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
> +		if (mptcp_addresses_equal(&entry->addr, addr, false))
> +			return entry;
> +	}
> +
> +	return NULL;
> +}
> +
>  /* If the subflow is closed from the other peer (not via a
>   * subflow destroy command then), we want to keep the entry
>   * not to assign the same ID to another address and to be
> @@ -88,21 +101,19 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
>  static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
>  						struct mptcp_pm_addr_entry *addr)
>  {
> -	struct mptcp_pm_addr_entry *entry, *tmp;
> +	struct mptcp_pm_addr_entry *entry;
>  
> -	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
> -		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
> -			/* TODO: a refcount is needed because the entry can
> -			 * be used multiple times (e.g. fullmesh mode).
> -			 */
> -			list_del_rcu(&entry->list);
> -			kfree(entry);
> -			msk->pm.local_addr_used--;
> -			return 0;
> -		}
> -	}
> +	entry = mptcp_userspace_pm_get_entry(msk, &addr->addr);
> +	if (!entry)
> +		return -EINVAL;
>  
> -	return -EINVAL;
> +	/* TODO: a refcount is needed because the entry can
> +	 * be used multiple times (e.g. fullmesh mode).
> +	 */
> +	list_del_rcu(&entry->list);
> +	kfree(entry);
> +	msk->pm.local_addr_used--;
> +	return 0;
>  }
>  
>  int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
> @@ -495,10 +506,12 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
>  	ssk = mptcp_nl_find_ssk(msk, &addr_l, &addr_r);
>  	if (ssk) {
>  		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> -		struct mptcp_pm_addr_entry entry = { .addr = addr_l };
> +		struct mptcp_pm_addr_entry *entry;
>  
>  		spin_lock_bh(&msk->pm.lock);
> -		mptcp_userspace_pm_delete_local_addr(msk, &entry);
> +		entry = mptcp_userspace_pm_get_entry(msk, &addr_l);

Why are you calling this function here? ... (see below)

> +		if (entry)
> +			mptcp_userspace_pm_delete_local_addr(msk, entry);

Because this function will also call mptcp_userspace_pm_get_entry().

>  		spin_unlock_bh(&msk->pm.lock);
>  		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
>  		mptcp_close_ssk(sk, ssk, subflow);

Cheers,
Matt
--
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
