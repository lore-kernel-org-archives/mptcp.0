Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72C51C6882
	for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 18:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730312505; cv=none; b=Y9Vycr8zM4ACeJFaRgz4R2djjZyn9kEFU3b1hkJlZcwQcmpAiKAg6LK8xYg+uTV4eD4/2lHSIW8sr5GIfAhxaXjNOiwblaPOJhSRoHbzOYEzRm8PgqhzMFQ8Lb4X1qT+9y4Bk7LoTIKYNFWn4mu/IlIVToSlfOREkNoqUX1/5ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730312505; c=relaxed/simple;
	bh=tysjKI1lM60HXbATBbrmFFxv960HxRmsHxBqpjVRY0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kSoACj72QD1Fy4KCkuo4LTFr057Tx7qMMy+EUP3cPXMUHkttJ5OtPp+eJvsEAMAKVqFkuknrKAHdMREhxOw+apadaMFiQR9n/aDOLsKEpBdh+nBWpY0PVngbMD4Ewg6NT/5KPjPOEMHoz62zCL1js8mOPMPfKgFTtAyxqQln9SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ta5WZ7sg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ta5WZ7sg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86105C4CECE;
	Wed, 30 Oct 2024 18:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730312505;
	bh=tysjKI1lM60HXbATBbrmFFxv960HxRmsHxBqpjVRY0M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ta5WZ7sgZXQPWdWU7DXHToZz7OtroqHYPfyt8zFirrUanhmNAQd3sfLlPpGVbDriF
	 6omQU5MNqW1RaAAcGp1CDDHpdL7P3wofBhhSe+zjxmTAnvEux55fbkLoOubyWEPTb0
	 JTRM7IKyOSDN4AHfcU54pNQ2hKmEMvE+GP9Tlj2D4kLrNvyndbh8GYz6vDjCu2id8T
	 hZBjlMZQ7EDbknEbX58hhlYoNPgYFYJ+qfXmOZBJgRD5aOwJiexYvoOu5+yeH79gCE
	 CAdBkzBVFbvjS5HXoLWvwoNFQ5XVtZC1MYmuS7gIVI+mC+p9GiBtkWg7m+jL0R8FGt
	 Bqh4znlJNQ/BA==
Message-ID: <af13381b-4bc8-4735-8c0d-abca4ae6c48e@kernel.org>
Date: Wed, 30 Oct 2024 19:21:42 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 05/36] mptcp: add lookup_addr for userspace
 pm
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
 <6d30431fd64e8c17d163ab5656838e1c3be78b97.1729588019.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <6d30431fd64e8c17d163ab5656838e1c3be78b97.1729588019.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 22/10/2024 11:14, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Like __lookup_addr() helper in pm_netlink.c, a new helper
> mptcp_userspace_pm_lookup_addr() is also defined in pm_userspace.c.
> It looks up the corresponding mptcp_pm_addr_entry address in
> userspace_pm_local_addr_list through the passed "addr" parameter
> and returns it.
> 
> This helper can be used in mptcp_userspace_pm_delete_local_addr(),
> mptcp_userspace_pm_get_local_id() and mptcp_userspace_pm_is_backup()
> to simplify the code.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm_userspace.c | 56 +++++++++++++++++++++-------------------
>  1 file changed, 29 insertions(+), 27 deletions(-)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 3fb5713cd988..ce0f7131c701 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -26,6 +26,18 @@ void mptcp_free_local_addr_list(struct mptcp_sock *msk)
>  	}
>  }
>  
> +static struct mptcp_pm_addr_entry *
> +mptcp_userspace_pm_lookup_addr(struct mptcp_sock *msk, const struct mptcp_addr_info *addr)

When possible, can you try to limit to 80 chars per line?

See: https://github.com/linux-netdev/nipa/pull/41

Using more than 80 is allowed, but it should be restricted to cases
where using less than 80 chars affects the readability, e.g. not to
break 'entry->flags & MY_SPECIFIC_FLAG' in two lines, etc. The idea is
not to abuse of that.

