Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52C517F6
	for <mptcp@lists.linux.dev>; Thu, 23 May 2024 09:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716456878; cv=none; b=L6zKZRP+hSRNAXA3bUmUF4ld928yugLCUlWPms7PfuAF4n+XjtTwpfHul2/QsnaMryqbgEk0kWz0tBTqK0Fwe2/MtjzGWzN+DiJgBR6qX9GGF2lChJl29a93NCCi1cIrZzb/3nyo2SZvwBjBLHRW6ihLa276bEypA8kBS2zurjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716456878; c=relaxed/simple;
	bh=+NsdWYQIg5HdbUG6r1R/WcZN7jjHcqmqWPStUqI9PzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SNQ40brOrkei58hP1k653S06CZ8qqnJEJU2/66E/Y+XIYGJO9vakSNbq8cVRwGAI6Ad5g8F1710pvkixRN/GpqbJTQTqmbJ3kZ2VZP6PPoDLxfzBKTdVmnoD5Xm1/PvmBVKq0T219wrEWJ63qUCi8lTLw5mlFLSfic8Cd4EDgWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqWNZAOr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqWNZAOr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF65C2BD10;
	Thu, 23 May 2024 09:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716456878;
	bh=+NsdWYQIg5HdbUG6r1R/WcZN7jjHcqmqWPStUqI9PzY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YqWNZAOrccA+8+l6w/GZBX72XPL6wMhRVoFAqklifWDwpVapWodSN6N1Ek6AT2T9F
	 LeG99/XlysdQBgKguqCcO2NOXJhvVqfkXeSGXuMyiiAsWzj5nWegUgwlqrPVxHH5LP
	 tF+tU0gAdRQA/MIMiJjaRdqFIQepsccUjKjblTgS7n+R5TMJKzzNUhIxfDEoAkFqTA
	 vPxdEKOoRi7o2JIMTeJqoQl8ignD1t7+uZ7wy2odld/l0655lrHDBllb1uxslo3MVm
	 g1HfbHLvIQ3du5NnEI1ptuOfkMbe3nzv/472m6JTrgAqAliLtllRYfr6L7gTX8aWEb
	 4Nu7ALsMP4BRg==
Message-ID: <93c1de5e-4196-4d25-93f4-1addb45d7e91@kernel.org>
Date: Thu, 23 May 2024 11:34:35 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 2/4] selftests: mptcp: use setup_ns helper
 in lib.sh
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1716451525.git.tanggeliang@kylinos.cn>
 <644ac151204efcd05b047d4e9b1545747ba785f1.1716451525.git.tanggeliang@kylinos.cn>
 <4fe52b77-75af-42ff-9079-fc61fb2509d8@kernel.org>
 <ee6ae6878137687a0734cd7ea6767a86a8fb21a3.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ee6ae6878137687a0734cd7ea6767a86a8fb21a3.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/05/2024 11:26, Geliang Tang wrote:
> Hi Matt,
> 
> On Thu, 2024-05-23 at 11:18 +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 23/05/2024 10:08, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> This patch includes lib.sh into mptcp_lib.sh, uses setup_ns()
>>> helper
>>> defined in lib.sh to set up namespaces in mptcp_lib_ns_init(). Then
>>> for
>>> each namespace in NS_LIST, run all sysctl commands. This can drop
>>> some
>>> duplicate code.
>>>
>>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>>> ---
>>>  .../testing/selftests/net/mptcp/mptcp_lib.sh  | 19 +++++++--------
>>> ----
>>>  1 file changed, 7 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>>> b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>>> index ad2ebda5cb64..59eb77e7813d 100644
>>> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>>
>>
>> (...)
>>
>>> @@ -412,20 +414,13 @@ mptcp_lib_check_tools() {
>>>  }
>>>  
>>>  mptcp_lib_ns_init() {
>>> -	local sec rndh
>>> -
>>> -	sec=$(date +%s)
>>> -	rndh=$(printf %x "${sec}")-$(mktemp -u XXXXXX)
>>> +	setup_ns "${@}"
>>>  
>>>  	local netns
>>> -	for netns in "${@}"; do
>>> -		eval "${netns}=${netns}-${rndh}"
>>> -
>>> -		ip netns add "${!netns}" || exit ${KSFT_SKIP}
>>> -		ip -net "${!netns}" link set lo up
>>> -		ip netns exec "${!netns}" sysctl -q
>>> net.mptcp.enabled=1
>>> -		ip netns exec "${!netns}" sysctl -q
>>> net.ipv4.conf.all.rp_filter=0
>>> -		ip netns exec "${!netns}" sysctl -q
>>> net.ipv4.conf.default.rp_filter=0
>>> +	for netns in $NS_LIST; do
>>
>> Could you add {} (${NS_LIST}), to keep the same style (and usually
>> recommended in order to avoid typos, etc.)
>>
>> Also, I wonder if it is a good idea to use '${NS_LIST}': it might
>> contain existing netns. e.g. with your patch 3/4, in mptcp_connect,
>> mptcp_lib_ns_init will be called twice, modifying the first netns
>> twice.
>>
>> What if you keep:
>>
>>   for netns in "${@}"; do
>>
>> and use "${!netns}" instead?
> 
> We don't know the name of ns now because "mktemp -u XXXXXX" is executed
> within setup_ns(). So we have to use $NS_LIST.

Will 'setup_ns' not assign the variable names given in parameter? If we
give 'ns1', it will set 'ns1=xxxx'. So we can use '${ns1}' to get the
name. If 'netns="ns1"', we can then get the name with '${!netns}', using
'!' (${!netns}) to resolve the name, no?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

