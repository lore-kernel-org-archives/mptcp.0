Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A85313AA41
	for <mptcp@lists.linux.dev>; Thu, 31 Oct 2024 22:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730412900; cv=none; b=mEk+PDDKqOvaq69zM25RO6k3VdFxAb5zCZx4EZ5D4xml4D50gcWK3XfTBx2Uv40ZVw7wgiokDJc5jFXr3natNk+Pc0fP2LjtkW1wQLR55+4r5SUimjx7RUfpMaC3OBY/pA2Jopb1/I4OZEynJIElklNsKTGjMP8QhG/a5VmGjGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730412900; c=relaxed/simple;
	bh=wGarO3CWK21+7n5kojX7KMwUnLWTs5rd1BZ0NReH0OA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=H3DgR7xgLt75DrVl7AeHt5t22QhDJhd9zrgTcqDHC5ejs5xXqWhwnlzicZr6L7DvGOtN9MKl7wG3LOKFhppiuk1b1gxgJWkSI/tnguzQj4yOfdwBFyWlrD8iMcChYWWQPKocteEStfiWXF2FFkE6l8NjT8ulBqdeX1cwy3VhnGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQVOexFl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQVOexFl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86583C4CEC3;
	Thu, 31 Oct 2024 22:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730412898;
	bh=wGarO3CWK21+7n5kojX7KMwUnLWTs5rd1BZ0NReH0OA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=pQVOexFlVz2HAp6OkjtjTlBmlQ6JczDr5Xh/KVn6TiDdP5gP13YT3i97W3czMCc8x
	 ho8UD0PU8jsY7UrVFcLSUczp9zcNw6opAmySsyym4w13PqGTM6tjfGpoSJCVPNo200
	 zSOGoqZEnObWxSTWPhuNdnxHAWduikAA6MdOTr8vefiUX2s9t1fmIS/++pyS+vdGM0
	 mQTGhjMX/rACF31RA4B8noxfjCW1sRrS0NUDQq1vs1ntGqoKc2K1C03gdkHh4DP/XX
	 qtyM5YwANSF4nXkXLQmtdMIHeVkAW48QNeCDuEPpENhSpZkaqLEOLc1QrExIxADbPG
	 0kceFYnt0uNHA==
Date: Thu, 31 Oct 2024 15:14:54 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net v2 2/3] mptcp: pm: lockless list traversal
In-Reply-To: <3bc0cbec-e8d8-4981-8318-14976170d58e@kernel.org>
Message-ID: <2804a52d-85cb-88e6-174b-e39ce5f8785b@kernel.org>
References: <20241025-mptcp-pm-lookup_addr_rcu-v2-0-1478f6c4b205@kernel.org> <20241025-mptcp-pm-lookup_addr_rcu-v2-2-1478f6c4b205@kernel.org> <3bc0cbec-e8d8-4981-8318-14976170d58e@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-273870796-1730412898=:34826"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-273870796-1730412898=:34826
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 25 Oct 2024, Matthieu Baerts wrote:

> On 25/10/2024 11:32, Matthieu Baerts (NGI0) wrote:
>> In a few places -- to get an endpoint, dump all of them, and change
>> their flags -- the list is iterated while holding the pernet->lock, but
>> only to read the content of the list. In these cases, we can replace the
>> spin locks, by RCU read ones, and use the _rcu variants to iterate over
>> the entries list in a lockless way.
>>
>> To make it clear, the lookup helpers using the _rcu variant are renamed
>> with a _rcu suffix. The previous __lookup_addr() helper can then be
>> removed, but __lookup_addr_by_id() is still needed.
>>
>> While at it, the IDs bitmap is copied before iterating the list to dump
>> the different addresses, to avoid any consistencies.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Notes:
>>  - This is not a fix, a small improvement for -next.
>> ---
>>  net/mptcp/pm_netlink.c | 36 +++++++++++++++++++-----------------
>>  1 file changed, 19 insertions(+), 17 deletions(-)
>>
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index a93b9b7776b48781a883673fe5fd521a978487ff..f38e1ccd34e95cd88b179a8b50e6965731542871 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -520,12 +520,12 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
>>  }
>>
>>  static struct mptcp_pm_addr_entry *
>> -__lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
>> +__lookup_addr_by_id_rcu(struct pm_nl_pernet *pernet, unsigned int id)
>>  {
>>  	struct mptcp_pm_addr_entry *entry;
>>
>> -	list_for_each_entry(entry, &pernet->local_addr_list, list) {
>> -		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
>> +	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
>
> I didn't see the following in the RCU doc -- but it is quite big, so I
> probably missed it -- but I suppose we don't need to keep the two
> helpers here with and without the _rcu variant (__lookup_addr_by_id())
> if here we add an extra lockdep condition:
>
>  list_for_each_entry_rcu(entry, &pernet->local_addr_list, list,
>                          lockdep_is_held(&pernet->lock)) {
>
> WDYT?

I like this idea, would clean things up.

>
>> +		if (entry->addr.id == id)
>>  			return entry;
>>  	}
>>  	return NULL;
>
> (...)
>
>> @@ -1872,16 +1872,18 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
>>  	struct net *net = sock_net(msg->sk);
>>  	struct mptcp_pm_addr_entry *entry;
>>  	struct pm_nl_pernet *pernet;
>> +	unsigned long id_bitmap[4];
>
> Oops, I left my temp declaration, it should be the following line, which
> will result in the same thing anyway on x86_64, no need to re-run the
> tests → I can fix that when applying the patches, or in a future version:
>
>  DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
>

Thanks for catching that. I think it would be best to have a v3 with the 
lockdep_is_held() approach you mentioned above.


- Mat
--0-273870796-1730412898=:34826--
