Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11EF306B3D
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 10:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758277855; cv=none; b=qSZBxyXBzDAZo62zIXgPmla5GdA8lbyNSquWRBaPcaEkrtEgdWexJ93xTQY9MscuPoF6Dm04PRDitv1JrAy4ql87dB9mWcyTLTt7UKPzx5m0z++mvIDm1Pcivv4i8j8ovKVLUqfH6TjFV9iNMNs2iuRBxS5E57Xuyzjg3lv6A4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758277855; c=relaxed/simple;
	bh=jRBC/rEw1vfKfJkCfSLqVzKLFZcDD3ZqUsYp5whpKRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ui4ewdiybBHIlNnV0eUxj5ELk3VdTLD7J09Z+0DhdHG86VFhoehMcPN/b2Z0CnC6wmrdt3X0WI6bADELhYZBNVRdydkrstUfMB8nVJbDetIlUBmAVylJx3E0L/mRekUKOLu+zsiT2AbPutqpR2SJOE/n01ir/cfATjZRiuVdDNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akTxAQAP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akTxAQAP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5B7C4CEF1;
	Fri, 19 Sep 2025 10:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758277855;
	bh=jRBC/rEw1vfKfJkCfSLqVzKLFZcDD3ZqUsYp5whpKRI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=akTxAQAPxXMIFJF+zxcA6r32hQZIi//CqA9GB0hbtRp9Ek4QKiUWCt5Qu2fVVcXkp
	 94oxqCkNdrKH/9gujXlH791jCLEb6iA8Ukt9cMj9LNi4K49u8ZPOO6tjNvJH8x0qay
	 9OmDsWT+KpqBjRWM3zxfwP4QIN/U95ZyLT/UfZl2b8HZEsRsqlOYsj2uFqBTqUcuDM
	 y9q6Pn2TfIb91lTmf3f00vA1dTJ+WOOBoDE1pwgL1716Uti5g4XIZVLkeqqX9o+MYt
	 4L6qwQ2EndFTzWCwE2Na3gOgrFlR8u2XMaOvWJsoek7FpyR3wsdPEestUk5I7QlYVL
	 wY9GYtzHssFyg==
Message-ID: <af038759-e7cb-4cba-a23f-e7cb06a07dcb@kernel.org>
Date: Fri, 19 Sep 2025 12:30:52 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 01/10] Squash to "mptcp: pm: in-kernel:
 usable client side with C-flag"
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, MPTCP Upstream <mptcp@lists.linux.dev>
References: <20250919-pm-kern-endp-add_addr-v2-0-1f8f04f01914@kernel.org>
 <20250919-pm-kern-endp-add_addr-v2-1-1f8f04f01914@kernel.org>
 <c702e2fc35fdbea872ac01eb49c9f7f7be0262a9.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <c702e2fc35fdbea872ac01eb49c9f7f7be0262a9.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 19/09/2025 12:11, Geliang Tang wrote:
> Hi Matt,
> 
> Thanks for this set. It looks good to me overall. Only one comment
> below.
> 
> On Fri, 2025-09-19 at 11:08 +0200, Matthieu Baerts (NGI0) wrote:
>> The id_avail_bitmap is only used when either the 'subflow' or
>> 'signal'
>> flag is used, but not with 'fullmesh' only. Here, it is replacing the
>> 'subflow' action, so check if this flag is set.
>>
>> Also, add the check for the max subflows upfront, so we avoid
>> scheduling
>> the worker with MPTCP_PM_ADD_ADDR_RECEIVED if it is not needed.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> v2: modify protocol.h here too (Geliang)
>> ---
>>  net/mptcp/pm_kernel.c | 3 ++-
>>  net/mptcp/protocol.h  | 3 ++-
>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
>> index
>> d7cd89fa6a11a1ea7703edbfbdf2bbe86a6a3054..277f81f38134d07918143331746
>> a50bc316d81ca 100644
>> --- a/net/mptcp/pm_kernel.c
>> +++ b/net/mptcp/pm_kernel.c
>> @@ -411,7 +411,8 @@ static unsigned int
>> fill_local_addresses_vec(struct mptcp_sock *msk,
>>  			locals[i].flags = entry->flags;
>>  			locals[i].ifindex = entry->ifindex;
>>  
>> -			if (c_flag_case)
>> +			if (c_flag_case &&
>> +			    (entry->flags &
>> MPTCP_PM_ADDR_FLAG_SUBFLOW))
>>  				__clear_bit(locals[i].addr.id,
>>  					    msk-
>>> pm.id_avail_bitmap);
>>  
>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index
>> dd0662defd41c84474e44c559c571e3594b85d9e..0d6dae37c9daf4ec8990b9a8703
>> 6aa393add585c 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -1200,7 +1200,8 @@ static inline bool
>> mptcp_pm_add_addr_c_flag_case(struct mptcp_sock *msk)
>>  {
>>  	return READ_ONCE(msk->pm.remote_deny_join_id0) &&
>>  	       msk->pm.local_addr_used == 0 &&
>> -	       mptcp_pm_get_add_addr_accept_max(msk) == 0;
>> +	       mptcp_pm_get_add_addr_accept_max(msk) == 0 &&
>> +	       msk->pm.subflows < mptcp_pm_get_subflows_max(msk);
> 
> If this line is added here, no need to change it again in
> fill_local_addresses_vec() in "mptcp: pm: in-kernel: usable client side
> with C-flag", right? I mean we can drop "msk->pm.subflows <
> subflows_max" in this while statement:
> 
>   while (msk->pm.local_addr_used < local_addr_max &&
>          msk->pm.subflows < subflows_max) {
> 
> No need to send a v3, please update it when merging it if you agree.

No, we still need it here, because we might create more than one subflow.

We could move it to the end of the loop, but I would rather prefer not
to do that in the patch for 'net'. Probably better to keep this patch
simple, and similar to what is done in fill_local_addresses_vec() for
the fullmesh case.

In the refactoring, we can apply the same modifications for both the
fullmesh case and the one here: using a break at the end of the loop. WDYT?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

