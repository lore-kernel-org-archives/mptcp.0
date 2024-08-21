Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42D21D12F4
	for <mptcp@lists.linux.dev>; Wed, 21 Aug 2024 23:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724284458; cv=none; b=bN0UQ4v6OEaba9zySNWg4hrS4E/w56demNhMUYYGX4VCD4MqO6w9tNkgzYMXWJFw2QA5Kdij+KR9Yt+aeoeaJm8WK90MW0I4e9EaKvs4U/LZQOBy29RYEokRITF7qx6zdSkkN15rUp+CkuiQouoP07db/jGFeMR6p+X11NuwunQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724284458; c=relaxed/simple;
	bh=0AmG6PMiuEHX4U8gAIkvRz8PtWk3dBE8lZNcn6pusdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZLHHEsh9LmffNvZEk1c/ODKqwZRg5Gjyq4DKy2Sig3saB/GgDt7VSpkOpILh3M/JPOdfVlLV4VYFKqw0kIFgFsj+GR0PMQn8mz7h0/ZKRRkgpWexcIlgs0fgiGdcV67aVOvVVmjhS4cX5XAN+rZj4DQCuIV9S+N7g175k/S0MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LmdZUCBy; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LmdZUCBy"
Message-ID: <f8bc2ce4-e6c5-4a8a-82b0-b01495fc2f80@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724284453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jDF2Oz//renJ6+GfyF5hoUbqLd8wzAv4WupkwSjsbNs=;
	b=LmdZUCByPXbM3tJHz6cH++7Ye8SLhUBQSyMZShw8Bv76RL3eQiBfzE1Fl5mX2EWCCArUKW
	uN0XD4nuMMawA/MOU3jPtXuQY2R6dBFcNoc2sYS5hvPAgM9SYmznKvhz4DIu2Ylmu4+TJD
	QjIK/aE9/FeoAnFxN0xG1ER/HzzvLmU=
Date: Wed, 21 Aug 2024 16:54:07 -0700
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH mptcp-next 2/2] selftests/bpf: Add getsockopt to inspect
 mptcp subflow
To: Matthieu Baerts <matttbe@kernel.org>, Geliang Tang <geliang@kernel.org>,
 mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <cover.1724142917.git.tanggeliang@kylinos.cn>
 <3788544d841aa372a810f2d3dce905612063e872.1724142917.git.tanggeliang@kylinos.cn>
 <407f6a6a-344e-4f12-9293-e43b9a97f8d4@kernel.org>
 <23cffc2904df37874f35f106975fccc962d6cb8e.camel@kernel.org>
 <689e3694-d8f9-4511-8363-6f83a3bb1a1d@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <689e3694-d8f9-4511-8363-6f83a3bb1a1d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/21/24 2:37 AM, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for your reply!
> 
> On 21/08/2024 10:00, Geliang Tang wrote:
>> On Tue, 2024-08-20 at 11:48 +0200, Matthieu Baerts wrote:
>>> On 20/08/2024 10:44, Geliang Tang wrote:
> (...)
> 
>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>>> b/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>>> index 69fdcb28249d..2178db94f764 100644
>>>> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>>> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>>> @@ -383,6 +383,7 @@ static void run_subflow(char *new)
>>>>   {
>>>>   	int server_fd, client_fd, err;
>>>>   	char cc[TCP_CA_NAME_MAX];
>>>> +	unsigned int mark;
>>>>   	socklen_t len;
>>>>   
>>>>   	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1,
>>>> 0);
>>>> @@ -407,6 +408,10 @@ static void run_subflow(char *new)
>>>>   	ASSERT_OK(ss_search(ADDR_1, new), "ss_search new cc");
>>>>   	ASSERT_OK(ss_search(ADDR_2, cc), "ss_search default cc");
>>> I guess the next steps is to remove these 'ss_search()', right?
>> We can keep it for double checks.
> I would not mind, even if 'ss | grep' is used in other BPF tests, but I
> understood from Martin he prefers not to depend on external tools as
> much as possible. It should indeed ease the maintenance.

I would prefer to avoid the 'ss | grep'. The other bpf selftests using this "ss 
| grep" should be in the .sh which is not in the test_progs and not run by bpf 
CI. They are there to loop-waiting for something. The ss usage hopefully will be 
removed when eventually migrating the .sh tests to test_progs. At least the one 
in test_tc_tunnel.sh should be doable once moved to test_progs. Haven't looked 
at the test_xdp_features.sh yet.

Thanks for trying the getsockopt approach and it turns out working well.
