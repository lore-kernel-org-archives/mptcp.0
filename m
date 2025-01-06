Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CA41D61B9
	for <mptcp@lists.linux.dev>; Mon,  6 Jan 2025 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736153724; cv=none; b=PCuf4X8OmSdB3YJtlilCr56CKYQURalLtZsRj2lAx/LZ8W+4QRdVpuxF8hVALniudGFwz+UsLhMudRjh/R7rIoDeU8uSo3XXhrWyBea6Iy3uGEgfcX6M8OUJpuHyhMKkyM4mSv+NK+JtfteLsTUg9C48nvW1mzPOPwTMcK0D7X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736153724; c=relaxed/simple;
	bh=Y3CEI+Kh6YlemLly8LH1gEEgYJBuh5euLrho1Hr2FUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ol31Tq/tYeUM1muwDipOhIW4lkX+9fHMq/ljgULbqJoqnHXw0hfKDvEXfmiC7L6HIP04+WaazWurSBvWWHZneD3T7jlmoa7XQLH8k1rqhszOSVB4WhumTgn9ECuW+1bjznUoS+apEFXijm0san55ogjBuStICot79pi0J0dubH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9PVJZhc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9PVJZhc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D5DC4CEE1;
	Mon,  6 Jan 2025 08:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736153724;
	bh=Y3CEI+Kh6YlemLly8LH1gEEgYJBuh5euLrho1Hr2FUg=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=X9PVJZhceA5Wxuulu5FVl/zWA6QUX2j95GIRiyqYa4tb+zmJGKr7nTcwo8O/PIF84
	 9KT6sKBFxuk2kb0VXmYqGUTHzD5LY+doWJnE4eIwwPxXdpIPNoFaVFbtk/MNFvK5a/
	 vB4hRt1E0bgkAIx4qsFFgPP81VnqKqJ13XPF74QB+4d1eBzgeJ0LwWxoIfSsjTBzvm
	 1BwlSnaXhpBj+XVkIw1i0StXFE/vwphWDREqy9E9bVzA3YewvHBKYq2fvLQftfL/2O
	 yQIObmU81WNx7xKIWGaxQXI1ZnRoWx/evpgK+oL5NH1NUFe+8ZvKwiAqpfjmREhVQH
	 KnLWFSY5OiIJg==
Message-ID: <21387f9d-6c88-414c-9443-29263a03573d@kernel.org>
Date: Mon, 6 Jan 2025 09:55:22 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v6 2/7] mptcp: pm: more precise error messages
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <20241230-genl_req_attr_check-v6-0-3ec9103559e7@kernel.org>
 <20241230-genl_req_attr_check-v6-2-3ec9103559e7@kernel.org>
 <0152caf3be99da2fe96a6d5e8a672b3ee18f19c7.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <0152caf3be99da2fe96a6d5e8a672b3ee18f19c7.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 06/01/2025 09:38, Geliang Tang wrote:
> On Mon, 2024-12-30 at 14:24 +0100, Matthieu Baerts (NGI0) wrote:
>> Some errors reported by the userspace PM were vague: "this or that is
>> invalid".
>>
>> It is easier for the userspace to know which part is wrong, instead
>> of
>> having to guess that.
>>
>> By splitting some error messages, NL_SET_ERR_MSG_ATTR() can be used
>> instead of GENL_SET_ERR_MSG() in order to give an additional hint to
>> the
>> userspace developers about which attribute is wrong.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  net/mptcp/pm_userspace.c | 34 ++++++++++++++++++++++++++--------
>>  1 file changed, 26 insertions(+), 8 deletions(-)
>>
>> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
>> index
>> 72d4861e497eef5a516fc1c3ec1659807ffedd53..9c0bec588c498e0aa78acf4018d
>> b509abe90cad2 100644
>> --- a/net/mptcp/pm_userspace.c
>> +++ b/net/mptcp/pm_userspace.c

(...)

>> @@ -592,9 +603,16 @@ int mptcp_userspace_pm_set_flags(struct sk_buff
>> *skb, struct genl_info *info)
>>  			goto set_flags_err;
>>  	}
>>  
>> -	if (loc.addr.family == AF_UNSPEC ||
>> -	    rem.addr.family == AF_UNSPEC) {
>> -		GENL_SET_ERR_MSG(info, "invalid address families");
>> +	if (loc.addr.family == AF_UNSPEC) {
>> +		NL_SET_ERR_MSG_ATTR(info->extack, attr,
>> +				    "invalid local address family");
>> +		ret = -EINVAL;
>> +		goto set_flags_err;
>> +	}
>> +
>> +	if (rem.addr.family == AF_UNSPEC) {
> 
> I moved this check into "if (attr_rem) {" block in v7.

If you do that, you are changing the behaviour: this attribute is then
no longer mandatory with the userspace PM. I don't think we should do
that, or at least, not as part of a refactoring as you did.

If we want to change the behaviour, we need an explicit patch for that.
See my patch description from patch v6 4/7, and also the
GENL_REQ_ATTR_CHECK() check added in patch v6 7/7.

> 
>> +		NL_SET_ERR_MSG_ATTR(info->extack, attr_rem,
>> +				    "invalid remote address
>> family");
>>  		ret = -EINVAL;
>>  		goto set_flags_err;
>>  	}
>>
> 

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