Here for example, it is easy to go to the new line after the ','.

> +{
> +	struct mptcp_pm_addr_entry *entry, *tmp;
> +
> +	mptcp_for_each_address_safe(msk, entry, tmp) {

Why do you need the '_safe' alternative here? You only return an entry
from the list, and you stop: no need to continue after having modified
the list here as far as I can see, no?

Also, something very important: here you are presenting the modification
as a simple refactoring, but it does change the behaviour: the '_safe'
version is used everywhere, which was not the case before. When you do
something like that, please mention it in the commit message! Without
that, a reviewer might not notice it "OK, just a refactoring", and
developers might wonder later why this was done. I then recommend to
always add either something like:
- "No behaviour change intended here."
- or "Please note that now <something different is done> for <these
cases>, but that's OK to do so <because ...>."

> +		if (mptcp_addresses_equal(&entry->addr, addr, false))
> +			return entry;
> +	}
> +	return NULL;
> +}
> +
>  static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
>  						    struct mptcp_pm_addr_entry *entry,
>  						    bool needs_id)
> @@ -90,22 +102,20 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
>  static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
>  						struct mptcp_pm_addr_entry *addr)
>  {
> -	struct mptcp_pm_addr_entry *entry, *tmp;
>  	struct sock *sk = (struct sock *)msk;
> +	struct mptcp_pm_addr_entry *entry;
>  
> -	mptcp_for_each_address_safe(msk, entry, tmp) {
> -		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
> -			/* TODO: a refcount is needed because the entry can
> -			 * be used multiple times (e.g. fullmesh mode).
> -			 */
> -			list_del_rcu(&entry->list);
> -			sock_kfree_s(sk, entry, sizeof(*entry));
> -			msk->pm.local_addr_used--;
> -			return 0;
> -		}
> -	}
> -
> -	return -EINVAL;
> +	entry = mptcp_userspace_pm_lookup_addr(msk, &addr->addr);
> +	if (!entry)
> +		return -EINVAL;
> +
> +	/* TODO: a refcount is needed because the entry can
> +	 * be used multiple times (e.g. fullmesh mode).
> +	 */

(Not related to this commit: I wonder if the TODO still makes sense. We
had some discussions with Mat, and I think the conclusion was that it
was OK, but I don't remember why)

> +	list_del_rcu(&entry->list);
> +	sock_kfree_s(sk, entry, sizeof(*entry));
> +	msk->pm.local_addr_used--;
> +	return 0;
>  }
>  
>  static struct mptcp_pm_addr_entry *
> @@ -123,17 +133,12 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
>  int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
>  				    struct mptcp_addr_info *skc)
>  {
> -	struct mptcp_pm_addr_entry *entry = NULL, *e, new_entry;
> +	struct mptcp_pm_addr_entry *entry = NULL, new_entry;
>  	__be16 msk_sport =  ((struct inet_sock *)
>  			     inet_sk((struct sock *)msk))->inet_sport;
>  
>  	spin_lock_bh(&msk->pm.lock);
> -	mptcp_for_each_address(msk, e) {
> -		if (mptcp_addresses_equal(&e->addr, skc, false)) {
> -			entry = e;
> -			break;
> -		}
> -	}
> +	entry = mptcp_userspace_pm_lookup_addr(msk, skc);
>  	spin_unlock_bh(&msk->pm.lock);
>  	if (entry)
>  		return entry->addr.id;
> @@ -156,12 +161,9 @@ bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
>  	bool backup = false;
>  
>  	spin_lock_bh(&msk->pm.lock);
> -	mptcp_for_each_address(msk, entry) {
> -		if (mptcp_addresses_equal(&entry->addr, skc, false)) {
> -			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
> -			break;
> -		}
> -	}
> +	entry = mptcp_userspace_pm_lookup_addr(msk, skc);
> +	if (entry)
> +		backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
>  	spin_unlock_bh(&msk->pm.lock);
>  
>  	return backup;

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

