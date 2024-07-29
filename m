Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA841428FE
	for <mptcp@lists.linux.dev>; Mon, 29 Jul 2024 09:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722245359; cv=none; b=n20QdToG6OBYlFqiY7A9ML2EwtwQI+lnRjMWZB3Pzsvp/op5NuqOj/VuzMGAMD2ZMuU1f+OXPcaq+6TxXBommJdLOtkHSUO0NeC/iUNZNfP0CMiOb5fRGlEnsTl1MbHRuTJknosOS0YpHIZDLuL2lwDYVS4O2RIVBSUd8psAgbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722245359; c=relaxed/simple;
	bh=dnv/ZR2she5vOmR+dpf1GZO6ww8bgPMVxsX0R1G41tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ExHyHoo88RqZ8Lfd1HYVBkWiXeO7Q/vtvyqZjEiLk8YCZo66yUwSKCfhe9fQVDoP6NMsfyT5v9li0XNSs+vrWUs/biANtLmetG0cOewguTO7NoJbKo3RYuXl9Ph0gPLKE8DK48vynSsI2nveRVHJwwSymKsmmCgcfJD0lt/kSL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcUmhIjE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcUmhIjE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2F8C32786;
	Mon, 29 Jul 2024 09:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722245359;
	bh=dnv/ZR2she5vOmR+dpf1GZO6ww8bgPMVxsX0R1G41tg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hcUmhIjEeMWPZ29GBD7xw5kykaOfI9Sb+C4ZQYQEKX7HNt606WMLilUoMzZhqBnb7
	 qM+KdOHGnTohM2ar7+Y/PP4ra2kOyaf/RDK24bgoYY4Y+N4EuIgq4Xv+uWeWZj0yKh
	 gc5agMzM42ADS8h9o/BrhmdXd4ZT6bjK4umeh/1A5zw0GVLuWpY/e+xuYZL8AtvfXl
	 7AToFFhxiF/Rnr7N20ifshyi3PH3f/bq3+QBVI5DOS0a49L1DZyfMLhnZ70z/yyIak
	 r6hgq+PoBC3u38gz58ewqBp+NZMGoPpeJ5HT2twaZXLnkOUAu8Dao2ecQFqxiniuzS
	 rbnGUCy9OzV+g==
Message-ID: <09f0fffc-8101-4ffa-869c-a7f63d12c181@kernel.org>
Date: Mon, 29 Jul 2024 11:29:16 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v5 07/13] mptcp: pm: only in-kernel cannot have
 entries with ID 0
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>
References: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
 <20240726-mptcp-pm-avail-v5-7-fb1117ddeef6@kernel.org>
 <bc65dcccc3569ba5de9930ae47e634912cf3efbe.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <bc65dcccc3569ba5de9930ae47e634912cf3efbe.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 29/07/2024 03:12, Geliang Tang wrote:
> On Fri, 2024-07-26 at 16:28 +0200, Matthieu Baerts (NGI0) wrote:
>> The ID 0 is specific per MPTCP connections. The per netns entries
>> cannot
>> have this special ID 0 then.
>>
>> But that's different for the userspace PM where the entries are per
>> connection, they can then use this special ID 0.
>>
>> Fixes: f40be0db0b76 ("mptcp: unify pm get_flags_and_ifindex_by_id")
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  net/mptcp/pm.c         | 3 ---
>>  net/mptcp/pm_netlink.c | 4 ++++
>>  2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>> index 925123e99889..3e6e0f5510bb 100644
>> --- a/net/mptcp/pm.c
>> +++ b/net/mptcp/pm.c
>> @@ -434,9 +434,6 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct
>> mptcp_sock *msk, unsigned int id
>>  	*flags = 0;
>>  	*ifindex = 0;
>>  
>> -	if (!id)
>> -		return 0;
>> -
>>  	if (mptcp_pm_is_userspace(msk))
>>  		return
>> mptcp_userspace_pm_get_flags_and_ifindex_by_id(msk, id, flags,
>> ifindex);
>>  	return mptcp_pm_nl_get_flags_and_ifindex_by_id(msk, id,
>> flags, ifindex);
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index 3cb02fe359c0..6a1495fec7ae 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -1395,6 +1395,10 @@ int
>> mptcp_pm_nl_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
>> unsigned int
>>  	struct sock *sk = (struct sock *)msk;
>>  	struct net *net = sock_net(sk);
>>  
>> +	/* No entries with ID 0 */
>> +	if (id == 0)
>> +		return 0;
>> +
> 
> I think this check needs to be added in
> mptcp_userspace_pm_get_flags_and_ifindex_by_id() too.

We don't need it for the userspace PM, because the endpoints are managed
per MPTCP connection, they can have an ID 0. On the other hand, the
in-kernel PM manages the endpoints globally, they cannot have the ID 0
because it is reserved to the address used by the initial subflow, which
can be different per MPTCP connection.

Please see the commit message for more details.

> 
>>  	rcu_read_lock();
>>  	entry = __lookup_addr_by_id(pm_nl_get_pernet(net), id);
>>  	if (entry) {
>>
> 

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

