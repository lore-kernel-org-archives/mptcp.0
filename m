Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2322DB795
	for <mptcp@lists.linux.dev>; Fri,  3 Apr 2026 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775206376; cv=none; b=CGUTkx9uuYtgeMBre9oBU3bJyLeLR9mb9ZOtJuGS1i1O2+fEl6TQKkOIepNr8z2HzmQI1KaBRFUXDJyeZaK891H2aSH6ZU2LdolBf5pXVhq0KEvcDPolvz79W42UXv4GtbTqdjt9lLhJyhFQa0tSuLEbx5mc4D5W03wBfETSnpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775206376; c=relaxed/simple;
	bh=LVUDtP0yU8aca2bGxmpjDVUak74/hMqzuPe6uW2sVWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LULk2BSi4Ps/pJG1cQ4HuWs2INCU2VdwTFI9dUQR2jrZAp3lRnN7IsxjUlC8lgzkmOsLS2f3YmarmOnKqdjp3ccRYPOcOpOElyD50sH07VYNaJ0HuWhyj1EoKqybpRPTIjNNZA8+xRjVl/KeBIVSetJES+ptRLIfmWJhD7JjB58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzEYOsSd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzEYOsSd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95AABC19423;
	Fri,  3 Apr 2026 08:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775206375;
	bh=LVUDtP0yU8aca2bGxmpjDVUak74/hMqzuPe6uW2sVWo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dzEYOsSdhFIKF/+2XUVC0V8gCxt5V9WJu+AcG0rAqY9x4T7Zcp7T4MZpulSnmkC7N
	 1sLg/xCywSAm/BvnZWDSi2wW13Bn1mRYiy+SVoar/Gk8hPNVLPxDLpb6kJq6dh1Eet
	 D/GOB5tK0Yan0Qr7ao5ALNBMmoDx8RjbAqDZNsqWqnF4hrHv/0aO6m4tFvfXGxDyz7
	 li+ZdEGXOB/PhKTgb8v1ttiJAnBWs0gwmegA37gOm0LvkSkn2YrHwyjQuhCP+bCYv0
	 JXc77OJ8/Ub1dSdauEEjdIk3+hRBCMSPguRPrRNNQuZxp/Cc1LArlEdy2Tj7XR5HAU
	 wbNboduUwbbRQ==
Message-ID: <694ce322-4fc3-4086-be70-589c1279ef37@kernel.org>
Date: Fri, 3 Apr 2026 10:52:52 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v5 5/5] selftests: mptcp: test transmission with
 small rcvbuf
Content-Language: fr
To: Geliang Tang <geliang@kernel.org>, Gang Yan <gang.yan@linux.dev>,
 mptcp@lists.linux.dev
Cc: pabeni@redhat.com, Gang Yan <yangang@kylinos.cn>
References: <cover.1775033340.git.yangang@kylinos.cn>
 <ee3b64c8f16734f94cb19d2615563c47e688b784.1775033340.git.yangang@kylinos.cn>
 <bceb10c076ca92276779b177150b282f62a0917b.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <bceb10c076ca92276779b177150b282f62a0917b.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 03/04/2026 03:17, Geliang Tang wrote:
> Hi Gang,
> 
> On Wed, 2026-04-01 at 16:54 +0800, Gang Yan wrote:
>> From: Gang Yan <yangang@kylinos.cn>
>>
>> This patch adds a test for transmission with a limited receive
>> buffer.
>>
>> Without the fixes in this set, this test fails with errors:
>>
>>  # 001 4 subflows with reduced rcvbuf
>>  # net.ipv4.tcp_rmem = 4096 4096 4096
>>  #       Info: Test file (size 1024 KB) for client
>>  #       Info: Test file (size 1024 KB) for server
>>  # copyfd_io_poll: poll timed out (events: POLLIN 1, POLLOUT 0)
>>  # copyfd_io_poll: poll timed out (events: POLLIN 0, POLLOUT 4)
>>  # [FAIL] client exit code 2, server 2
>>  # Server ns stats (ns2-qg1Hqo)
>>
>> Co-developed-by: Geliang Tang <geliang@kernel.org>
>> Signed-off-by: Geliang Tang <geliang@kernel.org>
>> Signed-off-by: Gang Yan <yangang@kylinos.cn>
>> ---
>> Notes:
>>
>> Changelog:
>> v5:
>>   - Drop the unnecessary tcp_rmem restore.
>>
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 17
>> +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> index beec41f6662a..a21333424085 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> @@ -4417,6 +4417,22 @@ endpoint_tests()
>>  	fi
>>  }
>>  
>> +rcvbuf_tests()
>> +{
>> +	if reset "4 subflows with reduced rcvbuf"; then
>> +		ip netns exec $ns2 sysctl -w net.ipv4.tcp_rmem="4096
>> 4096 4096"
> 
> Instead of using reset() here, it's better to set this sysctl in a new
> helper - for example, reset_with_tcp_rmem() - as is done in other
> tests.

If there is only one test, I think it is fine to leave this here: at
least it is clear what is being done. A helper only used once just to
set one extra command might not be worth it.

But what you can do is to use 'sysctl -q', like every time 'sysctl' is used.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

