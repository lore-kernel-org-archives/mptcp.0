Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752CB1E507
	for <mptcp@lists.linux.dev>; Tue, 28 May 2024 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909983; cv=none; b=upltKLMkv8mOCUzpGmTe81p0lzYwuKq/OFJq7O+DHTSsDWN/oMauHMmjIR9QyT086vzfJJbnJuNRyUUTm7XMBPiLjgh3E+5IN+qZFeeqBMG5dZqu3eZ2M+AAPSdOVJRm0fmCYsRcMRhHQZCt0EA6Dts+qy/xLR9A0rF6JqkQnF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909983; c=relaxed/simple;
	bh=fjuGUuDpPJy0m40zuBD0x41rbmCFboVmX2dJA/v+iLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mGWKOHzznsl6FJexYxeIr/kgwxpAgQmiJiYL1baY1VpNzpfBWF+D9duApNocq9AT8k7LQuwUWuOKGlixWXYSEuIbpmM+yzyoFSpTZE7XeMrPMbkzN7CCOETqh7gjiTPB0tym7zn8y4jK4JoyOFEzcRauJ8PhdhwWtyoxH6+7n10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPln9st5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPln9st5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4537FC3277B;
	Tue, 28 May 2024 15:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716909982;
	bh=fjuGUuDpPJy0m40zuBD0x41rbmCFboVmX2dJA/v+iLU=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=iPln9st53M5zCKOhgDIA+3gQGvp7OamVI0X2Q/TRSwD7mAzQ605Z518K0him6jhPT
	 OHLBhwU79g/WjUahAoJCGZ0GOaxdNCQ6qhVa1wrZk69V9h4iRrEgNEqT1pq5cAC9fz
	 4ODIwSiFX9ZI53SJLVSSlfWkbpafZY+6h3nBSHjSBKt/UpFzv+KTajHKO78QDpJfKM
	 E8izl/Dp68Zk1eWQTMebzZLW9++oZ7GeoaAO5LaGmBHJ7gSfPjdXZTn6I6mJdfeU2y
	 HFC++riA0GpGyNCjPGqLFEqOgKTjmqRNPHpFuk+R1yOPDY7is4gVnbbMfgt1fFL4Eo
	 Z7Jhtib5qjmIA==
Message-ID: <be0b8ab8-bff8-4a11-a6bd-fdba6ed36ff5@kernel.org>
Date: Tue, 28 May 2024 17:26:19 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v6 5/9] selftests: net: lib: remove ns from
 list after clean-up
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <20240527-selftests-net-lib-fixes-v6-0-72411ff2460e@kernel.org>
 <20240527-selftests-net-lib-fixes-v6-5-72411ff2460e@kernel.org>
 <312d5bb28672c8bd0eff47fcaf1ea7707bec8d60.camel@kernel.org>
 <a5f1ae57-009b-4a44-93a9-8bfd38ab672b@kernel.org>
 <60d8e4dd2e8bb8671200bf009c7f49d9ec545cec.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <60d8e4dd2e8bb8671200bf009c7f49d9ec545cec.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 28/05/2024 15:18, Geliang Tang wrote:
> On Tue, 2024-05-28 at 12:38 +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> Thank you for your review!
>>
>> On 28/05/2024 05:47, Geliang Tang wrote:
>>> On Mon, 2024-05-27 at 12:58 +0200, Matthieu Baerts (NGI0) wrote:
>>>> Instead of only appending items to the list, remove them when the
>>>> netns
>>>> has been deleted.
>>>>
>>>> By doing that, we can make sure 'cleanup_all_ns()' is not trying
>>>> to
>>>> remove already deleted netns.
>>>>
>>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>>> ---
>>>>  tools/testing/selftests/net/lib.sh | 21 +++++++++++++++++----
>>>>  1 file changed, 17 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/net/lib.sh
>>>> b/tools/testing/selftests/net/lib.sh
>>>> index b2572aff6286..c7a8cfb477cc 100644
>>>> --- a/tools/testing/selftests/net/lib.sh
>>>> +++ b/tools/testing/selftests/net/lib.sh
>>>> @@ -125,6 +125,20 @@ slowwait_for_counter()
>>>>  	slowwait "$timeout" until_counter_is ">= $((base +
>>>> delta))"
>>>> "$@"
>>>>  }
>>>>  
>>>> +remove_ns_list()
>>>> +{
>>>> +	local item=$1
>>>> +	local ns
>>>> +	local ns_list=("${NS_LIST[@]}")
>>>> +	NS_LIST=()
>>>> +
>>>> +	for ns in "${ns_list[@]}"; do
>>>> +		if [ "${ns}" != "${item}" ]; then
>>>> +			NS_LIST+=("${ns}")
>>>> +		fi
>>>> +	done
>>>> +}
>>>> +
>>>>  cleanup_ns()
>>>>  {
>>>>  	local ns=""
>>>> @@ -136,6 +150,8 @@ cleanup_ns()
>>>>  		if ! busywait $BUSYWAIT_TIMEOUT ip netns list \|
>>>> grep -vq "^$ns$" &> /dev/null; then
>>>>  			echo "Warn: Failed to remove namespace
>>>> $ns"
>>>>  			ret=1
>>>> +		else
>>>
>>> nit: Should we also remove ns_list when "ip netns list" is busy? Or
>>> should we not delete ns when "ip netns list" is busy?
>>>
>>> I think we should do these two commands together:
>>>
>>> 	ip netns delete "${ns}" &> /dev/null || true
>>> 	remove_ns_list "${ns}"
>>>
>>> I'm not sure. WDYT?
>>
>> Good point, I'm not sure either. I kept it in the list because in
>> case
>> of errors, the caller could still get the list of NS that have been
>> created, but not deleted yet.
>>
>> To be honest, I don't think any actions should be done on the NS
>> after
>> having called cleanup: it would probably better to kill all attached
>> processes before that, and not retry later after errors and a kill.
>> But
>> I didn't want to change this logic as there might be other impacts.
>> So
>> at least here, we let the responsibility to the caller, and it can
>> call
>> cleanup_all_ns() again in case of errors. WDYT?
> 
> If so, I think this is better:
> 
>         for ns in "$@"; do
>                 [ -z "${ns}" ] && continue
>                 ip netns delete "${ns}" &> /dev/null || true
>                 remove_ns_list "${ns}"
>                 if ! busywait $BUSYWAIT_TIMEOUT ip netns list \| grep -
> vq "^$ns$" &> /dev/null; then
>                         echo "Warn: Failed to remove namespace $ns"
>                         ret=1
>                 fi  
>         done

Sorry, I was not clear enough: I wanted to say that I think it is better
to keep "remove_ns_list" in the "else", only to remove the netns from
the list if it has been deleted. By doing that, the caller can call
cleanup_all_ns() again, after having stopped everything.

(That's a detail, I guess the removal should not fail, and if it does,
the caller should adapt the code to make sure the clean doesn't fail.)

> If you agree, please update this when merging it. No need to send a v7.

Thanks! I will wait for your feedback on what is above before applying
this series (even if we can always have squash-to patches later).

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

