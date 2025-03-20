Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE5E1EB5CF
	for <mptcp@lists.linux.dev>; Thu, 20 Mar 2025 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742499530; cv=none; b=cYMwa9vewnHgPRelO2YSS9pVRPX9uuQBYbgv7xUz7xGbbutVcImAi9JW3WZfXFkGxyparVYirUbmoD1d6684DjYX9gTecmrxfztQqz5NmF5HPPBD2gpW+h02yp0h9a9NmROoNkzHByxi4g/wPBywqvL9CyFpuoekHq71rtJk+Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742499530; c=relaxed/simple;
	bh=LtZtg7vasHkn+Yp1gfbKW1Ha84H3BzMCD8oThLFFQok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptb8qbCFY26EaU56fKgwLp9uGjNkXEgNY1jMKKihL24ZE6B/tx/bg1t1ZAqvcxmhrsE7jwosIMuO0sEHbEVtpPwzgD2LndVTDzrAVru1vSt0foLqq3E3sSrreS9VAY52OvA/jJT7kbzbyAEfLtLUU8F2lewZ+MB3WJxO3Aa4718=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EowZLwy8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EowZLwy8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE16C4CEDD;
	Thu, 20 Mar 2025 19:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742499529;
	bh=LtZtg7vasHkn+Yp1gfbKW1Ha84H3BzMCD8oThLFFQok=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EowZLwy8gIkDj6ByeU2FB93i5Bl48qMsZXE/0mIUiuPGvdW7s0kCuvH9761tJD+ft
	 hVcBfX3YDW6XXiVAmb2RogX002wMNrOAX9uR4//PFRj3W6hVq384zxuKS4NiSWng6I
	 cpIeRkD+nJ5q/GuR9i2jrzYIXT18/ui6TE1y0MCtef8wBH0uKnlv6wnacly5nbFoF5
	 zs8839dCQ0oXidS8U53BavYCFwBQcEjC3yLAL+WFB7UtAZEylAi4aDzA0hWDTgYTZ6
	 BlL5IPY6kCVP2KnmEo4bLk5o3E5X/PKHrJnYnD+JvTfNf7ZkuY34Jprrn4iLTrImOS
	 y4400GYJ1KmwQ==
Message-ID: <4d1f96d3-b21d-458a-81b6-491a63776124@kernel.org>
Date: Thu, 20 Mar 2025 20:38:44 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v1 3/8] Squash to "selftests/bpf: Add bpf
 scheduler test"
Content-Language: en-GB, fr-BE
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1741226722.git.tanggeliang@kylinos.cn>
 <c02d0f8555c7427d58155d34709f2c8250c8ee2c.1741226722.git.tanggeliang@kylinos.cn>
 <321b3cb7-2bbf-1e93-7f92-9893caee01a7@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <321b3cb7-2bbf-1e93-7f92-9893caee01a7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 18/03/2025 02:11, Mat Martineau wrote:
> On Thu, 6 Mar 2025, Geliang Tang wrote:
> 
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>
>> A cleanup, move netns_new() out of sched_init().
>>
>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>> ---
>> .../testing/selftests/bpf/prog_tests/mptcp.c  | 22 +++++++++----------
>> 1 file changed, 10 insertions(+), 12 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/
>> testing/selftests/bpf/prog_tests/mptcp.c
>> index ac6f6a6f7700..bd824b19ee13 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
>> @@ -562,23 +562,16 @@ static void test_iters_subflow(void)
>>     close(cgroup_fd);
>> }
>>
>> -static struct netns_obj *sched_init(char *flags, char *sched)
>> +static int sched_init(char *flags, char *sched)
>> {
>> -    struct netns_obj *netns;
>> -
>> -    netns = netns_new(NS_TEST, true);
>> -    if (!ASSERT_OK_PTR(netns, "netns_new"))
>> -        return NULL;
>> -
>> -    if (endpoint_init("subflow", 2) < 0)
>> +    if (endpoint_init(flags, 2) < 0)
>>         goto fail;
>>
>>     SYS(fail, "ip netns exec %s sysctl -qw net.mptcp.scheduler=%s",
>> NS_TEST, sched);
>>
>> -    return netns;
>> +    return 0;
>> fail:
>> -    netns_free(netns);
>> -    return NULL;
>> +    return -1;
> 
> A small thing: since there's now only the 'return' on this error path, I
> suggest removing the goto and directly returning -1 above. Matthieu do
> you want to do this when applying, or just leave it as-is?

I did the modification, but I missed the fact SYS() still needs the
'fail' label. So I just added these two commit to keep the 'fail' label,
and to return -1 directly.

a7522f3888cd: Revert "Squash to "selftests/bpf: Add bpf scheduler test""
cc33eee80a21: Squash to "selftests/bpf: Add bpf scheduler test"

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

