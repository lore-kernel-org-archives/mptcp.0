Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B11146A7B
	for <mptcp@lists.linux.dev>; Thu,  8 Aug 2024 10:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723112229; cv=none; b=nxCi0sxQymV+2pPVTyQjA9EN/go7yQ36WfE5NDnlWUAZWE6Kn8C6KRQQEHtU8yWUxAhCgunprayPCC77JYMtvbng4k2XQc1WTFkFshptK8SWZkIRlr8UwcNwn74uvabfdQwiDndRetC5MjTNXw/cR+s/vnfcfUekfyOHHTcb8qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723112229; c=relaxed/simple;
	bh=0GOw89696rP6t7jE9JlvCXXy3I+eNVK4MdQi+t15XkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ICfsBbqF5ik0BqiDGUcIsRvDgB+doSfSY6NrJtXkALkDcmhbXhBfDPy3K/vr0wddfhob7SeWk7T6NPqylYssnx1wt2Jo4GICX4XcTYHjZjBdrBvlzIrPcaY2wajROxx85PSXk/oPtaLDIt4uvJjUeQ3WtW5ToO+SZbYdroThfLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l59SuEkU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l59SuEkU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACDFC32782;
	Thu,  8 Aug 2024 10:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723112229;
	bh=0GOw89696rP6t7jE9JlvCXXy3I+eNVK4MdQi+t15XkA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=l59SuEkUMOhfjR9rklZIvPX3ARpUmxqGP6d+ftbl4/JyjMQzuhDmE9FKrBkgVlk0y
	 s7XuTpyfUJIRPHMBkKBQXyWps7MGxq7rTkkGKpI3tzgSqyMLeiKF2eY/8ybDA+xDjW
	 SRm+KXOCEmuKGJ3GRmSdXKZ1MEH+WFW6x17kcPMeaLjgmBivQ7KnlCb0gIvztuyQkQ
	 EKCvBELfMt+AmpXVVWsqRMhJyj+v968t0+yBK3khzJmPzo20vIAef/cb+g98oJ07hs
	 YTJgZEG8Zoq5Pya1uCHHLWHmRZ9f0iJZ+qgl53E9XB5IhaYUqQcar/tr5WOJfoQjnD
	 rhVw/w1qXAZSg==
Message-ID: <ef3e8f6d-18a5-4ffd-939d-c3d0c650fd39@kernel.org>
Date: Thu, 8 Aug 2024 12:17:06 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 1/8] selftests: mptcp: join: no extra msg if
 no counter
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <20240806-mptcp-join-tx-mib-v3-0-c3b54d2099e9@kernel.org>
 <20240806-mptcp-join-tx-mib-v3-1-c3b54d2099e9@kernel.org>
 <2c144f50dc8e6f92e1bd1569802ec75f362a9ec9.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2c144f50dc8e6f92e1bd1569802ec75f362a9ec9.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

Thank you for the review!

On 08/08/2024 04:38, Geliang Tang wrote:
> Hi Matt,
> 
> Thanks for these patches.
> 
> On Tue, 2024-08-06 at 13:18 +0200, Matthieu Baerts (NGI0) wrote:
>> The checksum and fail counters might not be available. Then no need
>> to
>> display an extra message with missing info.
>>
>> While at it, fix the indentation around, which is wrong since the
>> same
>> commit.
>>
>> Fixes: 47867f0a7e83 ("selftests: mptcp: join: skip check if MIB
>> counter not supported")
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> index 01c1e0871aca..a1f80dac59a7 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> @@ -1112,7 +1112,7 @@ chk_csum_nr()
>>  
>>  	print_check "sum"
>>  	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtDataCsumErr")
>> -	if [ "$count" != "$csum_ns1" ]; then
>> +	if [ -n "$count" ] && [ "$count" != "$csum_ns1" ]; then
> 
> We have checked [ -z "$count" ] in mptcp_lib_get_counter() already, so
> I think no need to double check it here. Can we just let
> mptcp_lib_get_counter() return "0" in this [ -z "$count" ] case, then
> we can drop all these [ -n "$count" ] or [ -z "$count" ] (like in
> chk_cestab_nr()) checks after mptcp_lib_get_counter()? WDYT?

I don't think we can do that: mptcp_lib_get_counter() will return
nothing if the counter doesn't exist: if the kernel being used doesn't
support it. If it is our CI running the tests, there will be a failure
thanks to "mptcp_lib_fail_if_expected_feature()", but only with *our*
CI, because "SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES" is set to 1.

So here, we need to check if '$count' is not empty, before comparing it
with '$csum_ns1'. If it is empty, the check will be skipped (see 4 lines
below), but we don't want to print a useless "extra message" in this
case, with just "ns1=".

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

