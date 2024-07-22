Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA75134B6
	for <mptcp@lists.linux.dev>; Mon, 22 Jul 2024 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721663761; cv=none; b=uWePF5fLUOvCGQ3k53OvOaWm4AH2IAd05it/EoeCV6kJvAQAFLxmHNMbixQDYwWVsqZzIKvu1e59TN4EfZyHeR98NjAj4yfiwiqbltDcyCQqHgEukyNzVBHSbkdS1PiqRgHDqfRKTM9UhVSfgKScL8xO7YCsgg0K6ZFb5D53lao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721663761; c=relaxed/simple;
	bh=X1Vs1TjSo1mfyiyKma36A8jJLx+1DJIAtt7W61MKNrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pe+UVqnRgkonEZJP3g/cenZCaB4RyUDmuXrLBO+RHNTAtBrq2NhsoNNU35qzWKBEAXkgZN4P+ir2IvvVJnTeko+tzCJWs/KJVGQ7gRWfqNPSv5avYVPy7z7wrWSpdLyzVn8jKD8NiAoGpozdW8HVUwunWxCXM5ZPML6VgQ7bOlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dr5WeUC4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dr5WeUC4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555C1C116B1;
	Mon, 22 Jul 2024 15:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721663760;
	bh=X1Vs1TjSo1mfyiyKma36A8jJLx+1DJIAtt7W61MKNrw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Dr5WeUC4SdxG6zVUQPUdJX9H5xqGCb1oQ0o7JYDTOItJGgQbIMrnEwpFREdJDwWK7
	 NXADP+4531ERfBIQAiAXi1PIQpB8ScKCh78Du7oLu9oe+eRBPeEnlFbw233Q9RIutv
	 QqyQSuF7QIGntiiw0ZMzqWKnI3ty0L8Sq3EinHor7O3MnHm5SG9T2fZcachicKpjTG
	 sDCaMV9pbNWH9SMS1rDK3IgFhu/9ymMvNlLxHsRZCvl8udRKZnBmxbQeMf/qhvbAnF
	 /ziiuVLebga4lYM+o7qekoGjn+02m3xDPfv4ef1aBbIUyxEeYSvtHp6N+q1l6iMnqn
	 97K59BUUvltJw==
Message-ID: <4f926139-2872-4869-8ece-fd72cec3c83a@kernel.org>
Date: Mon, 22 Jul 2024 17:55:58 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] mptcp: pm: reduce entries iterations on
 connect
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20240719-mptcp-pm-refact-connect-v1-1-1027d648a65f@kernel.org>
 <45cd30d3-7710-491c-ae4d-a1368c00beb1@redhat.com>
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <45cd30d3-7710-491c-ae4d-a1368c00beb1@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo,

Thank you for the review!

On 22/07/2024 17:14, Paolo Abeni wrote:
> On 7/19/24 16:26, Matthieu Baerts (NGI0) wrote:
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index 1b0e1617e90a..9fed7c92e52b 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -633,8 +633,9 @@ static void mptcp_pm_nl_subflow_established(struct
>> mptcp_sock *msk)
>>    */
>>   static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
>>                            struct mptcp_addr_info *remote,
>> -                         struct mptcp_addr_info *addrs)
>> +                         struct mptcp_pm_addr_entry *entries)
>>   {
>> +    struct mptcp_pm_addr_entry new_entry;
>>       struct sock *sk = (struct sock *)msk;
>>       struct mptcp_pm_addr_entry *entry;
>>       struct mptcp_addr_info mpc_addr;
>> @@ -655,14 +656,14 @@ static unsigned int
>> fill_local_addresses_vec(struct mptcp_sock *msk,
>>               continue;
>>             if (msk->pm.subflows < subflows_max) {
>> -            msk->pm.subflows++;
>> -            addrs[i] = entry->addr;
>> +            memcpy(&new_entry, entry, sizeof(new_entry));
>>                 /* Special case for ID0: set the correct endpoint */
>>               if (mptcp_addresses_equal(&entry->addr, &mpc_addr,
>> entry->addr.port))
>> -                addrs[i].id = 0;
>> +                new_entry.addr.id = 0;
>>   -            i++;
>> +            msk->pm.subflows++;
>> +            entries[i++] = new_entry;
> 
> 'new_entry' is escaping the rcu protected section, dereferencing
> 'entries' after the rcu unlock below could cause UaF.
> 
> Note, AFAICS we already have a similar problem in select_local_address().

Good catch!

And with select_signal_address() since the beginning as well, no?

> One possibility would be to do a deep copy of mptcp_pm_addr_entry, but
> that will waste a lot of memory on the stack. What about to copy the id
> separately?

Is it not what is already done here? Before, only 'entry->addr' was
copied, now the whole 'entry' is duplicated with the 'memcpy()' call
above. Is it not enough?

I'm doing that because we also need the 'flags' and 'ifindex' info from
this structure -- which has 3 additional pointers we don't need, but I
thought it was OK to re-use it -- on top of the address we had before.

BTW, I just realised the copy is done twice (entry -> new_entry ->
entries[i]). Same below. I can fix that.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

