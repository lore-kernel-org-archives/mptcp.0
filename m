Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D205220D51B
	for <mptcp@lists.linux.dev>; Fri, 25 Oct 2024 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869450; cv=none; b=NOc/gMk5xgXGzA4KJG+BK3fGBT52kojlPzEYSQbJTP5cQHP+iCBZ21ow1i0hEB/Rf5+kvjwFIZQD28M5nyg/idiYB9PaEyBSAVanimHDpTnxLu0BtP1N55tApnRb3QahwThM94P4mByZ3w9/nEbQXFsFAlykMGbF+RGapCfOeCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869450; c=relaxed/simple;
	bh=urfwP4uGmdRBzVymv5IfBHNWNqc7pqQaJUTDp03a5tM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lhIJlhTboX9tLrmrS98c/+4Z6qwXu4HUYABbwKijW5TZyL3/kixe6a3+9uuzdJnYn934ibzmPsBTyqvg4C4PVYmeVMUqy0fm3onzlZXMCwT+384BuQgZF1dLNxmXePwoJGUORoQJQWgGsWvbslWg0VpmyEpq52JjKvT4Qr7x/h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpyqBHiR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpyqBHiR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7622C4CEC3;
	Fri, 25 Oct 2024 15:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729869450;
	bh=urfwP4uGmdRBzVymv5IfBHNWNqc7pqQaJUTDp03a5tM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QpyqBHiRreMPPw6gNh6ec5s7n+TjffglpAOlx40rQSeRC98HGG6IY+4frB1AHkMKw
	 Y3n+MtvlBC3zqPiX7ZPRRzwK5dB+frpxLZtLkgFY0Ur3nfS7DLzUPlUCty+3uWrLt5
	 J36OWV0cxTAXSnuBzxL6+BnWiykUIiypXwiBKp3NsbUBH2DKXjMagvc0zqGo5POEzx
	 KK0LmoB+Z6MKFovsBNgrYVxwic7WYqo4ONEmKDjLpx2Y/rw2I0aAy61hZdiFPd7pIa
	 i5YiXUuga/6XL/P0hbBSztCFIqmSPv+cPbC7+PFYMtR9GDtLuXIPEV8H9uH4Za/k9r
	 XLXQmfAGBJr/w==
Message-ID: <3bc0cbec-e8d8-4981-8318-14976170d58e@kernel.org>
Date: Fri, 25 Oct 2024 17:17:27 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 2/3] mptcp: pm: lockless list traversal
Content-Language: en-GB
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>
References: <20241025-mptcp-pm-lookup_addr_rcu-v2-0-1478f6c4b205@kernel.org>
 <20241025-mptcp-pm-lookup_addr_rcu-v2-2-1478f6c4b205@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20241025-mptcp-pm-lookup_addr_rcu-v2-2-1478f6c4b205@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/10/2024 11:32, Matthieu Baerts (NGI0) wrote:
> In a few places -- to get an endpoint, dump all of them, and change
> their flags -- the list is iterated while holding the pernet->lock, but
> only to read the content of the list. In these cases, we can replace the
> spin locks, by RCU read ones, and use the _rcu variants to iterate over
> the entries list in a lockless way.
> 
> To make it clear, the lookup helpers using the _rcu variant are renamed
> with a _rcu suffix. The previous __lookup_addr() helper can then be
> removed, but __lookup_addr_by_id() is still needed.
> 
> While at it, the IDs bitmap is copied before iterating the list to dump
> the different addresses, to avoid any consistencies.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
>  - This is not a fix, a small improvement for -next.
> ---
>  net/mptcp/pm_netlink.c | 36 +++++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index a93b9b7776b48781a883673fe5fd521a978487ff..f38e1ccd34e95cd88b179a8b50e6965731542871 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -520,12 +520,12 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
>  }
>  
>  static struct mptcp_pm_addr_entry *
> -__lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
> +__lookup_addr_by_id_rcu(struct pm_nl_pernet *pernet, unsigned int id)
>  {
>  	struct mptcp_pm_addr_entry *entry;
>  
> -	list_for_each_entry(entry, &pernet->local_addr_list, list) {
> -		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
> +	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {

I didn't see the following in the RCU doc -- but it is quite big, so I
probably missed it -- but I suppose we don't need to keep the two
helpers here with and without the _rcu variant (__lookup_addr_by_id())
if here we add an extra lockdep condition:

  list_for_each_entry_rcu(entry, &pernet->local_addr_list, list,
                          lockdep_is_held(&pernet->lock)) {

WDYT?

> +		if (entry->addr.id == id)
>  			return entry;
>  	}
>  	return NULL;

(...)

> @@ -1872,16 +1872,18 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
>  	struct net *net = sock_net(msg->sk);
>  	struct mptcp_pm_addr_entry *entry;
>  	struct pm_nl_pernet *pernet;
> +	unsigned long id_bitmap[4];

Oops, I left my temp declaration, it should be the following line, which
will result in the same thing anyway on x86_64, no need to re-run the
tests → I can fix that when applying the patches, or in a future version:

  DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

