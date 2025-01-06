Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406F42B9CD
	for <mptcp@lists.linux.dev>; Mon,  6 Jan 2025 09:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736154191; cv=none; b=PtzlKoEBoNF0waktsA7KKW7sfc/2X1pdQfSO6K0G2xHhVSHB3oJkvga7SuN1VkbR+rA8c7thwQu8U6b/0pNAbifLHMXJ6nOjFQVdpU63PidUwj7u+Xd609ra2b1bPwulfDMCRxoYuKjTmmo/iyTX0reLoWhy92u2vPSgWQ89qJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736154191; c=relaxed/simple;
	bh=3DT5F+pe3ZVHVWBRZFqSA6G/09hOkdl12tjeN39g/Yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EDmeEnTqgK7tcem5xG/q2PomnZvIjRmg9cwWZyWe+jc0ZsuNJU1qHXnTEeTiNnkRMTO0qwKRc8Uxu+a8JnOEn59eG/c4lrACcLZLKB7bSnzcqT1vfV6BSp0ccGDnLem2Uk/nVOdcUXaz48Pmh5Wj2qQx3rqZVs8JWkNiHTbHxYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJgaSbzt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJgaSbzt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D88C4CED2;
	Mon,  6 Jan 2025 09:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736154190;
	bh=3DT5F+pe3ZVHVWBRZFqSA6G/09hOkdl12tjeN39g/Yc=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=KJgaSbztGntUdQeNXOz7Kam4h/VFJRBKbPF2fH2pCVZetOzdVjaU84E4bmWC2+99I
	 zFJRGd4/GpdqxZ8qOuOkr9Fsdm5jcJ5r53YCCLcA4J2Ss1bs8hr8O47HZVM/BWdhPA
	 VH/6Bq0zEkW/cAF5pUTY4NW5uwQQIoh8mS8mQMBd+SSBWTkx2TQd6FS+Sm/3MGPSdq
	 8DPTysjL4erMp2lztTElbwZjtj6r8z7YjqnHp6Wk5wj6H+fs4AXVWIi+Mlx0T4i+57
	 JGPESYsY/iezmHNojXuH/UiR96Gc0u70fTmzGYoeMjeRymw8/3b4NAhVRxCED7mMn3
	 NFKE3q+FdgE+A==
Message-ID: <c14cb0e4-b84f-416f-96d7-00314292b921@kernel.org>
Date: Mon, 6 Jan 2025 10:03:08 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v6 3/7] mptcp: pm: improve error messages
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <20241230-genl_req_attr_check-v6-0-3ec9103559e7@kernel.org>
 <20241230-genl_req_attr_check-v6-3-3ec9103559e7@kernel.org>
 <e22df271143ccf0dd9d7f20398c37dcd68db01af.camel@kernel.org>
 <239060ce-34fe-435a-88f4-9e171d7ee0ad@kernel.org>
 <296441f6258e6f112dfca28e6f21a815d9cab598.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <296441f6258e6f112dfca28e6f21a815d9cab598.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/01/2025 09:55, Geliang Tang wrote:
> Happy New Year Matt!

Thank you! :)

Happy New Year as well (even if I should probably say that to you at the
end of January :) )

> On Mon, 2025-01-06 at 09:45 +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 06/01/2025 09:41, Geliang Tang wrote:
>>> On Mon, 2024-12-30 at 14:24 +0100, Matthieu Baerts (NGI0) wrote:
>>>> Some error messages were:
>>>>
>>>>  - too generic: "missing input", "invalid request"
>>>>
>>>>  - not precise enough: "limit greater than maximum" but what's
>>>> the
>>>> max?
>>>>
>>>>  - missing: subflow not found, or connect error.
>>>>
>>>> This can be easily improved by being more precise, or adding new
>>>> error
>>>> messages.
>>
>> (...)
>>
>>>> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
>>>> index
>>>> 9c0bec588c498e0aa78acf4018db509abe90cad2..a8f73b082460ba00f7fa998
>>>> cf76
>>>> 46368f8201e2e 100644
>>>> --- a/net/mptcp/pm_userspace.c
>>>> +++ b/net/mptcp/pm_userspace.c
>>
>> (...)
>>
>>>> @@ -634,6 +638,9 @@ int mptcp_userspace_pm_set_flags(struct
>>>> sk_buff
>>>> *skb, struct genl_info *info)
>>>>  	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr,
>>>> &rem.addr, bkup);
>>>>  	release_sock(sk);
>>>>  
>>>> +	if (ret)
>>>> +		GENL_SET_ERR_MSG(info, "subflow not found");
>>>
>>> I guess you don't want to use "subflow not found" here. I changed
>>> it as
>>> "mp_prio send ack failed" in v7.
>>
>> No, I wanted to use "subflow not found":
>> mptcp_pm_nl_mp_prio_send_ack()
>> will fail only if it cannot find the subflow matching the local and
>> remote attributes.
> 
> My bad, how about using "subflow not found in set_flags" here, and use
> "subflow not found in subflow_destroy" for
> mptcp_pm_nl_subflow_destroy_doit?

I don't think we need a different error message: the userspace will send
a specific Netlink command, and an error can be returned. No need to
mention which command it is I think.

If you prefer, feel free to add a comment above this error here:

/* mptcp_pm_nl_mp_prio_send_ack will fail if it cannot find a subflow */

While at it, if you plan to send a v8, please use 'if (ret < 0)' to
clearly show we are looking at errors. (When the variable is called
'err', that's clearer, but no need to change it here.)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

