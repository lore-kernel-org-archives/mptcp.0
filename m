Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B190E21A4BB
	for <mptcp@lists.linux.dev>; Fri, 25 Oct 2024 15:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729870009; cv=none; b=Z9zvZZ2IIuVesb6i2hxG330awL+N2jyXnPHAgwq6Fa0e5LrEYSPIHvkGzOW7mLis144b2Uxf9aC6hMQgkgXpagupg0BlnB/TFVL9OLlpj53hnLNnqstrEWUNHD21/F434IWIIjLf6pyLv7R109NQCI9MfRSCVxB7mRgOlxdGHCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729870009; c=relaxed/simple;
	bh=Tq4NRwP1OhYsfT6k2oMrKq8ECS66eXRRkxu5+shtEXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wvu7r1euibZCIDd33h6vpjdgt2OsOdujkKvC/zB5nnhGBCZT/cNUplNi5Vyt0pNFd5c6Wm+gkg31ML6satNnFdv/IH0pCeCOSxkBFZirFN7Gy3kaIJydxs5TNryVyTcCDFxrP9jnV332x3KpA6J15BdLpStZZTY8jV2hZyje4/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Amcqb9Y7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Amcqb9Y7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61ECEC4CEC3;
	Fri, 25 Oct 2024 15:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729870009;
	bh=Tq4NRwP1OhYsfT6k2oMrKq8ECS66eXRRkxu5+shtEXQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Amcqb9Y7BzPd2/HHzkYTlCzYheSVWWV3Qs9h1GkBLXN8f8hYgyy9rl+Qp5xThOTZb
	 j6bTUkcrSNBDPtmqGmDU31EbR1MeTdtckLmDzja8WwLD+itKMfD/xLMOXJaAn3jAs5
	 xnfbSnqsJ1hx3xtJYb0T2DvY1BJpBvL7oCEuF2gnaQak7qt58/vMuRQAvI8puofKOu
	 IbL+NsmwI6GfBng3xnZ+OJK9kP9nYqYRemRQS/aDkFsDdKezurEz5rRbGpRPO+lgu5
	 4mu5ZBHMDxISW25IAa6LCzjCWS56jo4u5Ov7imh6RwwX3cIc+kKINfBUCE9GghZVTP
	 aMZPtZXWdDepg==
Message-ID: <b303b3d0-1c0a-4c0a-8031-77023a2de005@kernel.org>
Date: Fri, 25 Oct 2024 17:26:46 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 2/3] mptcp: pm: lockless list traversal
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>
References: <20241025-mptcp-pm-lookup_addr_rcu-v2-0-1478f6c4b205@kernel.org>
 <20241025-mptcp-pm-lookup_addr_rcu-v2-2-1478f6c4b205@kernel.org>
 <48c030b9f5156dddec50e8727062b8350a53f8a0.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <48c030b9f5156dddec50e8727062b8350a53f8a0.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

Thank you for the review!

On 25/10/2024 16:25, Geliang Tang wrote:
> On Fri, 2024-10-25 at 11:32 +0200, Matthieu Baerts (NGI0) wrote:
>> In a few places -- to get an endpoint, dump all of them, and change
>> their flags -- the list is iterated while holding the pernet->lock,
>> but
>> only to read the content of the list. In these cases, we can replace
>> the
>> spin locks, by RCU read ones, and use the _rcu variants to iterate
>> over
>> the entries list in a lockless way.
>>
>> To make it clear, the lookup helpers using the _rcu variant are
>> renamed
>> with a _rcu suffix. The previous __lookup_addr() helper can then be
>> removed, but __lookup_addr_by_id() is still needed.
>>
>> While at it, the IDs bitmap is copied before iterating the list to
>> dump
>> the different addresses, to avoid any consistencies.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Notes:
>>  - This is not a fix, a small improvement for -next.
>> ---
>>  net/mptcp/pm_netlink.c | 36 +++++++++++++++++++-----------------
>>  1 file changed, 19 insertions(+), 17 deletions(-)
>>
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index
>> a93b9b7776b48781a883673fe5fd521a978487ff..f38e1ccd34e95cd88b179a8b50e
>> 6965731542871 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c

(...)

>> @@ -1872,16 +1872,18 @@ int mptcp_pm_nl_dump_addr(struct sk_buff
>> *msg,
>>  	struct net *net = sock_net(msg->sk);
>>  	struct mptcp_pm_addr_entry *entry;
>>  	struct pm_nl_pernet *pernet;
>> +	unsigned long id_bitmap[4];
>>  	int id = cb->args[0];
>>  	void *hdr;
>>  	int i;
>>  
>>  	pernet = pm_nl_get_pernet(net);
>> +	bitmap_copy(id_bitmap, pernet->id_bitmap,
>> MPTCP_PM_MAX_ADDR_ID + 1);
> 
> I think the id bitmap should only be copied when id is 0:
> 
> if (!id)
>   bitmap_copy(id_bitmap, pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
> 
> Since this mptcp_pm_nl_dump_addr() may be called repeatedly when the
> dump information is very long. We only copy it the first time it is
> called, and subsequent calls cannot copy it again. WDYT?

Sorry, I'm not sure to understand. Here, I did a local copy of
'id_bitmap' just to keep a certain consistency if the bitmap is changed
during the RCU read section below: not to have this bitmap being changed
during the for loop here below. Before, we had this protection because
pernet->lock was held.

Are you suggesting here to keep a copy in the cb, not a local one, to do
the copy only once? Are you sure it is worth it (and safe)?

>>  
>> -	spin_lock_bh(&pernet->lock);
>> +	rcu_read_lock();
>>  	for (i = id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
>> -		if (test_bit(i, pernet->id_bitmap)) {
>> -			entry = __lookup_addr_by_id(pernet, i);
>> +		if (test_bit(i, id_bitmap)) {
>> +			entry = __lookup_addr_by_id_rcu(pernet, i);
>>  			if (!entry)
>>  				break;
>>  
Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

