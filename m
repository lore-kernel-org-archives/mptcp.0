Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80EC350D4C
	for <mptcp@lists.linux.dev>; Tue, 11 Nov 2025 10:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858319; cv=none; b=Z7f9iF9bF531y/LvN+vyz/kVm4d5qhPr0xPz8PfQLEm8asylYrNxO/cipdn2w8aO0dix7KCGRHANQRkupaKbZYPNmePNYBINXynSiTrA0bKVdqFx3vPnpAa8WRvbczPjfWhJDFoBTSYzIhIOpZO07ejUfRiBQKko7JTxFpFXCcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858319; c=relaxed/simple;
	bh=5hEdG+A+Il2ieHEui5zA/OTCr9fEt7cv7q6MyF3+kA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uoQsJmwGRkUOz7cfgaJFcLXLhtt9NXQj3eLeS3nUUifbc6cwmAUbRFjS4rCm/aMAwIAiHbFN8MT1N/DHmKeKVmK54gd1oMPKPiE03OMPOfeq0b8l65P6xMk0dy2omFH2vnbaUCA0kjMQY6dJvfMQ/E1rZHYlPy+g1CkebJEnS7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I89qZfGP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I89qZfGP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2C9C19425;
	Tue, 11 Nov 2025 10:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762858319;
	bh=5hEdG+A+Il2ieHEui5zA/OTCr9fEt7cv7q6MyF3+kA4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I89qZfGPYFFY8TR8ms0GOi9Y0Z/ro6f8SONq/M53Xnjs0MwxDO34pzHiRWJLZzBOI
	 zz9Yo54+LK2bOAfq2IgAKN7eH9sPZxystyElokj79HAjzutU0efCBbVPXzRNCFMRXE
	 Re8xWEIjB0Ud4T8PAZtGX51SE2/QegzXgsKMEGcdKqE+ApClU88y7qneE+AWi/xcna
	 0xe9PdCxRhQNHyPmIlK+HnfMQiMUc32GVoCdgh5ja586yaUMTqIculOuOjU86sXy7u
	 jeJ/Tmo1WXf7A9/ags4A/D7qeZ/kI1Dvv6Z7lapAU2JDSOo8SjsREeXyx+2G/a1h4d
	 xp/SzEyk4SaHQ==
Message-ID: <bf49af1b-1a43-4e4c-a716-64eda20a7773@kernel.org>
Date: Tue, 11 Nov 2025 11:51:57 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 1/4] selftests: mptcp: join: properly kill
 background tasks
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20251108-slft-timeout-stats-v1-0-c2234d277318@kernel.org>
 <20251108-slft-timeout-stats-v1-1-c2234d277318@kernel.org>
 <d5ef4083df02cc56e51170ec906eeaea78443c84.camel@kernel.org>
 <894506e8-df54-4fb7-8337-c5fdc99ecb73@kernel.org>
 <a8768ce5597666aca5effeb794303245d8edc67c.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <a8768ce5597666aca5effeb794303245d8edc67c.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 11/11/2025 09:17, Geliang Tang wrote:
> Hi Matt,
> 
> On Tue, 2025-11-11 at 07:53 +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> Thank you for the reviews.
>>
>> 11 Nov 2025 03:46:06 Geliang Tang <geliang@kernel.org>:
>>
>>> Hi Matt,
>>>
>>> This for this fix.
>>>
>>> On Sat, 2025-11-08 at 15:20 +0100, Matthieu Baerts (NGI0) wrote:
>>>> The 'run_tests' function is executed in the background, but
>>>> killing
>>>> its
>>>> associated PID would not kill the children tasks running in the
>>>> background.
>>>>
>>>> To properly kill all background tasks, 'kill -- -PID' could be
>>>> used,
>>>> but
>>>> this requires kill from procps-ng. Instead, all children tasks
>>>> are
>>>> listed using 'ps', and 'kill' is called with all PIDs of this
>>>> group.
>>
>> (...)
>>
>>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>>>> b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>>>> index ce6c92826be7..91ec75ddcb96 100644
>>>> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>>>> @@ -359,6 +359,27 @@ mptcp_lib_kill_wait() {
>>>>     wait "${1}" 2>/dev/null
>>>>  }
>>>>  
>>>> +# $1: PID
>>>> +mptcp_lib_pid_list_children() {
>>>> +   local curr="${1}"
>>>> +   # evoke 'ps' only once
>>>> +   local pids="${2:-"$(ps o pid,ppid)"}"
>>>> +
>>>> +   echo "${curr}"
>>>> +
>>>> +   local pid
>>>> +   for pid in $(echo "${pids}" | awk "\$2 == ${curr} { print
>>>> \$1 }"); do
>>>> +       mptcp_lib_pid_list_children "${pid}" "${pids}"
>>>
>>> To be honest, I don't understand why this
>>> mptcp_lib_pid_list_children
>>> function is calling itself here. Is this recursion?
>>
>> Yes it is a recursion: children processes can have children ones.
>>
>> mptcp_lib_pid_list_children() will print the PID it is called with,
>> and call
>> itself with all children (can be none).
>>
>> In our case with mptcp_join.sh, it means getting the run_tests job
>> plus
>> the other background tasks: mptcp_connect (x2), the timeout, and
>> eventually the task modifying the endpoints.
> 
> Thanks for your explanation, this patch looks good to me.
> 
> I'll reply my RB tag in the cover letter.
> 
> And for patch 6 of "selftests: mptcp: join: fix some flaky tests"
> sending to -net too.

Thank you for that! Note that I sent it directly to 'net' because it was
"simple", and other patches depend on it: we already have quite a few
patches in the queue, probably better not to delay some even longer.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

