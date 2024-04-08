Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE59914600C
	for <mptcp@lists.linux.dev>; Mon,  8 Apr 2024 19:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712606327; cv=none; b=Qvu7Yrl5vGWwzuq7Xix13VA7Cx5kLBbsV9WEDuutBjiRnVCk1RZ7YtyIH+E3AcUEONncT9LxxAFtYa6lQEIFAcQGLCpSBEjX9lCHZngrs2Mo4CW86ZDjqeMzVRfd48lRApeJV9ZH4ZC5nuJb5s5aX2cwdbS8Hu4Cq0SpKYVrrJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712606327; c=relaxed/simple;
	bh=cmSzF+8V9oujxQRHDQvR4wmdn7ptLD3WNo4meRApwRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Kyr62uWnt58m9anuALq42sxtaNvfGuOAp+Z2Sa5Pzv30/9Q4QI5i6YVyPMTf9IVIlhw3uXJSb/NBEKrmBGSL138moFfifQftNVKmSV/5jcsFn7bh9FtMZrDrIQRAXvwmn6pUH19Sn8oEFhaOZxpchx4YSzbb98vrrsWBrsKMu9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAMJrUJC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAMJrUJC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D42C433C7;
	Mon,  8 Apr 2024 19:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712606327;
	bh=cmSzF+8V9oujxQRHDQvR4wmdn7ptLD3WNo4meRApwRQ=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=rAMJrUJCuy3IZvrNb7cMopj1bqyXY+tYpfOCEcHmOhIz+hSZn+jwlNyZjfjAHB13Y
	 9oJ3PiAsute6CRs80ZrLzphDCO0MwdXAOf69Bs/my+xE0gl2C1QGJUT8YXUt3DJNiY
	 1NZ+9Zo72xdPpOzUBfE8y+M1MNmuY6kIrnOiYPrKWo8QWgOEO2jMRuKIy6rl8vuiLu
	 Fy7WO5uyHLIOZ4wBmWBruRctk06x18UEUfjzIXZthlwonvKMbtTUHVdrKKIziLxihN
	 Yd/9Gn8n7XRbSgLOqQEyTSoh3M6B/HbyubypClJ8Y2cwF1Nu/v328rIYMZ8tSHidcC
	 daoPj2e7LwNew==
Message-ID: <f44d5960-8aa3-4914-bae3-4f0c072e07b4@kernel.org>
Date: Mon, 8 Apr 2024 21:58:43 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v6 4/9] selftests/bpf: Add MPTCP_SCHED_TEST
 macro
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, Mat Martineau <martineau@kernel.org>
References: <cover.1712235379.git.tanggeliang@kylinos.cn>
 <ae75e2c884eb6a1742af12aaeae9015bb0b4d90c.1712235380.git.tanggeliang@kylinos.cn>
 <5a8d79cb-5dfc-45d8-b708-7d4c798408c7@kernel.org>
 <fb0c45182eaab1fd92f1302113d0298bc16d20f6.camel@kernel.org>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <fb0c45182eaab1fd92f1302113d0298bc16d20f6.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang, Mat,

On 08/04/2024 05:10, Geliang Tang wrote:
> Hi Matt,
> 
> On Thu, 2024-04-04 at 19:52 +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 04/04/2024 15:03, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> This patch defines MPTCP_SCHED_TEST macro, a template for all
>>> scheduler
>>> tests. Every scheduler is identified by argument name, and use
>>> sysctl
>>> to set net.mptcp.scheduler as "bpf_name" to use this sched. Add two
>>> veth net devices to simulate the multiple addresses case. Use 'ip
>>> mptcp
>>> endpoint' command to add the new endpoint ADDR2 to PM netlink.
>>> Arguments
>>> addr1/add2 means whether the data has been sent on the first/second
>>> subflow
>>> or not. Send data and check bytes_sent of 'ss' output after it
>>> using
>>> send_data_and_verify().
>>
>> Should we not squash this in "selftests/bpf: Add bpf scheduler test"
>> as
>> well? We already have a lot of different commits.
>>
>>>
>>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>>> ---
>>>  .../testing/selftests/bpf/prog_tests/mptcp.c  | 30
>>> +++++++++++++++++++
>>>  1 file changed, 30 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>> b/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>> index ffcd5ebe38b9..8a6b09a97698 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>> @@ -498,6 +498,36 @@ static void test_default(void)
>>>  	cleanup_netns(nstoken);
>>>  }
>>>  
>>> +#define MPTCP_SCHED_TEST(name, addr1, addr2)			\
>>> +static void test_##name(void)					\
>>> +{								\
>>> +	struct mptcp_bpf_##name *skel;				\
>>> +	struct nstoken *nstoken;				\
>>> +	struct bpf_link *link;					\
>>> +	struct bpf_map *map;					\
>>> +								\
>>> +	skel = mptcp_bpf_##name##__open_and_load();		\
>>> +	if (!ASSERT_OK_PTR(skel, "open_and_load " #name))	\
>>> +		return;					
>>> 	\
>>> +								\
>>> +	map = bpf_object__find_map_by_name(skel->obj, #name);	\
>>> +	link =
>>> bpf_map__attach_struct_ops(map);			\
>>> +	if (!ASSERT_OK_PTR(link, "attach_struct_ops " #name))	\
>>> +		goto skel_destroy;				\
>>> +								\
>>> +	nstoken = sched_init("subflow", "bpf_" #name);		\
>>> +	if (!ASSERT_OK_PTR(nstoken, "sched_init " #name))	\
>>> +		goto link_destroy;				\
>>> +								\
>>> +	send_data_and_verify(#name, atoi(#addr1), atoi(#addr2));\
>>
>> Can you not use the values of addr1 and addr2 directly as number
>> instead
>> of string + atoi()?
>>
>>> +								\
>>> +	cleanup_netns(nstoken);				
>>> 	\
>>> +link_destroy:							\
>>> +	bpf_link__destroy(link);				\
>>> +skel_destroy:							\
>>> +	mptcp_bpf_##name##__destroy(skel);			\
>>> +}
>>
>> I don't mind having functions defined in macros, but I think we
>> should
>> try to reduce their size to the minimum (if possible) because they
>> are
>> hard to read and debug in case of error.
>>
>> Here, do you think we could have a smaller macro passing the name as
>> a
>> string (for the error messages) and the different functions pointers
>> you
>> need to a new helper? (+ using generic skel structure?)
> 
> Thanks for your review, it's very useful. v7 is sent, address all your
> comments except this one. I didn't got it, please give me more details
> about this.
My comment was similar to the one from Mat:

https://lore.kernel.org/mptcp/f9daffc3-c1a6-0ec3-f821-107ab97f551c@kernel.org/

In short: macros can be hard to debug.


I also see why you are using a macro here, all these functions are very
similar. Here, there are more functions that can "reduced", so maybe
that's OK?

@Mat: what do you think? Or maybe another idea?

(Or maybe it is possible to have a "small" macro, passing function
pointers to a (proper) helper? But not sure if it is less complex. And
maybe not worth it for the tests.)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

