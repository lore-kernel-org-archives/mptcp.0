Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37E926CE25
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 09:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026209; cv=none; b=XvWkKncgY5jAvyyLrp2WQGtE0I7BGoWv0b0jXtPPRvZIdNSpXx58vxlKjFtVAtdfb/DRCfd8J4WJqLeoXA3GnjKN4QAV4QH9YKHvIeZrl5InuPTJ+UJuiHUXOZetUyw4af4XyA235QrqIpK5VmOoEVciXfErOj9YUgXOHmJIlf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026209; c=relaxed/simple;
	bh=ND58m9LQNOT9I+IJKSjrmCEENK+6u9F6+NlV+zF9OE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=XiOJVz2HrsRAXcBd8OsjPiBLW7SK3weJRFs/yzE33EngW4UAsZRHqGQpMU2FhlHdt/iuB2DZ1y1km6HBvJUo3H5XWRDoHXuozqkyQk0dmqpyECXkX2SIHNvXBMsuHc1rvDOVd5kBbFYRhALyxkRIv2sPxFKHZAGQwS4xAsn2S2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeCTsUn6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeCTsUn6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B0CC4CEF8;
	Thu, 13 Nov 2025 09:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763026208;
	bh=ND58m9LQNOT9I+IJKSjrmCEENK+6u9F6+NlV+zF9OE0=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=WeCTsUn64SahNkngkSSDJEQ5UEqE4Etp+S99osKvaj508ABxqBHS9MMc2ER5jaFf5
	 rCGBL+dFR4K57aXPlQPlZbo89aFiiKlL0KJvPHneuzaVEGxY2IBwbRw9GP8qRBY050
	 ZlKpxZpJfPawv+8AJGFNd1jnNrS9HfXsFvyu1Cyb1ZZX/RwpwphKKNf/fDYVgoRxrI
	 V/Vtk0u2ALlob4OVUv7GDltfMcfhG1RV+ebDf4DPeB8bzMnflCGeypTMds1l16xXEo
	 38mLOwLKzZtJ91EqgAj04nk8MIS0r7NnALeW2LB5vFaE4q8GA4Sayrmu4g3jWTkb+O
	 /qBUCvHXiYW2Q==
Message-ID: <4a5e2978-077c-450e-ae60-c28c465e5f7f@kernel.org>
Date: Thu, 13 Nov 2025 10:30:05 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 4/4] selftests: mptcp: get stats just before
 timing out
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>
References: <20251108-slft-timeout-stats-v1-0-c2234d277318@kernel.org>
 <20251108-slft-timeout-stats-v1-4-c2234d277318@kernel.org>
 <45c6a268-3501-47da-b1ef-fbf3012a791c@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <45c6a268-3501-47da-b1ef-fbf3012a791c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 13/11/2025 08:25, Paolo Abeni wrote:
> On 11/8/25 3:20 PM, Matthieu Baerts (NGI0) wrote:
>> Recently, some debugging happened around a test that was timing out. The
>> stats were showing connections being closed which was confusing because
>> the closing state was caused by the timeout stopping the transfer.
>>
>> To avoid such confusion, the timeout is no longer done per mptcp_connect
>> process, but separately. In case of timeout, the stats are now printed,
>> then the apps are killed.
>>
>> The stats will still be printed after the kill, but that's fine, and
>> this might even be useful, just in case. Timeout should be exceptional.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> This is very useful, thanks!
> 
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_connect.sh | 21 +++++++++-------
>>  tools/testing/selftests/net/mptcp/mptcp_join.sh    | 29 +++++++++++-----------
>>  tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 13 ++++++++++
>>  tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 21 +++++++++-------
>>  tools/testing/selftests/net/mptcp/simult_flows.sh  | 24 ++++++++++--------
>>  5 files changed, 66 insertions(+), 42 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>> index 1149bd150d6a..6bff77ed0a74 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>> @@ -391,26 +391,29 @@ do_transfer()
>>  		mptcp_lib_nstat_init "${connector_ns}"
>>  	fi
>>  
>> -	timeout ${timeout_test} \
>> -		ip netns exec ${listener_ns} \
>> -			./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
>> -				$extra_args $local_addr < "$sin" > "$sout" &
>> +	ip netns exec ${listener_ns} \
>> +		./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
>> +			$extra_args $local_addr < "$sin" > "$sout" &
>>  	local spid=$!
>>  
>>  	mptcp_lib_wait_local_port_listen "${listener_ns}" "${port}"
>>  
>>  	local start
>>  	start=$(date +%s%3N)
>> -	timeout ${timeout_test} \
>> -		ip netns exec ${connector_ns} \
>> -			./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
>> -				$extra_args $connect_addr < "$cin" > "$cout" &
>> +	ip netns exec ${connector_ns} \
>> +		./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
>> +			$extra_args $connect_addr < "$cin" > "$cout" &
>>  	local cpid=$!
>>  
>> +	mptcp_lib_wait_timeout "${timeout_test}" "${listener_ns}" \
>> +		"${connector_ns}" "${port}" "${cpid}" "${spid}" &
> 
> I'm still debugging some timeouts caused by `${timeout_poll}`. In such
> cases the process still terminates and closes the relevant fd. I'm
> wondering additionally setting ${timeout_test} to a lower value of
> ${timeout_poll}?
${timeout_test} is supposed to be a safeguard, just in case
${timeout_poll} is not enough. I think it might be better to call 'ss'
from mptcp_connect.c in case of timeout: WDYT?

> BTW I'm testing with CONFIG_PREEMPT=y and possibly I'm seeing the
> timeout due to such setting triggering some race we don't observe with
> vng defaults: it's very easily reproducible on mptcp_connect.sh
> "disconnect" case.

Arf, maybe not a new issue... Thank you for looking at that!

The MPTCP CI and my syzkaller instances are all using
CONFIG_PREEMPT_VOLUNTARY=y. Should I change that? Or at least have a mix
in the Syzkaller instances?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

